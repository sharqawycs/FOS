/* *********************************************************** */
/* MAKE SURE PAGE_WS_MAX_SIZE = 30 */
/* MAKE SURE TABLE_WS_MAX_SIZE = 4 */
/* *********************************************************** */

#include <inc/lib.h>


uint8* ptr = (uint8* )0x0800000 ;

void _main(void)
{
	char arr[PAGE_SIZE*1024*8];

	
	//	cprintf("envID = %d\n",envID);

	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( myEnv->table_last_WS_index !=  0)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");

	}
	int freeFrames = sys_calculate_free_frames() ;
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;
		arr[PAGE_SIZE*1024*2-1] = -1;
		arr[PAGE_SIZE*1024*3-1] = -1;
		arr[PAGE_SIZE*1024*4-1] = -1;

		arr[PAGE_SIZE*1024*5-1] = -1;
		arr[PAGE_SIZE*1024*6-1] = -1;



		if((freeFrames - sys_calculate_free_frames()) != 6 + 6 + 1)	//1 for disk directory + 6 placement STACK pages + 6 page tables for writing these 6 new stack pages on PF
			panic("Extra/Less memory are wrongly allocated... Table RE-placement shouldn't allocate extra frames") ;

		cprintf("STEP A passed: Dealing with memory works!\n\n\n");

	}
	//cprintf("STEP B: checking the operations with page file... \n");
	{

		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6)		//6 victim page tables should written back into PF
			panic("Victim table is not written back into page file") ;

		usedDiskPages = sys_pf_calculate_allocated_pages();

		if(arr[0] != -1) panic("make sure that you get the existing tables from page file") ;
		if(arr[PAGE_SIZE*1024-1] != -1) panic("make sure that you get the existing tables from page file") ;
		if(arr[PAGE_SIZE*1024*2-1] != -1) panic("make sure that you get the existing tables from page file") ;
		if(arr[PAGE_SIZE*1024*3-1] != -1) panic("make sure that you get the existing tables from page file") ;
		if(arr[PAGE_SIZE*1024*4-1] != -1) panic("make sure that you get the existing tables from page file") ;

		if(arr[PAGE_SIZE*1024*5-1] != -1) panic("make sure that you get the existing tables from page file") ;
		if(arr[PAGE_SIZE*1024*6-1] != -1) panic("make sure that you get the existing tables from page file") ;

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("tables not removed from page file correctly.. make sure you delete table from page file after reading it into memory");

		cprintf("STEP B passed: Dealing with page file works!\n\n\n");

	}
	cprintf("Congratulations!! test table replacement (BASIC Operations) completed successfully.\n");
	return;
}
