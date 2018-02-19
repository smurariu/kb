Given a class:

```csharp
internal class KeySemaphoreProvider
    {
        private readonly int _concurrencyLevel = 2;
        private readonly static ConcurrentDictionary<string, SemaphoreSlim> _semaphores =
            new ConcurrentDictionary<string, SemaphoreSlim>();

        internal KeySemaphoreProvider(int concurrencyLevel = 2)
        {
            _concurrencyLevel = concurrencyLevel;
        }

        internal SemaphoreSlim GetSemaphore(string key)
        {
            SemaphoreSlim connectionSemaphore = new SemaphoreSlim(_concurrencyLevel);

            if (_semaphores.TryAdd(key, connectionSemaphore))
            {
                return connectionSemaphore;
            }
            else
            {
                _semaphores.TryGetValue(key, out connectionSemaphore);
            }
            
            return connectionSemaphore;
        }
    }
```

You can test concurrency like so

```csharp
        [Fact]
        public void ThreadRace_NoTwoThreadsForSameKey()
        {
            KeySemaphoreProvider ksp = new KeySemaphoreProvider(1);

            for (int i = 0; i < 100; i++)
            {
                ManualResetEvent allGo = new ManualResetEvent(false);
                int waiting = 20;
                Thread[] threads = new Thread[20];
                int invocations = 0;
                
                for (int j = 0; j < 20; j++)
                {
                    threads[j] = new Thread(() =>
                    {
                        if (Interlocked.Decrement(ref waiting) == 0) allGo.Set();
                        allGo.WaitOne();
                        var semaphore = ksp.GetSemaphore(i.ToString());
                        semaphore.Wait();

                        Interlocked.Increment(ref invocations);
                        Assert.True(Interlocked.CompareExchange(ref invocations, 1, 1) == 1);
                        Interlocked.Decrement(ref invocations);

                        semaphore.Release();
                    });
                }

                for (int j = 0; j < threads.Length; j++) threads[j].Start();
                for (int j = 0; j < threads.Length; j++) threads[j].Join();

                Assert.True(Interlocked.CompareExchange(ref invocations, 1, 1) == 0);
            }
        }
```