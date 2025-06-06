#include <inc/lib.h>

void _main(void)
{	
	

	
	

	rsttst();
	int Mega = 1024*1024;
	int kilo = 1024;
	void* ptr_allocations[20] = {0};
	{
		int freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[0] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[1] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[2] = malloc(2*kilo);
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[3] = malloc(2*kilo);
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega + 4*kilo,USER_HEAP_START + 4*Mega + 4*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[4] = malloc(7*kilo);
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega + 8*kilo,USER_HEAP_START + 4*Mega + 8*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 2 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[5] = malloc(3*Mega-kilo);
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega + 16*kilo,USER_HEAP_START + 4*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);

		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[6] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega + 16*kilo,USER_HEAP_START + 7*Mega + 16*kilo + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);
	}

	chktst(14);

	return;
}
