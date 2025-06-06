// hello, world
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);

	for (int i = 0; i < 5; ++i) {
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
			x = busy_wait(10000);
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	x = busy_wait(1000000);

}
