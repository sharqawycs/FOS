// hello, world
#include <inc/lib.h>

void
_main(void)
{
	char *str ;
	sys_createSharedObject("cnc1", 512, 1, (void*) &str);
	sys_createSemaphore("cnc1", 1);

	sys_createSemaphore("depend1", 0);

	uint32 id1, id2;
	id2 = sys_create_env("qs2", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	id1 = sys_create_env("qs1", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));

	sys_run_env(id2);
	sys_run_env(id1);

	return;
}
