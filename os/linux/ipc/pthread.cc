#include <cstdio>
#include <pthread.h>

const int THREAD_SIZE = 10;
int sum = 0;
pthread_mutex_t sum_mutex;

void *func(void *arg) {
  int i = *((int *)arg);
  printf("Hello func: %d\n", i);
  pthread_mutex_lock(&sum_mutex);
  printf("Before sum is %d in thread %d\n", sum, i);
  sum += i;
  printf("After sum is %d in thread %d\n", sum, i);
  pthread_mutex_unlock(&sum_mutex);
  pthread_exit(0);
}

int main()
{
  pthread_t th[THREAD_SIZE];
  int indexes[THREAD_SIZE];
  pthread_mutex_init(&sum_mutex, NULL);

  for (int i = 0; i < THREAD_SIZE; ++i) {
    indexes[i] = i;
    int ret = pthread_create(&th[i], NULL, func, (void *)&indexes[i]);

    if (ret) printf("pthread_create error\n");
  }

  // join
  for (int i = 0; i < THREAD_SIZE; ++i)
    pthread_join(th[i], NULL);
  //pthread_exit(NULL);

  pthread_mutex_destroy(&sum_mutex);

  return 0;
}

