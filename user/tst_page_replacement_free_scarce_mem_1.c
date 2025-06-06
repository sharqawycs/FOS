/* *********************************************************** */
/* MAKE SURE PAGE_WS_MAX_SIZE = 15 */
/* *********************************************************** */

#include <inc/lib.h>

char* ptr = (char*) 0xeebfe000 - (PAGE_SIZE) -1;
void _main(void)
{
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
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->__uptr_pws[11].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->__uptr_pws[12].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->__uptr_pws[13].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->__uptr_pws[14].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( myEnv->page_last_WS_index !=  11)	panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}

	// Access stack (take large time stamp)
	env_sleep(6000);

	cprintf("before scarcing memory\n");
	sys_scarce_memory();	// FREEING 50% from allocated pages (11 pages) ==> LRU 6 pages shall be removed
	cprintf("after scarcing memory\n");

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	// FAULT a STACK Page
	char x = *ptr;

	uint32 expectedPages[15] = {0xeebfd000,0x800000,0x801000,0x802000,0x803000,0xeebfc000,0,0,0,0,0,0,0,0,0};

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 15);

//		if( myEnv->__uptr_pws[0].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[1].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[2].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[3].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[4].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[5].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x802000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=  0xeebfc000)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[12].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[13].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");
//		if( myEnv->__uptr_pws[14].empty !=   1)  panic("Page LRU algo failed.. trace it by printing WS before and after page fault");

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 12) panic("wrong PAGE WS pointer location");

	}

	// Checking the PAGE FILE
	// Checking the number of pages freed after the memory being scarce...
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
		if( (freePages - freePagesAfter) != -5 )
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 1] using LRU is completed successfully.\n");

	return;
}

