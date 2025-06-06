// hello, world
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}

		//env_sleep(80000);
		int x = busy_wait(50000000);

}
