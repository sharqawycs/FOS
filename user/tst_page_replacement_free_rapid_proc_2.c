/* *********************************************************** */
/* MAKE SURE PAGE_WS_MAX_SIZE = 16, % = 75*/
/* *********************************************************** */

#include <inc/lib.h>

char arr[PAGE_SIZE*9];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;
char* ptr3 = (char*) 0xeebfe000 - (PAGE_SIZE) -1;

void _main(void)
{

//	cprintf("envID = %d\n",envID);
	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}

	// Create & run the slave environments
	int IDs[4];
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 4; ++i)
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}
	// To check that the slave environments completed successfully
	rsttst();

	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
	// Check the number of pages shall be deleted with the first fault after freeing the process
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(2);

	// FAULT with TWO STACK Pages to FREE the rapid running MASTER process
	char x = *ptr3;

	uint32 expectedPages[16] = {0xeebfc000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0,0,0,0,0,0,0,0,0,0};

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 16);

//		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfc000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[2].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[3].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[4].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[5].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[6].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x802000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[10].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[11].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[12].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[13].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[14].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
	}

	x = *(ptr3-PAGE_SIZE);

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  2) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
		if( (freePagesBefore + pagesToBeDeletedCount - 3) != freePagesAfter )	// 3 => 2 STACK PAGES and 1 CODE page started from the fault of the stack page ALLOCATED
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED for the running RAPID process %d %d", freePagesBefore + pagesToBeDeletedCount, freePagesAfter);
	}

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		expectedPages[6] =  0xeebfb000;
		CheckWSWithoutLastIndex(expectedPages, 16);

//		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfc000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0xeebfb000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[3].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[4].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[5].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[6].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x802000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[10].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[11].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[12].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[13].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[14].empty !=  1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 3) panic("wrong PAGE WS pointer location");
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING RAPID PROCESS 2] using LRU is completed successfully.\n");
	return;
}
