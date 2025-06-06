#include <inc/lib.h>

void _main(void)
{
	int IDs[20];

	// Create & run the slave environments
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 10; ++i)
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}

	// To check that the slave environments completed successfully
	rsttst();

	env_sleep(3000);
	sys_scarce_memory();
	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();

	// Check the number of pages shall be deleted with the first fault after scarce the memory
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(1);

	char arr[PAGE_SIZE*2];
	// Access the created array in STACK to FAULT and Free SCARCE MEM
	arr[1*PAGE_SIZE] = -1;

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
		if( (freePagesBefore + pagesToBeDeletedCount - 1) != freePagesAfter )
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
	}

	env_sleep(80000);
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 2] is completed successfully.\n");
}
