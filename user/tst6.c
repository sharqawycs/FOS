#include <inc/lib.h>

struct MyStruct
{
	char a;
	short b;
	int c;
};
void _main(void)
{	
	

	rsttst();
	
	

	int Mega = 1024*1024;
	int kilo = 1024;
	void* ptr_allocations[20] = {0};

	//[1] Attempt to allocate more than heap size
	{
		ptr_allocations[0] = malloc(USER_HEAP_MAX - USER_HEAP_START + 1);
		tst((uint32) ptr_allocations[0], 0,0, 'b', 0);
	}

	//[2] Attempt to allocate space more than any available fragment
	//	a) Create Fragments
	{
		//2 MB
		int freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[0] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[0], USER_HEAP_START,USER_HEAP_START + PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512+1 ,0, 'e', 0);

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[1] = malloc(2*Mega-kilo);
		tst((uint32) ptr_allocations[1], USER_HEAP_START+ 2*Mega,USER_HEAP_START + 2*Mega+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 512 ,0, 'e', 0);

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[2] = malloc(2*kilo);
		tst((uint32) ptr_allocations[2], USER_HEAP_START+ 4*Mega,USER_HEAP_START + 4*Mega+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1+1 ,0, 'e', 0);

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[3] = malloc(2*kilo);
		tst((uint32) ptr_allocations[3], USER_HEAP_START+ 4*Mega+ 4*kilo,USER_HEAP_START + 4*Mega+ 4*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 1 ,0, 'e', 0);

		//4 KB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[2]);
		tst((sys_calculate_free_frames() - freeFrames) , 1,0, 'e', 0);

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[4] = malloc(7*kilo);
		tst((uint32) ptr_allocations[4], USER_HEAP_START+ 4*Mega+ 8*kilo,USER_HEAP_START + 4*Mega+ 8*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 2,0, 'e', 0);

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[0]);
		tst((sys_calculate_free_frames() - freeFrames) , 512,0, 'e', 0);

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[5] = malloc(3*Mega-kilo);
		tst((uint32) ptr_allocations[5], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 3*Mega/4096 ,0, 'e', 0);

		//2 MB + 6 KB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[6] = malloc(2*Mega + 6*kilo);
		tst((uint32) ptr_allocations[6], USER_HEAP_START+ 7*Mega+ 16*kilo,USER_HEAP_START + 7*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 514+1 ,0, 'e', 0);

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[5]);
		tst((sys_calculate_free_frames() - freeFrames) , 768,0, 'e', 0);

		//5 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[7] = malloc(5*Mega-kilo);
		tst((uint32) ptr_allocations[7], USER_HEAP_START+ 9*Mega+ 24*kilo,USER_HEAP_START + 9*Mega+ 24*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 5*Mega/4096 + 1,0, 'e', 0);

		//2 MB + 8 KB Hole
		freeFrames = sys_calculate_free_frames() ;
		free(ptr_allocations[6]);
		tst((sys_calculate_free_frames() - freeFrames) , 514,0, 'e', 0);

		//4 MB
		freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[8] = malloc(4*Mega-kilo);
		tst((uint32) ptr_allocations[8], USER_HEAP_START+ 4*Mega+ 16*kilo,USER_HEAP_START + 4*Mega+ 16*kilo+ PAGE_SIZE, 'b', 0);
		tst((freeFrames - sys_calculate_free_frames()) , 4*Mega/4096,0, 'e', 0);
	}

	//	b) Attempt to allocate large segment with no suitable fragment to fit on
	{
		//Large Allocation
		int freeFrames = sys_calculate_free_frames() ;
		ptr_allocations[9] = malloc((USER_HEAP_MAX - USER_HEAP_START + 14*Mega));
		tst((uint32) ptr_allocations[9], 0,0, 'b', 0);

		chktst(24);

		return;
	}
}
