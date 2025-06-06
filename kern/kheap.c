#include <inc/memlayout.h>
#include <kern/kheap.h>
#include <kern/memory_manager.h>

// ==================================== kmalloc ====================================

// 256 MB = 256 * 1024 * 1024 bytes = 268,435,456 bytes, 41942016
// 268,435,456 bytes / 4,096 bytes per page = 65,536 pages (if each allocation needs one page "worst case :)" )
#define MAX_HEAP_ALLOCATIONS 65536

// store each allocation info
struct allocation {
    int szInByts; // this allocation size after rounding, look @ saveAllocationInfo
    uint32* vaStart;
};

// Array to store all kmalloc allocations
struct allocation allocations[MAX_HEAP_ALLOCATIONS];
int allocationsCnt = 0;

// TODO: try to optimize using some sort of hashing... "SHARQAWY SHARQAWY SHARQAWY"
int findBestFitRegion(unsigned int szNeeded) {
    int minFit = 268435456, bestGuy = -1, // the most fit space with its address

    curntPageCnt = 0; // how many free pages in the curntFreeSpace

    for (int va = KERNEL_HEAP_START; va < KERNEL_HEAP_MAX; va += PAGE_SIZE) {
        uint32* dummyPT = NULL; // m4 3ayzk aslan
        struct Frame_Info* frameInfo = get_frame_info(ptr_page_directory, (void*)va, &dummyPT); // get the info for the frame in the current va to check if it is available or not

        if (frameInfo == NULL) { // Yesss, i found a free page, count it !!!
//        	curntFreeSpace += PAGE_SIZE;
        	curntPageCnt++;
        } else { // my bad!! the contigios part has ended, so check it and reset the counters
            int curntFreeSpace = curntPageCnt * PAGE_SIZE;
            if (curntFreeSpace >= szNeeded && curntFreeSpace < minFit) {
                bestGuy = va - (curntPageCnt * PAGE_SIZE);
                minFit = curntFreeSpace;

                if(curntFreeSpace == szNeeded) return bestGuy; // YOU ARE THE GIGA CHAD BLOCK, NO BLOCK IS BETTER THAN YOU
            }
            // Reset counters
//            curntFreeSpace = 0;
            curntPageCnt = 0;
        }
    }

    // because the poor loop misses the last block and do not check it
    int curntFreeSpace = curntPageCnt * PAGE_SIZE;
    if (curntFreeSpace >= szNeeded && curntFreeSpace < minFit) {
        bestGuy = KERNEL_HEAP_MAX - (curntPageCnt * PAGE_SIZE);
    }

    return bestGuy; // I AM THE SIGMA ADDRESS o_O
}

// I think here we do not need to check anything becuase we already found a space from the best fit = sharqawy
void allocateAndMap(int startAddress, unsigned int requestedSize) {
    int endAddress = startAddress + ROUNDUP(requestedSize, PAGE_SIZE); // now we have the start and end adresses

    for (int va = startAddress; va < endAddress; va += PAGE_SIZE) {
        struct Frame_Info* newFrame = NULL;

        // remember from the labs?
        allocate_frame(&newFrame);
        newFrame->va = (uint32)va;
        map_frame(ptr_page_directory, newFrame, (void*)va, PERM_WRITEABLE);
    }
}

// For the above struct
void saveAllocationInfo(int startAddress, unsigned int szNeeded) {
        allocations[allocationsCnt].vaStart = (uint32*)startAddress;
        allocations[allocationsCnt++].szInByts = ROUNDUP(szNeeded, PAGE_SIZE);
}


// As a kmalloc, WHAT ACTUALLY I DO??? Ask Sharqawy ^_^
void* kmalloc(unsigned int size) {
    // 1- find an address in kheap using best fit in kernel heap
    int allocationStart = findBestFitRegion(size);

    // 2- NULL if no good space found
    if (allocationStart == -1)
        return NULL; // eshtry ram ziada ya wala!!!

    // 3- allocate and map in the location u found
    allocateAndMap(allocationStart, size);

    // 4- save this allocation data
    saveAllocationInfo(allocationStart, size);

    // 5- pointer for the start of this allocated block
    return (void*)allocationStart;
}


// ==================================== kfree ====================================
void kfree(void* virtual_address)
{
	//TODO: [PROJECT 2025 - MS1 - [1] Kernel Heap] kfree()
	// Write your code here, remove the panic and write your code
	 int size;
	 int found=0;
	 int index=0;
	 uint32 va1 = (uint32)virtual_address;
//	 for(int i=0;i<MAX_HEAP_ALLOCATIONS;i++){ // By Sharqawy
	 for(int i=0;i < allocationsCnt; i++){
		 if ((uint32)virtual_address >= (uint32)allocations[i].vaStart &&
		     (uint32)virtual_address < (uint32)allocations[i].vaStart + allocations[i].szInByts)
		 {
			 size=allocations[i].szInByts;
			 found=1;
			 index=i;
			 va1 = (uint32)allocations[i].vaStart;
			 break;
		 }
	 }
	 if(!found)
		 return;
	 uint32 va2=va1+size;
	 while(va1<va2){
		 unmap_frame(ptr_page_directory, (void*)va1);
		 va1+=PAGE_SIZE;
	 }

	for(int i=index;i<allocationsCnt-1;i++)
	{
		allocations[i].szInByts=allocations[i+1].szInByts;
		allocations[i].vaStart=allocations[i+1].vaStart;
	}
	allocationsCnt--;
}


// ==================================== kheapVA ====================================
unsigned int kheap_virtual_address(unsigned int physical_address)
{
	//TODO: [PROJECT 2025 - MS1 - [1] Kernel Heap] kheap_virtual_address()
	// Write your code here, remove the panic and write your code

	uint32 mask = (PAGE_SIZE - 1);
	uint32 offset = mask & physical_address;

	struct Frame_Info *ptr_frame_info = to_frame_info(physical_address);

	if ((unsigned int)ptr_frame_info->va >= KERNEL_HEAP_START &&
		(unsigned int)ptr_frame_info->va < KERNEL_HEAP_MAX &&
		ptr_frame_info->references != 0)
		return (unsigned int)ptr_frame_info->va + offset;
	//ptr_frame_info return the start reference of the frame so we should add the offset ;

	return 0;
}


// ==================================== kheapPA ====================================
unsigned int kheap_physical_address(unsigned int virtual_address)
{
	if(virtual_address>=KERNEL_HEAP_START&&virtual_address< KERNEL_HEAP_MAX){
		uint32 *ptr_table = NULL;
		struct Frame_Info *finfo = get_frame_info(ptr_page_directory,(void*)virtual_address, &ptr_table );
		if(finfo==NULL){return 0;}
		uint32 PA=to_physical_address(finfo);
		uint32 offset= virtual_address & 0xFFF;
		return PA+offset;
	}
	return 0;
}

// ==================================== krealloc ====================================
void *krealloc(void *virtual_address, uint32 new_size)
{
	panic("krealloc() is not required...!!");
	return NULL;

}
