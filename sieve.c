#include <stdio.h>
int main()
{
	int n = 32;
	int prime[n + 1];

	for (int i = 1; i <= n; i++)
		prime[i] = i;

	for (int i = 4; i <= n; i = i + 2)
		prime[i] = -1;

	for (int i = 6; i <= n; i = i + 3)
		prime[i] = -1;

	for (int i = 10; i <= n; i = i + 5)
		prime[i] = -1;

	printf("Prime numbers are: \n");
	for (int i = 2; i <= n; i++){
		if (prime[i] != -1)
			printf("%d ", i);
	}
}