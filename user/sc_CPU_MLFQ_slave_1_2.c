// hello, world
#include <inc/lib.h>

void
_main(void)
{
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
	for(int i = 0; i < 5; i++)
		sum+=i;

	//int x = busy_wait(RAND(500000, 1000000));
	int x = busy_wait(100000);

	//env_sleep(10);
}
