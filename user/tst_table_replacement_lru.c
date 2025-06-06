/* *********************************************************** */
/* MAKE SURE PAGE_WS_MAX_SIZE = 30 */
/* MAKE SURE TABLE_WS_MAX_SIZE = 5 */
/* *********************************************************** */

#include <inc/lib.h>


uint8* ptr = (uint8* )0x0800000 ;
int i ;
void _main(void)
{
	char arr[PAGE_SIZE*1024*8];

	
	//	cprintf("envID = %d\n",envID);

	
	

	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
		if( myEnv->table_last_WS_index !=  4)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");

	}

	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;


		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
		}
		for (i = 0 ; i < PAGE_SIZE / 2; i++)
		{
			arr[PAGE_SIZE*1024*3 - i] = i * i;
		}
		arr[PAGE_SIZE*1024*5-1] = -1;
		arr[PAGE_SIZE*1024*6-1] = -1;
		arr[PAGE_SIZE*1024*7-1] = -1;

	}
	//cprintf("testing ...\n");
	{
		//cprintf("WS[2] = %x\n", ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) );
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0xee400000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xedc00000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
		if( ROUNDDOWN(myEnv->__ptr_tws[4].virtual_address,1024*PAGE_SIZE) !=  0xee000000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");

		if(myEnv->table_last_WS_index != 3) panic("wrong TABLE WS pointer location");
	}

	cprintf("Congratulations!! test table replacement (LRU alg) completed successfully.\n");
	return;
}
