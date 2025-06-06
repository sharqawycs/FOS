
obj/user/tst_air_clerk:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 e7 05 00 00       	call   80061d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
#include <user/air.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 01 00 00    	sub    $0x19c,%esp
	int parentenvID = sys_getparentenvid();
  800044:	e8 5e 1a 00 00       	call   801aa7 <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	// Get the shared variables from the main program ***********************************

	char _customers[] = "customers";
  80004c:	8d 45 ae             	lea    -0x52(%ebp),%eax
  80004f:	bb b5 22 80 00       	mov    $0x8022b5,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 a2             	lea    -0x5e(%ebp),%eax
  800064:	bb bf 22 80 00       	mov    $0x8022bf,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800079:	bb cb 22 80 00       	mov    $0x8022cb,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80008e:	bb da 22 80 00       	mov    $0x8022da,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  8000a6:	bb e9 22 80 00       	mov    $0x8022e9,%ebx
  8000ab:	ba 15 00 00 00       	mov    $0x15,%edx
  8000b0:	89 c7                	mov    %eax,%edi
  8000b2:	89 de                	mov    %ebx,%esi
  8000b4:	89 d1                	mov    %edx,%ecx
  8000b6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b8:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  8000be:	bb fe 22 80 00       	mov    $0x8022fe,%ebx
  8000c3:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c8:	89 c7                	mov    %eax,%edi
  8000ca:	89 de                	mov    %ebx,%esi
  8000cc:	89 d1                	mov    %edx,%ecx
  8000ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000d0:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  8000d6:	bb 13 23 80 00       	mov    $0x802313,%ebx
  8000db:	ba 11 00 00 00       	mov    $0x11,%edx
  8000e0:	89 c7                	mov    %eax,%edi
  8000e2:	89 de                	mov    %ebx,%esi
  8000e4:	89 d1                	mov    %edx,%ecx
  8000e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e8:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8000ee:	bb 24 23 80 00       	mov    $0x802324,%ebx
  8000f3:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f8:	89 c7                	mov    %eax,%edi
  8000fa:	89 de                	mov    %ebx,%esi
  8000fc:	89 d1                	mov    %edx,%ecx
  8000fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  800100:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  800106:	bb 35 23 80 00       	mov    $0x802335,%ebx
  80010b:	ba 11 00 00 00       	mov    $0x11,%edx
  800110:	89 c7                	mov    %eax,%edi
  800112:	89 de                	mov    %ebx,%esi
  800114:	89 d1                	mov    %edx,%ecx
  800116:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800118:	8d 85 1e ff ff ff    	lea    -0xe2(%ebp),%eax
  80011e:	bb 46 23 80 00       	mov    $0x802346,%ebx
  800123:	ba 09 00 00 00       	mov    $0x9,%edx
  800128:	89 c7                	mov    %eax,%edi
  80012a:	89 de                	mov    %ebx,%esi
  80012c:	89 d1                	mov    %edx,%ecx
  80012e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  800130:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  800136:	bb 4f 23 80 00       	mov    $0x80234f,%ebx
  80013b:	ba 0a 00 00 00       	mov    $0xa,%edx
  800140:	89 c7                	mov    %eax,%edi
  800142:	89 de                	mov    %ebx,%esi
  800144:	89 d1                	mov    %edx,%ecx
  800146:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800148:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  80014e:	bb 59 23 80 00       	mov    $0x802359,%ebx
  800153:	ba 0b 00 00 00       	mov    $0xb,%edx
  800158:	89 c7                	mov    %eax,%edi
  80015a:	89 de                	mov    %ebx,%esi
  80015c:	89 d1                	mov    %edx,%ecx
  80015e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  800160:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800166:	bb 64 23 80 00       	mov    $0x802364,%ebx
  80016b:	ba 03 00 00 00       	mov    $0x3,%edx
  800170:	89 c7                	mov    %eax,%edi
  800172:	89 de                	mov    %ebx,%esi
  800174:	89 d1                	mov    %edx,%ecx
  800176:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800178:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  80017e:	bb 70 23 80 00       	mov    $0x802370,%ebx
  800183:	ba 0a 00 00 00       	mov    $0xa,%edx
  800188:	89 c7                	mov    %eax,%edi
  80018a:	89 de                	mov    %ebx,%esi
  80018c:	89 d1                	mov    %edx,%ecx
  80018e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  800190:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800196:	bb 7a 23 80 00       	mov    $0x80237a,%ebx
  80019b:	ba 0a 00 00 00       	mov    $0xa,%edx
  8001a0:	89 c7                	mov    %eax,%edi
  8001a2:	89 de                	mov    %ebx,%esi
  8001a4:	89 d1                	mov    %edx,%ecx
  8001a6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a8:	c7 85 e3 fe ff ff 63 	movl   $0x72656c63,-0x11d(%ebp)
  8001af:	6c 65 72 
  8001b2:	66 c7 85 e7 fe ff ff 	movw   $0x6b,-0x119(%ebp)
  8001b9:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001bb:	8d 85 d5 fe ff ff    	lea    -0x12b(%ebp),%eax
  8001c1:	bb 84 23 80 00       	mov    $0x802384,%ebx
  8001c6:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001cb:	89 c7                	mov    %eax,%edi
  8001cd:	89 de                	mov    %ebx,%esi
  8001cf:	89 d1                	mov    %edx,%ecx
  8001d1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d3:	8d 85 c6 fe ff ff    	lea    -0x13a(%ebp),%eax
  8001d9:	bb 92 23 80 00       	mov    $0x802392,%ebx
  8001de:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e3:	89 c7                	mov    %eax,%edi
  8001e5:	89 de                	mov    %ebx,%esi
  8001e7:	89 d1                	mov    %edx,%ecx
  8001e9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001eb:	8d 85 bf fe ff ff    	lea    -0x141(%ebp),%eax
  8001f1:	bb a1 23 80 00       	mov    $0x8023a1,%ebx
  8001f6:	ba 07 00 00 00       	mov    $0x7,%edx
  8001fb:	89 c7                	mov    %eax,%edi
  8001fd:	89 de                	mov    %ebx,%esi
  8001ff:	89 d1                	mov    %edx,%ecx
  800201:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800203:	8d 85 b8 fe ff ff    	lea    -0x148(%ebp),%eax
  800209:	bb a8 23 80 00       	mov    $0x8023a8,%ebx
  80020e:	ba 07 00 00 00       	mov    $0x7,%edx
  800213:	89 c7                	mov    %eax,%edi
  800215:	89 de                	mov    %ebx,%esi
  800217:	89 d1                	mov    %edx,%ecx
  800219:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	struct Customer * customers = sget(parentenvID, _customers);
  80021b:	83 ec 08             	sub    $0x8,%esp
  80021e:	8d 45 ae             	lea    -0x52(%ebp),%eax
  800221:	50                   	push   %eax
  800222:	ff 75 e4             	pushl  -0x1c(%ebp)
  800225:	e8 53 15 00 00       	call   80177d <sget>
  80022a:	83 c4 10             	add    $0x10,%esp
  80022d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* flight1Counter = sget(parentenvID, _flight1Counter);
  800230:	83 ec 08             	sub    $0x8,%esp
  800233:	8d 45 93             	lea    -0x6d(%ebp),%eax
  800236:	50                   	push   %eax
  800237:	ff 75 e4             	pushl  -0x1c(%ebp)
  80023a:	e8 3e 15 00 00       	call   80177d <sget>
  80023f:	83 c4 10             	add    $0x10,%esp
  800242:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int* flight2Counter = sget(parentenvID, _flight2Counter);
  800245:	83 ec 08             	sub    $0x8,%esp
  800248:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 29 15 00 00       	call   80177d <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* flight1BookedCounter = sget(parentenvID, _flightBooked1Counter);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 6f ff ff ff    	lea    -0x91(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 11 15 00 00       	call   80177d <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	int* flight2BookedCounter = sget(parentenvID, _flightBooked2Counter);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 5a ff ff ff    	lea    -0xa6(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 f9 14 00 00       	call   80177d <sget>
  800284:	83 c4 10             	add    $0x10,%esp
  800287:	89 45 d0             	mov    %eax,-0x30(%ebp)

	int* flight1BookedArr = sget(parentenvID, _flightBooked1Arr);
  80028a:	83 ec 08             	sub    $0x8,%esp
  80028d:	8d 85 49 ff ff ff    	lea    -0xb7(%ebp),%eax
  800293:	50                   	push   %eax
  800294:	ff 75 e4             	pushl  -0x1c(%ebp)
  800297:	e8 e1 14 00 00       	call   80177d <sget>
  80029c:	83 c4 10             	add    $0x10,%esp
  80029f:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int* flight2BookedArr = sget(parentenvID, _flightBooked2Arr);
  8002a2:	83 ec 08             	sub    $0x8,%esp
  8002a5:	8d 85 38 ff ff ff    	lea    -0xc8(%ebp),%eax
  8002ab:	50                   	push   %eax
  8002ac:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002af:	e8 c9 14 00 00       	call   80177d <sget>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 c8             	mov    %eax,-0x38(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  8002ba:	83 ec 08             	sub    $0x8,%esp
  8002bd:	8d 85 27 ff ff ff    	lea    -0xd9(%ebp),%eax
  8002c3:	50                   	push   %eax
  8002c4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c7:	e8 b1 14 00 00       	call   80177d <sget>
  8002cc:	83 c4 10             	add    $0x10,%esp
  8002cf:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	int* queue_out = sget(parentenvID, _queue_out);
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
  8002db:	50                   	push   %eax
  8002dc:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002df:	e8 99 14 00 00       	call   80177d <sget>
  8002e4:	83 c4 10             	add    $0x10,%esp
  8002e7:	89 45 c0             	mov    %eax,-0x40(%ebp)

	while(1==1)
	{
		int custId;
		//wait for a customer
		sys_waitSemaphore(parentenvID, _cust_ready);
  8002ea:	83 ec 08             	sub    $0x8,%esp
  8002ed:	8d 85 09 ff ff ff    	lea    -0xf7(%ebp),%eax
  8002f3:	50                   	push   %eax
  8002f4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002f7:	e8 da 19 00 00       	call   801cd6 <sys_waitSemaphore>
  8002fc:	83 c4 10             	add    $0x10,%esp

		//dequeue the customer info
		sys_waitSemaphore(parentenvID, _custQueueCS);
  8002ff:	83 ec 08             	sub    $0x8,%esp
  800302:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800308:	50                   	push   %eax
  800309:	ff 75 e4             	pushl  -0x1c(%ebp)
  80030c:	e8 c5 19 00 00       	call   801cd6 <sys_waitSemaphore>
  800311:	83 c4 10             	add    $0x10,%esp
		{
			//cprintf("*queue_out = %d\n", *queue_out);
			custId = cust_ready_queue[*queue_out];
  800314:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800320:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800323:	01 d0                	add    %edx,%eax
  800325:	8b 00                	mov    (%eax),%eax
  800327:	89 45 bc             	mov    %eax,-0x44(%ebp)
			*queue_out = *queue_out +1;
  80032a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80032d:	8b 00                	mov    (%eax),%eax
  80032f:	8d 50 01             	lea    0x1(%eax),%edx
  800332:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800335:	89 10                	mov    %edx,(%eax)
		}
		sys_signalSemaphore(parentenvID, _custQueueCS);
  800337:	83 ec 08             	sub    $0x8,%esp
  80033a:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800340:	50                   	push   %eax
  800341:	ff 75 e4             	pushl  -0x1c(%ebp)
  800344:	e8 ab 19 00 00       	call   801cf4 <sys_signalSemaphore>
  800349:	83 c4 10             	add    $0x10,%esp

		//try reserving on the required flight
		int custFlightType = customers[custId].flightType;
  80034c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80034f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800356:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800359:	01 d0                	add    %edx,%eax
  80035b:	8b 00                	mov    (%eax),%eax
  80035d:	89 45 b8             	mov    %eax,-0x48(%ebp)
		//cprintf("custId dequeued = %d, ft = %d\n", custId, customers[custId].flightType);

		switch (custFlightType)
  800360:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800363:	83 f8 02             	cmp    $0x2,%eax
  800366:	0f 84 90 00 00 00    	je     8003fc <_main+0x3c4>
  80036c:	83 f8 03             	cmp    $0x3,%eax
  80036f:	0f 84 05 01 00 00    	je     80047a <_main+0x442>
  800375:	83 f8 01             	cmp    $0x1,%eax
  800378:	0f 85 f8 01 00 00    	jne    800576 <_main+0x53e>
		{
		case 1:
		{
			//Check and update Flight1
			sys_waitSemaphore(parentenvID, _flight1CS);
  80037e:	83 ec 08             	sub    $0x8,%esp
  800381:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800387:	50                   	push   %eax
  800388:	ff 75 e4             	pushl  -0x1c(%ebp)
  80038b:	e8 46 19 00 00       	call   801cd6 <sys_waitSemaphore>
  800390:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0)
  800393:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	85 c0                	test   %eax,%eax
  80039a:	7e 46                	jle    8003e2 <_main+0x3aa>
				{
					*flight1Counter = *flight1Counter - 1;
  80039c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8003a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003a7:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8003a9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003ac:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003b6:	01 d0                	add    %edx,%eax
  8003b8:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8003bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cb:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003ce:	01 c2                	add    %eax,%edx
  8003d0:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8003d3:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8003d5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	8d 50 01             	lea    0x1(%eax),%edx
  8003dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e0:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight1CS);
  8003e2:	83 ec 08             	sub    $0x8,%esp
  8003e5:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  8003eb:	50                   	push   %eax
  8003ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003ef:	e8 00 19 00 00       	call   801cf4 <sys_signalSemaphore>
  8003f4:	83 c4 10             	add    $0x10,%esp
		}

		break;
  8003f7:	e9 91 01 00 00       	jmp    80058d <_main+0x555>
		case 2:
		{
			//Check and update Flight2
			sys_waitSemaphore(parentenvID, _flight2CS);
  8003fc:	83 ec 08             	sub    $0x8,%esp
  8003ff:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800405:	50                   	push   %eax
  800406:	ff 75 e4             	pushl  -0x1c(%ebp)
  800409:	e8 c8 18 00 00       	call   801cd6 <sys_waitSemaphore>
  80040e:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight2Counter > 0)
  800411:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	85 c0                	test   %eax,%eax
  800418:	7e 46                	jle    800460 <_main+0x428>
				{
					*flight2Counter = *flight2Counter - 1;
  80041a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800422:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800425:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800427:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80042a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800431:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800434:	01 d0                	add    %edx,%eax
  800436:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  80043d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800440:	8b 00                	mov    (%eax),%eax
  800442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800449:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80044c:	01 c2                	add    %eax,%edx
  80044e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800451:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  800453:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	8d 50 01             	lea    0x1(%eax),%edx
  80045b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80045e:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS);
  800460:	83 ec 08             	sub    $0x8,%esp
  800463:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800469:	50                   	push   %eax
  80046a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80046d:	e8 82 18 00 00       	call   801cf4 <sys_signalSemaphore>
  800472:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800475:	e9 13 01 00 00       	jmp    80058d <_main+0x555>
		case 3:
		{
			//Check and update Both Flights
			sys_waitSemaphore(parentenvID, _flight1CS); sys_waitSemaphore(parentenvID, _flight2CS);
  80047a:	83 ec 08             	sub    $0x8,%esp
  80047d:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800483:	50                   	push   %eax
  800484:	ff 75 e4             	pushl  -0x1c(%ebp)
  800487:	e8 4a 18 00 00       	call   801cd6 <sys_waitSemaphore>
  80048c:	83 c4 10             	add    $0x10,%esp
  80048f:	83 ec 08             	sub    $0x8,%esp
  800492:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800498:	50                   	push   %eax
  800499:	ff 75 e4             	pushl  -0x1c(%ebp)
  80049c:	e8 35 18 00 00       	call   801cd6 <sys_waitSemaphore>
  8004a1:	83 c4 10             	add    $0x10,%esp
			{
				if(*flight1Counter > 0 && *flight2Counter >0 )
  8004a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	85 c0                	test   %eax,%eax
  8004ab:	0f 8e 99 00 00 00    	jle    80054a <_main+0x512>
  8004b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	85 c0                	test   %eax,%eax
  8004b8:	0f 8e 8c 00 00 00    	jle    80054a <_main+0x512>
				{
					*flight1Counter = *flight1Counter - 1;
  8004be:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8004c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004c9:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  8004cb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8004d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight1BookedArr[*flight1BookedCounter] = custId;
  8004e1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004e4:	8b 00                	mov    (%eax),%eax
  8004e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ed:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004f0:	01 c2                	add    %eax,%edx
  8004f2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8004f5:	89 02                	mov    %eax,(%edx)
					*flight1BookedCounter =*flight1BookedCounter+1;
  8004f7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004fa:	8b 00                	mov    (%eax),%eax
  8004fc:	8d 50 01             	lea    0x1(%eax),%edx
  8004ff:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800502:	89 10                	mov    %edx,(%eax)

					*flight2Counter = *flight2Counter - 1;
  800504:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	8d 50 ff             	lea    -0x1(%eax),%edx
  80050c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80050f:	89 10                	mov    %edx,(%eax)
					customers[custId].booked = 1;
  800511:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800514:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80051b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051e:	01 d0                	add    %edx,%eax
  800520:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
					flight2BookedArr[*flight2BookedCounter] = custId;
  800527:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800533:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800536:	01 c2                	add    %eax,%edx
  800538:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80053b:	89 02                	mov    %eax,(%edx)
					*flight2BookedCounter =*flight2BookedCounter+1;
  80053d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800540:	8b 00                	mov    (%eax),%eax
  800542:	8d 50 01             	lea    0x1(%eax),%edx
  800545:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800548:	89 10                	mov    %edx,(%eax)
				else
				{

				}
			}
			sys_signalSemaphore(parentenvID, _flight2CS); sys_signalSemaphore(parentenvID, _flight1CS);
  80054a:	83 ec 08             	sub    $0x8,%esp
  80054d:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  800553:	50                   	push   %eax
  800554:	ff 75 e4             	pushl  -0x1c(%ebp)
  800557:	e8 98 17 00 00       	call   801cf4 <sys_signalSemaphore>
  80055c:	83 c4 10             	add    $0x10,%esp
  80055f:	83 ec 08             	sub    $0x8,%esp
  800562:	8d 85 f3 fe ff ff    	lea    -0x10d(%ebp),%eax
  800568:	50                   	push   %eax
  800569:	ff 75 e4             	pushl  -0x1c(%ebp)
  80056c:	e8 83 17 00 00       	call   801cf4 <sys_signalSemaphore>
  800571:	83 c4 10             	add    $0x10,%esp
		}
		break;
  800574:	eb 17                	jmp    80058d <_main+0x555>
		default:
			panic("customer must have flight type\n");
  800576:	83 ec 04             	sub    $0x4,%esp
  800579:	68 80 22 80 00       	push   $0x802280
  80057e:	68 8f 00 00 00       	push   $0x8f
  800583:	68 a0 22 80 00       	push   $0x8022a0
  800588:	e8 92 01 00 00       	call   80071f <_panic>
		}

		//signal finished
		char prefix[30]="cust_finished";
  80058d:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  800593:	bb af 23 80 00       	mov    $0x8023af,%ebx
  800598:	ba 0e 00 00 00       	mov    $0xe,%edx
  80059d:	89 c7                	mov    %eax,%edi
  80059f:	89 de                	mov    %ebx,%esi
  8005a1:	89 d1                	mov    %edx,%ecx
  8005a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8005a5:	8d 95 a8 fe ff ff    	lea    -0x158(%ebp),%edx
  8005ab:	b9 04 00 00 00       	mov    $0x4,%ecx
  8005b0:	b8 00 00 00 00       	mov    $0x0,%eax
  8005b5:	89 d7                	mov    %edx,%edi
  8005b7:	f3 ab                	rep stos %eax,%es:(%edi)
		char id[5]; char sname[50];
		ltostr(custId, id);
  8005b9:	83 ec 08             	sub    $0x8,%esp
  8005bc:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005c2:	50                   	push   %eax
  8005c3:	ff 75 bc             	pushl  -0x44(%ebp)
  8005c6:	e8 30 0f 00 00       	call   8014fb <ltostr>
  8005cb:	83 c4 10             	add    $0x10,%esp
		strcconcat(prefix, id, sname);
  8005ce:	83 ec 04             	sub    $0x4,%esp
  8005d1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005d7:	50                   	push   %eax
  8005d8:	8d 85 95 fe ff ff    	lea    -0x16b(%ebp),%eax
  8005de:	50                   	push   %eax
  8005df:	8d 85 9a fe ff ff    	lea    -0x166(%ebp),%eax
  8005e5:	50                   	push   %eax
  8005e6:	e8 08 10 00 00       	call   8015f3 <strcconcat>
  8005eb:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(parentenvID, sname);
  8005ee:	83 ec 08             	sub    $0x8,%esp
  8005f1:	8d 85 63 fe ff ff    	lea    -0x19d(%ebp),%eax
  8005f7:	50                   	push   %eax
  8005f8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8005fb:	e8 f4 16 00 00       	call   801cf4 <sys_signalSemaphore>
  800600:	83 c4 10             	add    $0x10,%esp

		//signal the clerk
		sys_signalSemaphore(parentenvID, _clerk);
  800603:	83 ec 08             	sub    $0x8,%esp
  800606:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80060c:	50                   	push   %eax
  80060d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800610:	e8 df 16 00 00       	call   801cf4 <sys_signalSemaphore>
  800615:	83 c4 10             	add    $0x10,%esp
	}
  800618:	e9 cd fc ff ff       	jmp    8002ea <_main+0x2b2>

0080061d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80061d:	55                   	push   %ebp
  80061e:	89 e5                	mov    %esp,%ebp
  800620:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800623:	e8 66 14 00 00       	call   801a8e <sys_getenvindex>
  800628:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80062b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80062e:	89 d0                	mov    %edx,%eax
  800630:	01 c0                	add    %eax,%eax
  800632:	01 d0                	add    %edx,%eax
  800634:	c1 e0 02             	shl    $0x2,%eax
  800637:	01 d0                	add    %edx,%eax
  800639:	c1 e0 06             	shl    $0x6,%eax
  80063c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800641:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800646:	a1 20 30 80 00       	mov    0x803020,%eax
  80064b:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800651:	84 c0                	test   %al,%al
  800653:	74 0f                	je     800664 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800655:	a1 20 30 80 00       	mov    0x803020,%eax
  80065a:	05 f4 02 00 00       	add    $0x2f4,%eax
  80065f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800664:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800668:	7e 0a                	jle    800674 <libmain+0x57>
		binaryname = argv[0];
  80066a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066d:	8b 00                	mov    (%eax),%eax
  80066f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800674:	83 ec 08             	sub    $0x8,%esp
  800677:	ff 75 0c             	pushl  0xc(%ebp)
  80067a:	ff 75 08             	pushl  0x8(%ebp)
  80067d:	e8 b6 f9 ff ff       	call   800038 <_main>
  800682:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800685:	e8 9f 15 00 00       	call   801c29 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80068a:	83 ec 0c             	sub    $0xc,%esp
  80068d:	68 e8 23 80 00       	push   $0x8023e8
  800692:	e8 3c 03 00 00       	call   8009d3 <cprintf>
  800697:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80069a:	a1 20 30 80 00       	mov    0x803020,%eax
  80069f:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  8006a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8006aa:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8006b0:	83 ec 04             	sub    $0x4,%esp
  8006b3:	52                   	push   %edx
  8006b4:	50                   	push   %eax
  8006b5:	68 10 24 80 00       	push   $0x802410
  8006ba:	e8 14 03 00 00       	call   8009d3 <cprintf>
  8006bf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c7:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	50                   	push   %eax
  8006d1:	68 35 24 80 00       	push   $0x802435
  8006d6:	e8 f8 02 00 00       	call   8009d3 <cprintf>
  8006db:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006de:	83 ec 0c             	sub    $0xc,%esp
  8006e1:	68 e8 23 80 00       	push   $0x8023e8
  8006e6:	e8 e8 02 00 00       	call   8009d3 <cprintf>
  8006eb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ee:	e8 50 15 00 00       	call   801c43 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006f3:	e8 19 00 00 00       	call   800711 <exit>
}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800701:	83 ec 0c             	sub    $0xc,%esp
  800704:	6a 00                	push   $0x0
  800706:	e8 4f 13 00 00       	call   801a5a <sys_env_destroy>
  80070b:	83 c4 10             	add    $0x10,%esp
}
  80070e:	90                   	nop
  80070f:	c9                   	leave  
  800710:	c3                   	ret    

00800711 <exit>:

void
exit(void)
{
  800711:	55                   	push   %ebp
  800712:	89 e5                	mov    %esp,%ebp
  800714:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800717:	e8 a4 13 00 00       	call   801ac0 <sys_env_exit>
}
  80071c:	90                   	nop
  80071d:	c9                   	leave  
  80071e:	c3                   	ret    

0080071f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80071f:	55                   	push   %ebp
  800720:	89 e5                	mov    %esp,%ebp
  800722:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800725:	8d 45 10             	lea    0x10(%ebp),%eax
  800728:	83 c0 04             	add    $0x4,%eax
  80072b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072e:	a1 30 30 80 00       	mov    0x803030,%eax
  800733:	85 c0                	test   %eax,%eax
  800735:	74 16                	je     80074d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800737:	a1 30 30 80 00       	mov    0x803030,%eax
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	50                   	push   %eax
  800740:	68 4c 24 80 00       	push   $0x80244c
  800745:	e8 89 02 00 00       	call   8009d3 <cprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80074d:	a1 00 30 80 00       	mov    0x803000,%eax
  800752:	ff 75 0c             	pushl  0xc(%ebp)
  800755:	ff 75 08             	pushl  0x8(%ebp)
  800758:	50                   	push   %eax
  800759:	68 51 24 80 00       	push   $0x802451
  80075e:	e8 70 02 00 00       	call   8009d3 <cprintf>
  800763:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800766:	8b 45 10             	mov    0x10(%ebp),%eax
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 f4             	pushl  -0xc(%ebp)
  80076f:	50                   	push   %eax
  800770:	e8 f3 01 00 00       	call   800968 <vcprintf>
  800775:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	6a 00                	push   $0x0
  80077d:	68 6d 24 80 00       	push   $0x80246d
  800782:	e8 e1 01 00 00       	call   800968 <vcprintf>
  800787:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80078a:	e8 82 ff ff ff       	call   800711 <exit>

	// should not return here
	while (1) ;
  80078f:	eb fe                	jmp    80078f <_panic+0x70>

00800791 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
  800794:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800797:	a1 20 30 80 00       	mov    0x803020,%eax
  80079c:	8b 50 74             	mov    0x74(%eax),%edx
  80079f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a2:	39 c2                	cmp    %eax,%edx
  8007a4:	74 14                	je     8007ba <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a6:	83 ec 04             	sub    $0x4,%esp
  8007a9:	68 70 24 80 00       	push   $0x802470
  8007ae:	6a 26                	push   $0x26
  8007b0:	68 bc 24 80 00       	push   $0x8024bc
  8007b5:	e8 65 ff ff ff       	call   80071f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c8:	e9 c2 00 00 00       	jmp    80088f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	8b 00                	mov    (%eax),%eax
  8007de:	85 c0                	test   %eax,%eax
  8007e0:	75 08                	jne    8007ea <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007e2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e5:	e9 a2 00 00 00       	jmp    80088c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f8:	eb 69                	jmp    800863 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800805:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800808:	89 d0                	mov    %edx,%eax
  80080a:	01 c0                	add    %eax,%eax
  80080c:	01 d0                	add    %edx,%eax
  80080e:	c1 e0 02             	shl    $0x2,%eax
  800811:	01 c8                	add    %ecx,%eax
  800813:	8a 40 04             	mov    0x4(%eax),%al
  800816:	84 c0                	test   %al,%al
  800818:	75 46                	jne    800860 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80081a:	a1 20 30 80 00       	mov    0x803020,%eax
  80081f:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800825:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800828:	89 d0                	mov    %edx,%eax
  80082a:	01 c0                	add    %eax,%eax
  80082c:	01 d0                	add    %edx,%eax
  80082e:	c1 e0 02             	shl    $0x2,%eax
  800831:	01 c8                	add    %ecx,%eax
  800833:	8b 00                	mov    (%eax),%eax
  800835:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800838:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80083b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800840:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800842:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800845:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	01 c8                	add    %ecx,%eax
  800851:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800853:	39 c2                	cmp    %eax,%edx
  800855:	75 09                	jne    800860 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800857:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80085e:	eb 12                	jmp    800872 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800860:	ff 45 e8             	incl   -0x18(%ebp)
  800863:	a1 20 30 80 00       	mov    0x803020,%eax
  800868:	8b 50 74             	mov    0x74(%eax),%edx
  80086b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80086e:	39 c2                	cmp    %eax,%edx
  800870:	77 88                	ja     8007fa <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800872:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800876:	75 14                	jne    80088c <CheckWSWithoutLastIndex+0xfb>
			panic(
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	68 c8 24 80 00       	push   $0x8024c8
  800880:	6a 3a                	push   $0x3a
  800882:	68 bc 24 80 00       	push   $0x8024bc
  800887:	e8 93 fe ff ff       	call   80071f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80088c:	ff 45 f0             	incl   -0x10(%ebp)
  80088f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800892:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800895:	0f 8c 32 ff ff ff    	jl     8007cd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80089b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008a9:	eb 26                	jmp    8008d1 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b0:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  8008b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008b9:	89 d0                	mov    %edx,%eax
  8008bb:	01 c0                	add    %eax,%eax
  8008bd:	01 d0                	add    %edx,%eax
  8008bf:	c1 e0 02             	shl    $0x2,%eax
  8008c2:	01 c8                	add    %ecx,%eax
  8008c4:	8a 40 04             	mov    0x4(%eax),%al
  8008c7:	3c 01                	cmp    $0x1,%al
  8008c9:	75 03                	jne    8008ce <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008cb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ce:	ff 45 e0             	incl   -0x20(%ebp)
  8008d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d6:	8b 50 74             	mov    0x74(%eax),%edx
  8008d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008dc:	39 c2                	cmp    %eax,%edx
  8008de:	77 cb                	ja     8008ab <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008e6:	74 14                	je     8008fc <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008e8:	83 ec 04             	sub    $0x4,%esp
  8008eb:	68 1c 25 80 00       	push   $0x80251c
  8008f0:	6a 44                	push   $0x44
  8008f2:	68 bc 24 80 00       	push   $0x8024bc
  8008f7:	e8 23 fe ff ff       	call   80071f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008fc:	90                   	nop
  8008fd:	c9                   	leave  
  8008fe:	c3                   	ret    

008008ff <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008ff:	55                   	push   %ebp
  800900:	89 e5                	mov    %esp,%ebp
  800902:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800905:	8b 45 0c             	mov    0xc(%ebp),%eax
  800908:	8b 00                	mov    (%eax),%eax
  80090a:	8d 48 01             	lea    0x1(%eax),%ecx
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	89 0a                	mov    %ecx,(%edx)
  800912:	8b 55 08             	mov    0x8(%ebp),%edx
  800915:	88 d1                	mov    %dl,%cl
  800917:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80091e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800921:	8b 00                	mov    (%eax),%eax
  800923:	3d ff 00 00 00       	cmp    $0xff,%eax
  800928:	75 2c                	jne    800956 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80092a:	a0 24 30 80 00       	mov    0x803024,%al
  80092f:	0f b6 c0             	movzbl %al,%eax
  800932:	8b 55 0c             	mov    0xc(%ebp),%edx
  800935:	8b 12                	mov    (%edx),%edx
  800937:	89 d1                	mov    %edx,%ecx
  800939:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093c:	83 c2 08             	add    $0x8,%edx
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	50                   	push   %eax
  800943:	51                   	push   %ecx
  800944:	52                   	push   %edx
  800945:	e8 ce 10 00 00       	call   801a18 <sys_cputs>
  80094a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80094d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800950:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800956:	8b 45 0c             	mov    0xc(%ebp),%eax
  800959:	8b 40 04             	mov    0x4(%eax),%eax
  80095c:	8d 50 01             	lea    0x1(%eax),%edx
  80095f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800962:	89 50 04             	mov    %edx,0x4(%eax)
}
  800965:	90                   	nop
  800966:	c9                   	leave  
  800967:	c3                   	ret    

00800968 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800968:	55                   	push   %ebp
  800969:	89 e5                	mov    %esp,%ebp
  80096b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800971:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800978:	00 00 00 
	b.cnt = 0;
  80097b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800982:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800985:	ff 75 0c             	pushl  0xc(%ebp)
  800988:	ff 75 08             	pushl  0x8(%ebp)
  80098b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800991:	50                   	push   %eax
  800992:	68 ff 08 80 00       	push   $0x8008ff
  800997:	e8 11 02 00 00       	call   800bad <vprintfmt>
  80099c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80099f:	a0 24 30 80 00       	mov    0x803024,%al
  8009a4:	0f b6 c0             	movzbl %al,%eax
  8009a7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ad:	83 ec 04             	sub    $0x4,%esp
  8009b0:	50                   	push   %eax
  8009b1:	52                   	push   %edx
  8009b2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b8:	83 c0 08             	add    $0x8,%eax
  8009bb:	50                   	push   %eax
  8009bc:	e8 57 10 00 00       	call   801a18 <sys_cputs>
  8009c1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009c4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009cb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009d1:	c9                   	leave  
  8009d2:	c3                   	ret    

008009d3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009d3:	55                   	push   %ebp
  8009d4:	89 e5                	mov    %esp,%ebp
  8009d6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009d9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009e0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	83 ec 08             	sub    $0x8,%esp
  8009ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ef:	50                   	push   %eax
  8009f0:	e8 73 ff ff ff       	call   800968 <vcprintf>
  8009f5:	83 c4 10             	add    $0x10,%esp
  8009f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009fe:	c9                   	leave  
  8009ff:	c3                   	ret    

00800a00 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
  800a03:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a06:	e8 1e 12 00 00       	call   801c29 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a0b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a11:	8b 45 08             	mov    0x8(%ebp),%eax
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1a:	50                   	push   %eax
  800a1b:	e8 48 ff ff ff       	call   800968 <vcprintf>
  800a20:	83 c4 10             	add    $0x10,%esp
  800a23:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a26:	e8 18 12 00 00       	call   801c43 <sys_enable_interrupt>
	return cnt;
  800a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2e:	c9                   	leave  
  800a2f:	c3                   	ret    

00800a30 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a30:	55                   	push   %ebp
  800a31:	89 e5                	mov    %esp,%ebp
  800a33:	53                   	push   %ebx
  800a34:	83 ec 14             	sub    $0x14,%esp
  800a37:	8b 45 10             	mov    0x10(%ebp),%eax
  800a3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a40:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a43:	8b 45 18             	mov    0x18(%ebp),%eax
  800a46:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a4e:	77 55                	ja     800aa5 <printnum+0x75>
  800a50:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a53:	72 05                	jb     800a5a <printnum+0x2a>
  800a55:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a58:	77 4b                	ja     800aa5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a5a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a5d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a60:	8b 45 18             	mov    0x18(%ebp),%eax
  800a63:	ba 00 00 00 00       	mov    $0x0,%edx
  800a68:	52                   	push   %edx
  800a69:	50                   	push   %eax
  800a6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6d:	ff 75 f0             	pushl  -0x10(%ebp)
  800a70:	e8 93 15 00 00       	call   802008 <__udivdi3>
  800a75:	83 c4 10             	add    $0x10,%esp
  800a78:	83 ec 04             	sub    $0x4,%esp
  800a7b:	ff 75 20             	pushl  0x20(%ebp)
  800a7e:	53                   	push   %ebx
  800a7f:	ff 75 18             	pushl  0x18(%ebp)
  800a82:	52                   	push   %edx
  800a83:	50                   	push   %eax
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	ff 75 08             	pushl  0x8(%ebp)
  800a8a:	e8 a1 ff ff ff       	call   800a30 <printnum>
  800a8f:	83 c4 20             	add    $0x20,%esp
  800a92:	eb 1a                	jmp    800aae <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a94:	83 ec 08             	sub    $0x8,%esp
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	ff 75 20             	pushl  0x20(%ebp)
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	ff d0                	call   *%eax
  800aa2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aa5:	ff 4d 1c             	decl   0x1c(%ebp)
  800aa8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aac:	7f e6                	jg     800a94 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aae:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ab1:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abc:	53                   	push   %ebx
  800abd:	51                   	push   %ecx
  800abe:	52                   	push   %edx
  800abf:	50                   	push   %eax
  800ac0:	e8 53 16 00 00       	call   802118 <__umoddi3>
  800ac5:	83 c4 10             	add    $0x10,%esp
  800ac8:	05 94 27 80 00       	add    $0x802794,%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	0f be c0             	movsbl %al,%eax
  800ad2:	83 ec 08             	sub    $0x8,%esp
  800ad5:	ff 75 0c             	pushl  0xc(%ebp)
  800ad8:	50                   	push   %eax
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	ff d0                	call   *%eax
  800ade:	83 c4 10             	add    $0x10,%esp
}
  800ae1:	90                   	nop
  800ae2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ae5:	c9                   	leave  
  800ae6:	c3                   	ret    

00800ae7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ae7:	55                   	push   %ebp
  800ae8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aee:	7e 1c                	jle    800b0c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8b 00                	mov    (%eax),%eax
  800af5:	8d 50 08             	lea    0x8(%eax),%edx
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	89 10                	mov    %edx,(%eax)
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	83 e8 08             	sub    $0x8,%eax
  800b05:	8b 50 04             	mov    0x4(%eax),%edx
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	eb 40                	jmp    800b4c <getuint+0x65>
	else if (lflag)
  800b0c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b10:	74 1e                	je     800b30 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	8d 50 04             	lea    0x4(%eax),%edx
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	89 10                	mov    %edx,(%eax)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	83 e8 04             	sub    $0x4,%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2e:	eb 1c                	jmp    800b4c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	8d 50 04             	lea    0x4(%eax),%edx
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	89 10                	mov    %edx,(%eax)
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	83 e8 04             	sub    $0x4,%eax
  800b45:	8b 00                	mov    (%eax),%eax
  800b47:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b4c:	5d                   	pop    %ebp
  800b4d:	c3                   	ret    

00800b4e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b51:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b55:	7e 1c                	jle    800b73 <getint+0x25>
		return va_arg(*ap, long long);
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	8d 50 08             	lea    0x8(%eax),%edx
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	89 10                	mov    %edx,(%eax)
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	83 e8 08             	sub    $0x8,%eax
  800b6c:	8b 50 04             	mov    0x4(%eax),%edx
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	eb 38                	jmp    800bab <getint+0x5d>
	else if (lflag)
  800b73:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b77:	74 1a                	je     800b93 <getint+0x45>
		return va_arg(*ap, long);
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	8d 50 04             	lea    0x4(%eax),%edx
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 10                	mov    %edx,(%eax)
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	83 e8 04             	sub    $0x4,%eax
  800b8e:	8b 00                	mov    (%eax),%eax
  800b90:	99                   	cltd   
  800b91:	eb 18                	jmp    800bab <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	8d 50 04             	lea    0x4(%eax),%edx
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 10                	mov    %edx,(%eax)
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	83 e8 04             	sub    $0x4,%eax
  800ba8:	8b 00                	mov    (%eax),%eax
  800baa:	99                   	cltd   
}
  800bab:	5d                   	pop    %ebp
  800bac:	c3                   	ret    

00800bad <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	56                   	push   %esi
  800bb1:	53                   	push   %ebx
  800bb2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb5:	eb 17                	jmp    800bce <vprintfmt+0x21>
			if (ch == '\0')
  800bb7:	85 db                	test   %ebx,%ebx
  800bb9:	0f 84 af 03 00 00    	je     800f6e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bbf:	83 ec 08             	sub    $0x8,%esp
  800bc2:	ff 75 0c             	pushl  0xc(%ebp)
  800bc5:	53                   	push   %ebx
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	ff d0                	call   *%eax
  800bcb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bce:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd1:	8d 50 01             	lea    0x1(%eax),%edx
  800bd4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd7:	8a 00                	mov    (%eax),%al
  800bd9:	0f b6 d8             	movzbl %al,%ebx
  800bdc:	83 fb 25             	cmp    $0x25,%ebx
  800bdf:	75 d6                	jne    800bb7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800be1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800be5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bec:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bf3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bfa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c01:	8b 45 10             	mov    0x10(%ebp),%eax
  800c04:	8d 50 01             	lea    0x1(%eax),%edx
  800c07:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0a:	8a 00                	mov    (%eax),%al
  800c0c:	0f b6 d8             	movzbl %al,%ebx
  800c0f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c12:	83 f8 55             	cmp    $0x55,%eax
  800c15:	0f 87 2b 03 00 00    	ja     800f46 <vprintfmt+0x399>
  800c1b:	8b 04 85 b8 27 80 00 	mov    0x8027b8(,%eax,4),%eax
  800c22:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c24:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c28:	eb d7                	jmp    800c01 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c2a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c2e:	eb d1                	jmp    800c01 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c30:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c37:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3a:	89 d0                	mov    %edx,%eax
  800c3c:	c1 e0 02             	shl    $0x2,%eax
  800c3f:	01 d0                	add    %edx,%eax
  800c41:	01 c0                	add    %eax,%eax
  800c43:	01 d8                	add    %ebx,%eax
  800c45:	83 e8 30             	sub    $0x30,%eax
  800c48:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c53:	83 fb 2f             	cmp    $0x2f,%ebx
  800c56:	7e 3e                	jle    800c96 <vprintfmt+0xe9>
  800c58:	83 fb 39             	cmp    $0x39,%ebx
  800c5b:	7f 39                	jg     800c96 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c5d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c60:	eb d5                	jmp    800c37 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c62:	8b 45 14             	mov    0x14(%ebp),%eax
  800c65:	83 c0 04             	add    $0x4,%eax
  800c68:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6e:	83 e8 04             	sub    $0x4,%eax
  800c71:	8b 00                	mov    (%eax),%eax
  800c73:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c76:	eb 1f                	jmp    800c97 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7c:	79 83                	jns    800c01 <vprintfmt+0x54>
				width = 0;
  800c7e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c85:	e9 77 ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c8a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c91:	e9 6b ff ff ff       	jmp    800c01 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c96:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9b:	0f 89 60 ff ff ff    	jns    800c01 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ca1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ca7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cae:	e9 4e ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cb3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cb6:	e9 46 ff ff ff       	jmp    800c01 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbe:	83 c0 04             	add    $0x4,%eax
  800cc1:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc7:	83 e8 04             	sub    $0x4,%eax
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	83 ec 08             	sub    $0x8,%esp
  800ccf:	ff 75 0c             	pushl  0xc(%ebp)
  800cd2:	50                   	push   %eax
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	ff d0                	call   *%eax
  800cd8:	83 c4 10             	add    $0x10,%esp
			break;
  800cdb:	e9 89 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ce0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce3:	83 c0 04             	add    $0x4,%eax
  800ce6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cec:	83 e8 04             	sub    $0x4,%eax
  800cef:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cf1:	85 db                	test   %ebx,%ebx
  800cf3:	79 02                	jns    800cf7 <vprintfmt+0x14a>
				err = -err;
  800cf5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cf7:	83 fb 64             	cmp    $0x64,%ebx
  800cfa:	7f 0b                	jg     800d07 <vprintfmt+0x15a>
  800cfc:	8b 34 9d 00 26 80 00 	mov    0x802600(,%ebx,4),%esi
  800d03:	85 f6                	test   %esi,%esi
  800d05:	75 19                	jne    800d20 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d07:	53                   	push   %ebx
  800d08:	68 a5 27 80 00       	push   $0x8027a5
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	ff 75 08             	pushl  0x8(%ebp)
  800d13:	e8 5e 02 00 00       	call   800f76 <printfmt>
  800d18:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d1b:	e9 49 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d20:	56                   	push   %esi
  800d21:	68 ae 27 80 00       	push   $0x8027ae
  800d26:	ff 75 0c             	pushl  0xc(%ebp)
  800d29:	ff 75 08             	pushl  0x8(%ebp)
  800d2c:	e8 45 02 00 00       	call   800f76 <printfmt>
  800d31:	83 c4 10             	add    $0x10,%esp
			break;
  800d34:	e9 30 02 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d39:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3c:	83 c0 04             	add    $0x4,%eax
  800d3f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d42:	8b 45 14             	mov    0x14(%ebp),%eax
  800d45:	83 e8 04             	sub    $0x4,%eax
  800d48:	8b 30                	mov    (%eax),%esi
  800d4a:	85 f6                	test   %esi,%esi
  800d4c:	75 05                	jne    800d53 <vprintfmt+0x1a6>
				p = "(null)";
  800d4e:	be b1 27 80 00       	mov    $0x8027b1,%esi
			if (width > 0 && padc != '-')
  800d53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d57:	7e 6d                	jle    800dc6 <vprintfmt+0x219>
  800d59:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d5d:	74 67                	je     800dc6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	50                   	push   %eax
  800d66:	56                   	push   %esi
  800d67:	e8 0c 03 00 00       	call   801078 <strnlen>
  800d6c:	83 c4 10             	add    $0x10,%esp
  800d6f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d72:	eb 16                	jmp    800d8a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d74:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d78:	83 ec 08             	sub    $0x8,%esp
  800d7b:	ff 75 0c             	pushl  0xc(%ebp)
  800d7e:	50                   	push   %eax
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	ff d0                	call   *%eax
  800d84:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d87:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8e:	7f e4                	jg     800d74 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d90:	eb 34                	jmp    800dc6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d92:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d96:	74 1c                	je     800db4 <vprintfmt+0x207>
  800d98:	83 fb 1f             	cmp    $0x1f,%ebx
  800d9b:	7e 05                	jle    800da2 <vprintfmt+0x1f5>
  800d9d:	83 fb 7e             	cmp    $0x7e,%ebx
  800da0:	7e 12                	jle    800db4 <vprintfmt+0x207>
					putch('?', putdat);
  800da2:	83 ec 08             	sub    $0x8,%esp
  800da5:	ff 75 0c             	pushl  0xc(%ebp)
  800da8:	6a 3f                	push   $0x3f
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
  800db2:	eb 0f                	jmp    800dc3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800db4:	83 ec 08             	sub    $0x8,%esp
  800db7:	ff 75 0c             	pushl  0xc(%ebp)
  800dba:	53                   	push   %ebx
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	ff d0                	call   *%eax
  800dc0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc3:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc6:	89 f0                	mov    %esi,%eax
  800dc8:	8d 70 01             	lea    0x1(%eax),%esi
  800dcb:	8a 00                	mov    (%eax),%al
  800dcd:	0f be d8             	movsbl %al,%ebx
  800dd0:	85 db                	test   %ebx,%ebx
  800dd2:	74 24                	je     800df8 <vprintfmt+0x24b>
  800dd4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd8:	78 b8                	js     800d92 <vprintfmt+0x1e5>
  800dda:	ff 4d e0             	decl   -0x20(%ebp)
  800ddd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de1:	79 af                	jns    800d92 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de3:	eb 13                	jmp    800df8 <vprintfmt+0x24b>
				putch(' ', putdat);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 0c             	pushl  0xc(%ebp)
  800deb:	6a 20                	push   $0x20
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	ff d0                	call   *%eax
  800df2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df5:	ff 4d e4             	decl   -0x1c(%ebp)
  800df8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dfc:	7f e7                	jg     800de5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dfe:	e9 66 01 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e03:	83 ec 08             	sub    $0x8,%esp
  800e06:	ff 75 e8             	pushl  -0x18(%ebp)
  800e09:	8d 45 14             	lea    0x14(%ebp),%eax
  800e0c:	50                   	push   %eax
  800e0d:	e8 3c fd ff ff       	call   800b4e <getint>
  800e12:	83 c4 10             	add    $0x10,%esp
  800e15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e18:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e21:	85 d2                	test   %edx,%edx
  800e23:	79 23                	jns    800e48 <vprintfmt+0x29b>
				putch('-', putdat);
  800e25:	83 ec 08             	sub    $0x8,%esp
  800e28:	ff 75 0c             	pushl  0xc(%ebp)
  800e2b:	6a 2d                	push   $0x2d
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	ff d0                	call   *%eax
  800e32:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e38:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3b:	f7 d8                	neg    %eax
  800e3d:	83 d2 00             	adc    $0x0,%edx
  800e40:	f7 da                	neg    %edx
  800e42:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e45:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e48:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e4f:	e9 bc 00 00 00       	jmp    800f10 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e54:	83 ec 08             	sub    $0x8,%esp
  800e57:	ff 75 e8             	pushl  -0x18(%ebp)
  800e5a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5d:	50                   	push   %eax
  800e5e:	e8 84 fc ff ff       	call   800ae7 <getuint>
  800e63:	83 c4 10             	add    $0x10,%esp
  800e66:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e69:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e6c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e73:	e9 98 00 00 00       	jmp    800f10 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e78:	83 ec 08             	sub    $0x8,%esp
  800e7b:	ff 75 0c             	pushl  0xc(%ebp)
  800e7e:	6a 58                	push   $0x58
  800e80:	8b 45 08             	mov    0x8(%ebp),%eax
  800e83:	ff d0                	call   *%eax
  800e85:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e88:	83 ec 08             	sub    $0x8,%esp
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	6a 58                	push   $0x58
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e98:	83 ec 08             	sub    $0x8,%esp
  800e9b:	ff 75 0c             	pushl  0xc(%ebp)
  800e9e:	6a 58                	push   $0x58
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	ff d0                	call   *%eax
  800ea5:	83 c4 10             	add    $0x10,%esp
			break;
  800ea8:	e9 bc 00 00 00       	jmp    800f69 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	6a 30                	push   $0x30
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	ff d0                	call   *%eax
  800eba:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 78                	push   $0x78
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ecd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed0:	83 c0 04             	add    $0x4,%eax
  800ed3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ed6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed9:	83 e8 04             	sub    $0x4,%eax
  800edc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ee8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eef:	eb 1f                	jmp    800f10 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef7:	8d 45 14             	lea    0x14(%ebp),%eax
  800efa:	50                   	push   %eax
  800efb:	e8 e7 fb ff ff       	call   800ae7 <getuint>
  800f00:	83 c4 10             	add    $0x10,%esp
  800f03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f09:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f10:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f17:	83 ec 04             	sub    $0x4,%esp
  800f1a:	52                   	push   %edx
  800f1b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f1e:	50                   	push   %eax
  800f1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f22:	ff 75 f0             	pushl  -0x10(%ebp)
  800f25:	ff 75 0c             	pushl  0xc(%ebp)
  800f28:	ff 75 08             	pushl  0x8(%ebp)
  800f2b:	e8 00 fb ff ff       	call   800a30 <printnum>
  800f30:	83 c4 20             	add    $0x20,%esp
			break;
  800f33:	eb 34                	jmp    800f69 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f35:	83 ec 08             	sub    $0x8,%esp
  800f38:	ff 75 0c             	pushl  0xc(%ebp)
  800f3b:	53                   	push   %ebx
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
			break;
  800f44:	eb 23                	jmp    800f69 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	6a 25                	push   $0x25
  800f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f51:	ff d0                	call   *%eax
  800f53:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f56:	ff 4d 10             	decl   0x10(%ebp)
  800f59:	eb 03                	jmp    800f5e <vprintfmt+0x3b1>
  800f5b:	ff 4d 10             	decl   0x10(%ebp)
  800f5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f61:	48                   	dec    %eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	3c 25                	cmp    $0x25,%al
  800f66:	75 f3                	jne    800f5b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f68:	90                   	nop
		}
	}
  800f69:	e9 47 fc ff ff       	jmp    800bb5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f6e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f72:	5b                   	pop    %ebx
  800f73:	5e                   	pop    %esi
  800f74:	5d                   	pop    %ebp
  800f75:	c3                   	ret    

00800f76 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f76:	55                   	push   %ebp
  800f77:	89 e5                	mov    %esp,%ebp
  800f79:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f7c:	8d 45 10             	lea    0x10(%ebp),%eax
  800f7f:	83 c0 04             	add    $0x4,%eax
  800f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f85:	8b 45 10             	mov    0x10(%ebp),%eax
  800f88:	ff 75 f4             	pushl  -0xc(%ebp)
  800f8b:	50                   	push   %eax
  800f8c:	ff 75 0c             	pushl  0xc(%ebp)
  800f8f:	ff 75 08             	pushl  0x8(%ebp)
  800f92:	e8 16 fc ff ff       	call   800bad <vprintfmt>
  800f97:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f9a:	90                   	nop
  800f9b:	c9                   	leave  
  800f9c:	c3                   	ret    

00800f9d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f9d:	55                   	push   %ebp
  800f9e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	8b 40 08             	mov    0x8(%eax),%eax
  800fa6:	8d 50 01             	lea    0x1(%eax),%edx
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800faf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb2:	8b 10                	mov    (%eax),%edx
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	8b 40 04             	mov    0x4(%eax),%eax
  800fba:	39 c2                	cmp    %eax,%edx
  800fbc:	73 12                	jae    800fd0 <sprintputch+0x33>
		*b->buf++ = ch;
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	8b 00                	mov    (%eax),%eax
  800fc3:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc9:	89 0a                	mov    %ecx,(%edx)
  800fcb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fce:	88 10                	mov    %dl,(%eax)
}
  800fd0:	90                   	nop
  800fd1:	5d                   	pop    %ebp
  800fd2:	c3                   	ret    

00800fd3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
  800fd6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	01 d0                	add    %edx,%eax
  800fea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ff4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff8:	74 06                	je     801000 <vsnprintf+0x2d>
  800ffa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffe:	7f 07                	jg     801007 <vsnprintf+0x34>
		return -E_INVAL;
  801000:	b8 03 00 00 00       	mov    $0x3,%eax
  801005:	eb 20                	jmp    801027 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801007:	ff 75 14             	pushl  0x14(%ebp)
  80100a:	ff 75 10             	pushl  0x10(%ebp)
  80100d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801010:	50                   	push   %eax
  801011:	68 9d 0f 80 00       	push   $0x800f9d
  801016:	e8 92 fb ff ff       	call   800bad <vprintfmt>
  80101b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80101e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801021:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801024:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80102f:	8d 45 10             	lea    0x10(%ebp),%eax
  801032:	83 c0 04             	add    $0x4,%eax
  801035:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	ff 75 f4             	pushl  -0xc(%ebp)
  80103e:	50                   	push   %eax
  80103f:	ff 75 0c             	pushl  0xc(%ebp)
  801042:	ff 75 08             	pushl  0x8(%ebp)
  801045:	e8 89 ff ff ff       	call   800fd3 <vsnprintf>
  80104a:	83 c4 10             	add    $0x10,%esp
  80104d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801050:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801053:	c9                   	leave  
  801054:	c3                   	ret    

00801055 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801055:	55                   	push   %ebp
  801056:	89 e5                	mov    %esp,%ebp
  801058:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80105b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801062:	eb 06                	jmp    80106a <strlen+0x15>
		n++;
  801064:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801067:	ff 45 08             	incl   0x8(%ebp)
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	84 c0                	test   %al,%al
  801071:	75 f1                	jne    801064 <strlen+0xf>
		n++;
	return n;
  801073:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
  80107b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80107e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801085:	eb 09                	jmp    801090 <strnlen+0x18>
		n++;
  801087:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80108a:	ff 45 08             	incl   0x8(%ebp)
  80108d:	ff 4d 0c             	decl   0xc(%ebp)
  801090:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801094:	74 09                	je     80109f <strnlen+0x27>
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	8a 00                	mov    (%eax),%al
  80109b:	84 c0                	test   %al,%al
  80109d:	75 e8                	jne    801087 <strnlen+0xf>
		n++;
	return n;
  80109f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010b0:	90                   	nop
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	8d 50 01             	lea    0x1(%eax),%edx
  8010b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010bd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010c3:	8a 12                	mov    (%edx),%dl
  8010c5:	88 10                	mov    %dl,(%eax)
  8010c7:	8a 00                	mov    (%eax),%al
  8010c9:	84 c0                	test   %al,%al
  8010cb:	75 e4                	jne    8010b1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010d0:	c9                   	leave  
  8010d1:	c3                   	ret    

008010d2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
  8010d5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010e5:	eb 1f                	jmp    801106 <strncpy+0x34>
		*dst++ = *src;
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	8d 50 01             	lea    0x1(%eax),%edx
  8010ed:	89 55 08             	mov    %edx,0x8(%ebp)
  8010f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f3:	8a 12                	mov    (%edx),%dl
  8010f5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fa:	8a 00                	mov    (%eax),%al
  8010fc:	84 c0                	test   %al,%al
  8010fe:	74 03                	je     801103 <strncpy+0x31>
			src++;
  801100:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801103:	ff 45 fc             	incl   -0x4(%ebp)
  801106:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801109:	3b 45 10             	cmp    0x10(%ebp),%eax
  80110c:	72 d9                	jb     8010e7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80110e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80111f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801123:	74 30                	je     801155 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801125:	eb 16                	jmp    80113d <strlcpy+0x2a>
			*dst++ = *src++;
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8d 50 01             	lea    0x1(%eax),%edx
  80112d:	89 55 08             	mov    %edx,0x8(%ebp)
  801130:	8b 55 0c             	mov    0xc(%ebp),%edx
  801133:	8d 4a 01             	lea    0x1(%edx),%ecx
  801136:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801139:	8a 12                	mov    (%edx),%dl
  80113b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80113d:	ff 4d 10             	decl   0x10(%ebp)
  801140:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801144:	74 09                	je     80114f <strlcpy+0x3c>
  801146:	8b 45 0c             	mov    0xc(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	84 c0                	test   %al,%al
  80114d:	75 d8                	jne    801127 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801155:	8b 55 08             	mov    0x8(%ebp),%edx
  801158:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115b:	29 c2                	sub    %eax,%edx
  80115d:	89 d0                	mov    %edx,%eax
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801164:	eb 06                	jmp    80116c <strcmp+0xb>
		p++, q++;
  801166:	ff 45 08             	incl   0x8(%ebp)
  801169:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8a 00                	mov    (%eax),%al
  801171:	84 c0                	test   %al,%al
  801173:	74 0e                	je     801183 <strcmp+0x22>
  801175:	8b 45 08             	mov    0x8(%ebp),%eax
  801178:	8a 10                	mov    (%eax),%dl
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	38 c2                	cmp    %al,%dl
  801181:	74 e3                	je     801166 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	8a 00                	mov    (%eax),%al
  801188:	0f b6 d0             	movzbl %al,%edx
  80118b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118e:	8a 00                	mov    (%eax),%al
  801190:	0f b6 c0             	movzbl %al,%eax
  801193:	29 c2                	sub    %eax,%edx
  801195:	89 d0                	mov    %edx,%eax
}
  801197:	5d                   	pop    %ebp
  801198:	c3                   	ret    

00801199 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801199:	55                   	push   %ebp
  80119a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80119c:	eb 09                	jmp    8011a7 <strncmp+0xe>
		n--, p++, q++;
  80119e:	ff 4d 10             	decl   0x10(%ebp)
  8011a1:	ff 45 08             	incl   0x8(%ebp)
  8011a4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8011a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ab:	74 17                	je     8011c4 <strncmp+0x2b>
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	84 c0                	test   %al,%al
  8011b4:	74 0e                	je     8011c4 <strncmp+0x2b>
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 10                	mov    (%eax),%dl
  8011bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	38 c2                	cmp    %al,%dl
  8011c2:	74 da                	je     80119e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011c8:	75 07                	jne    8011d1 <strncmp+0x38>
		return 0;
  8011ca:	b8 00 00 00 00       	mov    $0x0,%eax
  8011cf:	eb 14                	jmp    8011e5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	0f b6 d0             	movzbl %al,%edx
  8011d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	0f b6 c0             	movzbl %al,%eax
  8011e1:	29 c2                	sub    %eax,%edx
  8011e3:	89 d0                	mov    %edx,%eax
}
  8011e5:	5d                   	pop    %ebp
  8011e6:	c3                   	ret    

008011e7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	83 ec 04             	sub    $0x4,%esp
  8011ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011f3:	eb 12                	jmp    801207 <strchr+0x20>
		if (*s == c)
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011fd:	75 05                	jne    801204 <strchr+0x1d>
			return (char *) s;
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	eb 11                	jmp    801215 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801204:	ff 45 08             	incl   0x8(%ebp)
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	84 c0                	test   %al,%al
  80120e:	75 e5                	jne    8011f5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801210:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 04             	sub    $0x4,%esp
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801223:	eb 0d                	jmp    801232 <strfind+0x1b>
		if (*s == c)
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80122d:	74 0e                	je     80123d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80122f:	ff 45 08             	incl   0x8(%ebp)
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	84 c0                	test   %al,%al
  801239:	75 ea                	jne    801225 <strfind+0xe>
  80123b:	eb 01                	jmp    80123e <strfind+0x27>
		if (*s == c)
			break;
  80123d:	90                   	nop
	return (char *) s;
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
  801246:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80124f:	8b 45 10             	mov    0x10(%ebp),%eax
  801252:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801255:	eb 0e                	jmp    801265 <memset+0x22>
		*p++ = c;
  801257:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80125a:	8d 50 01             	lea    0x1(%eax),%edx
  80125d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801260:	8b 55 0c             	mov    0xc(%ebp),%edx
  801263:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801265:	ff 4d f8             	decl   -0x8(%ebp)
  801268:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80126c:	79 e9                	jns    801257 <memset+0x14>
		*p++ = c;

	return v;
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801271:	c9                   	leave  
  801272:	c3                   	ret    

00801273 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801273:	55                   	push   %ebp
  801274:	89 e5                	mov    %esp,%ebp
  801276:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801279:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801285:	eb 16                	jmp    80129d <memcpy+0x2a>
		*d++ = *s++;
  801287:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128a:	8d 50 01             	lea    0x1(%eax),%edx
  80128d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801290:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801293:	8d 4a 01             	lea    0x1(%edx),%ecx
  801296:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801299:	8a 12                	mov    (%edx),%dl
  80129b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80129d:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a6:	85 c0                	test   %eax,%eax
  8012a8:	75 dd                	jne    801287 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
  8012b2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012c7:	73 50                	jae    801319 <memmove+0x6a>
  8012c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cf:	01 d0                	add    %edx,%eax
  8012d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012d4:	76 43                	jbe    801319 <memmove+0x6a>
		s += n;
  8012d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012df:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012e2:	eb 10                	jmp    8012f4 <memmove+0x45>
			*--d = *--s;
  8012e4:	ff 4d f8             	decl   -0x8(%ebp)
  8012e7:	ff 4d fc             	decl   -0x4(%ebp)
  8012ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ed:	8a 10                	mov    (%eax),%dl
  8012ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8012fd:	85 c0                	test   %eax,%eax
  8012ff:	75 e3                	jne    8012e4 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801301:	eb 23                	jmp    801326 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801303:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801306:	8d 50 01             	lea    0x1(%eax),%edx
  801309:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80130c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80130f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801312:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801315:	8a 12                	mov    (%edx),%dl
  801317:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801319:	8b 45 10             	mov    0x10(%ebp),%eax
  80131c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80131f:	89 55 10             	mov    %edx,0x10(%ebp)
  801322:	85 c0                	test   %eax,%eax
  801324:	75 dd                	jne    801303 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
  80132e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80133d:	eb 2a                	jmp    801369 <memcmp+0x3e>
		if (*s1 != *s2)
  80133f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801342:	8a 10                	mov    (%eax),%dl
  801344:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801347:	8a 00                	mov    (%eax),%al
  801349:	38 c2                	cmp    %al,%dl
  80134b:	74 16                	je     801363 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80134d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	0f b6 d0             	movzbl %al,%edx
  801355:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	0f b6 c0             	movzbl %al,%eax
  80135d:	29 c2                	sub    %eax,%edx
  80135f:	89 d0                	mov    %edx,%eax
  801361:	eb 18                	jmp    80137b <memcmp+0x50>
		s1++, s2++;
  801363:	ff 45 fc             	incl   -0x4(%ebp)
  801366:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801369:	8b 45 10             	mov    0x10(%ebp),%eax
  80136c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80136f:	89 55 10             	mov    %edx,0x10(%ebp)
  801372:	85 c0                	test   %eax,%eax
  801374:	75 c9                	jne    80133f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801376:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80137b:	c9                   	leave  
  80137c:	c3                   	ret    

0080137d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
  801380:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801383:	8b 55 08             	mov    0x8(%ebp),%edx
  801386:	8b 45 10             	mov    0x10(%ebp),%eax
  801389:	01 d0                	add    %edx,%eax
  80138b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80138e:	eb 15                	jmp    8013a5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	0f b6 d0             	movzbl %al,%edx
  801398:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139b:	0f b6 c0             	movzbl %al,%eax
  80139e:	39 c2                	cmp    %eax,%edx
  8013a0:	74 0d                	je     8013af <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8013a2:	ff 45 08             	incl   0x8(%ebp)
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013ab:	72 e3                	jb     801390 <memfind+0x13>
  8013ad:	eb 01                	jmp    8013b0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013af:	90                   	nop
	return (void *) s;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
  8013b8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013c9:	eb 03                	jmp    8013ce <strtol+0x19>
		s++;
  8013cb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	8a 00                	mov    (%eax),%al
  8013d3:	3c 20                	cmp    $0x20,%al
  8013d5:	74 f4                	je     8013cb <strtol+0x16>
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	8a 00                	mov    (%eax),%al
  8013dc:	3c 09                	cmp    $0x9,%al
  8013de:	74 eb                	je     8013cb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	8a 00                	mov    (%eax),%al
  8013e5:	3c 2b                	cmp    $0x2b,%al
  8013e7:	75 05                	jne    8013ee <strtol+0x39>
		s++;
  8013e9:	ff 45 08             	incl   0x8(%ebp)
  8013ec:	eb 13                	jmp    801401 <strtol+0x4c>
	else if (*s == '-')
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	3c 2d                	cmp    $0x2d,%al
  8013f5:	75 0a                	jne    801401 <strtol+0x4c>
		s++, neg = 1;
  8013f7:	ff 45 08             	incl   0x8(%ebp)
  8013fa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801405:	74 06                	je     80140d <strtol+0x58>
  801407:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80140b:	75 20                	jne    80142d <strtol+0x78>
  80140d:	8b 45 08             	mov    0x8(%ebp),%eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	3c 30                	cmp    $0x30,%al
  801414:	75 17                	jne    80142d <strtol+0x78>
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	40                   	inc    %eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	3c 78                	cmp    $0x78,%al
  80141e:	75 0d                	jne    80142d <strtol+0x78>
		s += 2, base = 16;
  801420:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801424:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80142b:	eb 28                	jmp    801455 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80142d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801431:	75 15                	jne    801448 <strtol+0x93>
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	3c 30                	cmp    $0x30,%al
  80143a:	75 0c                	jne    801448 <strtol+0x93>
		s++, base = 8;
  80143c:	ff 45 08             	incl   0x8(%ebp)
  80143f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801446:	eb 0d                	jmp    801455 <strtol+0xa0>
	else if (base == 0)
  801448:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80144c:	75 07                	jne    801455 <strtol+0xa0>
		base = 10;
  80144e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	3c 2f                	cmp    $0x2f,%al
  80145c:	7e 19                	jle    801477 <strtol+0xc2>
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	3c 39                	cmp    $0x39,%al
  801465:	7f 10                	jg     801477 <strtol+0xc2>
			dig = *s - '0';
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	8a 00                	mov    (%eax),%al
  80146c:	0f be c0             	movsbl %al,%eax
  80146f:	83 e8 30             	sub    $0x30,%eax
  801472:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801475:	eb 42                	jmp    8014b9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	8a 00                	mov    (%eax),%al
  80147c:	3c 60                	cmp    $0x60,%al
  80147e:	7e 19                	jle    801499 <strtol+0xe4>
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	3c 7a                	cmp    $0x7a,%al
  801487:	7f 10                	jg     801499 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	0f be c0             	movsbl %al,%eax
  801491:	83 e8 57             	sub    $0x57,%eax
  801494:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801497:	eb 20                	jmp    8014b9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	3c 40                	cmp    $0x40,%al
  8014a0:	7e 39                	jle    8014db <strtol+0x126>
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	3c 5a                	cmp    $0x5a,%al
  8014a9:	7f 30                	jg     8014db <strtol+0x126>
			dig = *s - 'A' + 10;
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 00                	mov    (%eax),%al
  8014b0:	0f be c0             	movsbl %al,%eax
  8014b3:	83 e8 37             	sub    $0x37,%eax
  8014b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014bc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014bf:	7d 19                	jge    8014da <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014c1:	ff 45 08             	incl   0x8(%ebp)
  8014c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c7:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014cb:	89 c2                	mov    %eax,%edx
  8014cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014d0:	01 d0                	add    %edx,%eax
  8014d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014d5:	e9 7b ff ff ff       	jmp    801455 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014da:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014df:	74 08                	je     8014e9 <strtol+0x134>
		*endptr = (char *) s;
  8014e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8014e7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014ed:	74 07                	je     8014f6 <strtol+0x141>
  8014ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f2:	f7 d8                	neg    %eax
  8014f4:	eb 03                	jmp    8014f9 <strtol+0x144>
  8014f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <ltostr>:

void
ltostr(long value, char *str)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
  8014fe:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801501:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801508:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80150f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801513:	79 13                	jns    801528 <ltostr+0x2d>
	{
		neg = 1;
  801515:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80151c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801522:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801525:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801528:	8b 45 08             	mov    0x8(%ebp),%eax
  80152b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801530:	99                   	cltd   
  801531:	f7 f9                	idiv   %ecx
  801533:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801536:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801539:	8d 50 01             	lea    0x1(%eax),%edx
  80153c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80153f:	89 c2                	mov    %eax,%edx
  801541:	8b 45 0c             	mov    0xc(%ebp),%eax
  801544:	01 d0                	add    %edx,%eax
  801546:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801549:	83 c2 30             	add    $0x30,%edx
  80154c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80154e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801551:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801556:	f7 e9                	imul   %ecx
  801558:	c1 fa 02             	sar    $0x2,%edx
  80155b:	89 c8                	mov    %ecx,%eax
  80155d:	c1 f8 1f             	sar    $0x1f,%eax
  801560:	29 c2                	sub    %eax,%edx
  801562:	89 d0                	mov    %edx,%eax
  801564:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801567:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80156a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80156f:	f7 e9                	imul   %ecx
  801571:	c1 fa 02             	sar    $0x2,%edx
  801574:	89 c8                	mov    %ecx,%eax
  801576:	c1 f8 1f             	sar    $0x1f,%eax
  801579:	29 c2                	sub    %eax,%edx
  80157b:	89 d0                	mov    %edx,%eax
  80157d:	c1 e0 02             	shl    $0x2,%eax
  801580:	01 d0                	add    %edx,%eax
  801582:	01 c0                	add    %eax,%eax
  801584:	29 c1                	sub    %eax,%ecx
  801586:	89 ca                	mov    %ecx,%edx
  801588:	85 d2                	test   %edx,%edx
  80158a:	75 9c                	jne    801528 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80158c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801593:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801596:	48                   	dec    %eax
  801597:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80159a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80159e:	74 3d                	je     8015dd <ltostr+0xe2>
		start = 1 ;
  8015a0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8015a7:	eb 34                	jmp    8015dd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8015a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	01 d0                	add    %edx,%eax
  8015b1:	8a 00                	mov    (%eax),%al
  8015b3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015bc:	01 c2                	add    %eax,%edx
  8015be:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c4:	01 c8                	add    %ecx,%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d0:	01 c2                	add    %eax,%edx
  8015d2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015d5:	88 02                	mov    %al,(%edx)
		start++ ;
  8015d7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015da:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015e3:	7c c4                	jl     8015a9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015eb:	01 d0                	add    %edx,%eax
  8015ed:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
  8015f6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015f9:	ff 75 08             	pushl  0x8(%ebp)
  8015fc:	e8 54 fa ff ff       	call   801055 <strlen>
  801601:	83 c4 04             	add    $0x4,%esp
  801604:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801607:	ff 75 0c             	pushl  0xc(%ebp)
  80160a:	e8 46 fa ff ff       	call   801055 <strlen>
  80160f:	83 c4 04             	add    $0x4,%esp
  801612:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801615:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80161c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801623:	eb 17                	jmp    80163c <strcconcat+0x49>
		final[s] = str1[s] ;
  801625:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801628:	8b 45 10             	mov    0x10(%ebp),%eax
  80162b:	01 c2                	add    %eax,%edx
  80162d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	01 c8                	add    %ecx,%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801639:	ff 45 fc             	incl   -0x4(%ebp)
  80163c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80163f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801642:	7c e1                	jl     801625 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801644:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80164b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801652:	eb 1f                	jmp    801673 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801654:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801657:	8d 50 01             	lea    0x1(%eax),%edx
  80165a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80165d:	89 c2                	mov    %eax,%edx
  80165f:	8b 45 10             	mov    0x10(%ebp),%eax
  801662:	01 c2                	add    %eax,%edx
  801664:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166a:	01 c8                	add    %ecx,%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801670:	ff 45 f8             	incl   -0x8(%ebp)
  801673:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801676:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801679:	7c d9                	jl     801654 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80167b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80167e:	8b 45 10             	mov    0x10(%ebp),%eax
  801681:	01 d0                	add    %edx,%eax
  801683:	c6 00 00             	movb   $0x0,(%eax)
}
  801686:	90                   	nop
  801687:	c9                   	leave  
  801688:	c3                   	ret    

00801689 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801689:	55                   	push   %ebp
  80168a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80168c:	8b 45 14             	mov    0x14(%ebp),%eax
  80168f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801695:	8b 45 14             	mov    0x14(%ebp),%eax
  801698:	8b 00                	mov    (%eax),%eax
  80169a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a4:	01 d0                	add    %edx,%eax
  8016a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016ac:	eb 0c                	jmp    8016ba <strsplit+0x31>
			*string++ = 0;
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	8d 50 01             	lea    0x1(%eax),%edx
  8016b4:	89 55 08             	mov    %edx,0x8(%ebp)
  8016b7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	84 c0                	test   %al,%al
  8016c1:	74 18                	je     8016db <strsplit+0x52>
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 00                	mov    (%eax),%al
  8016c8:	0f be c0             	movsbl %al,%eax
  8016cb:	50                   	push   %eax
  8016cc:	ff 75 0c             	pushl  0xc(%ebp)
  8016cf:	e8 13 fb ff ff       	call   8011e7 <strchr>
  8016d4:	83 c4 08             	add    $0x8,%esp
  8016d7:	85 c0                	test   %eax,%eax
  8016d9:	75 d3                	jne    8016ae <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	8a 00                	mov    (%eax),%al
  8016e0:	84 c0                	test   %al,%al
  8016e2:	74 5a                	je     80173e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8016e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e7:	8b 00                	mov    (%eax),%eax
  8016e9:	83 f8 0f             	cmp    $0xf,%eax
  8016ec:	75 07                	jne    8016f5 <strsplit+0x6c>
		{
			return 0;
  8016ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8016f3:	eb 66                	jmp    80175b <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8016f8:	8b 00                	mov    (%eax),%eax
  8016fa:	8d 48 01             	lea    0x1(%eax),%ecx
  8016fd:	8b 55 14             	mov    0x14(%ebp),%edx
  801700:	89 0a                	mov    %ecx,(%edx)
  801702:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801709:	8b 45 10             	mov    0x10(%ebp),%eax
  80170c:	01 c2                	add    %eax,%edx
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801713:	eb 03                	jmp    801718 <strsplit+0x8f>
			string++;
  801715:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	84 c0                	test   %al,%al
  80171f:	74 8b                	je     8016ac <strsplit+0x23>
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	0f be c0             	movsbl %al,%eax
  801729:	50                   	push   %eax
  80172a:	ff 75 0c             	pushl  0xc(%ebp)
  80172d:	e8 b5 fa ff ff       	call   8011e7 <strchr>
  801732:	83 c4 08             	add    $0x8,%esp
  801735:	85 c0                	test   %eax,%eax
  801737:	74 dc                	je     801715 <strsplit+0x8c>
			string++;
	}
  801739:	e9 6e ff ff ff       	jmp    8016ac <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80173e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80173f:	8b 45 14             	mov    0x14(%ebp),%eax
  801742:	8b 00                	mov    (%eax),%eax
  801744:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80174b:	8b 45 10             	mov    0x10(%ebp),%eax
  80174e:	01 d0                	add    %edx,%eax
  801750:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801756:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
  801760:	83 ec 18             	sub    $0x18,%esp
  801763:	8b 45 10             	mov    0x10(%ebp),%eax
  801766:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801769:	83 ec 04             	sub    $0x4,%esp
  80176c:	68 10 29 80 00       	push   $0x802910
  801771:	6a 17                	push   $0x17
  801773:	68 2f 29 80 00       	push   $0x80292f
  801778:	e8 a2 ef ff ff       	call   80071f <_panic>

0080177d <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
  801780:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801783:	83 ec 04             	sub    $0x4,%esp
  801786:	68 3b 29 80 00       	push   $0x80293b
  80178b:	6a 2f                	push   $0x2f
  80178d:	68 2f 29 80 00       	push   $0x80292f
  801792:	e8 88 ef ff ff       	call   80071f <_panic>

00801797 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
  80179a:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  80179d:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8017a4:	8b 55 08             	mov    0x8(%ebp),%edx
  8017a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017aa:	01 d0                	add    %edx,%eax
  8017ac:	48                   	dec    %eax
  8017ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8017b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017b3:	ba 00 00 00 00       	mov    $0x0,%edx
  8017b8:	f7 75 ec             	divl   -0x14(%ebp)
  8017bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017be:	29 d0                	sub    %edx,%eax
  8017c0:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8017c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c6:	c1 e8 0c             	shr    $0xc,%eax
  8017c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8017cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8017d3:	e9 c8 00 00 00       	jmp    8018a0 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8017d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8017df:	eb 27                	jmp    801808 <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8017e1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017e7:	01 c2                	add    %eax,%edx
  8017e9:	89 d0                	mov    %edx,%eax
  8017eb:	01 c0                	add    %eax,%eax
  8017ed:	01 d0                	add    %edx,%eax
  8017ef:	c1 e0 02             	shl    $0x2,%eax
  8017f2:	05 48 30 80 00       	add    $0x803048,%eax
  8017f7:	8b 00                	mov    (%eax),%eax
  8017f9:	85 c0                	test   %eax,%eax
  8017fb:	74 08                	je     801805 <malloc+0x6e>
            	i += j;
  8017fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801800:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801803:	eb 0b                	jmp    801810 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801805:	ff 45 f0             	incl   -0x10(%ebp)
  801808:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80180b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80180e:	72 d1                	jb     8017e1 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801810:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801813:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801816:	0f 85 81 00 00 00    	jne    80189d <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  80181c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80181f:	05 00 00 08 00       	add    $0x80000,%eax
  801824:	c1 e0 0c             	shl    $0xc,%eax
  801827:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80182a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801831:	eb 1f                	jmp    801852 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801833:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801836:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801839:	01 c2                	add    %eax,%edx
  80183b:	89 d0                	mov    %edx,%eax
  80183d:	01 c0                	add    %eax,%eax
  80183f:	01 d0                	add    %edx,%eax
  801841:	c1 e0 02             	shl    $0x2,%eax
  801844:	05 48 30 80 00       	add    $0x803048,%eax
  801849:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  80184f:	ff 45 f0             	incl   -0x10(%ebp)
  801852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801855:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801858:	72 d9                	jb     801833 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80185a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80185d:	89 d0                	mov    %edx,%eax
  80185f:	01 c0                	add    %eax,%eax
  801861:	01 d0                	add    %edx,%eax
  801863:	c1 e0 02             	shl    $0x2,%eax
  801866:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  80186c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80186f:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801871:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801874:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801877:	89 c8                	mov    %ecx,%eax
  801879:	01 c0                	add    %eax,%eax
  80187b:	01 c8                	add    %ecx,%eax
  80187d:	c1 e0 02             	shl    $0x2,%eax
  801880:	05 44 30 80 00       	add    $0x803044,%eax
  801885:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801887:	83 ec 08             	sub    $0x8,%esp
  80188a:	ff 75 08             	pushl  0x8(%ebp)
  80188d:	ff 75 e0             	pushl  -0x20(%ebp)
  801890:	e8 2b 03 00 00       	call   801bc0 <sys_allocateMem>
  801895:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801898:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80189b:	eb 19                	jmp    8018b6 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  80189d:	ff 45 f4             	incl   -0xc(%ebp)
  8018a0:	a1 04 30 80 00       	mov    0x803004,%eax
  8018a5:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8018a8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018ab:	0f 83 27 ff ff ff    	jae    8017d8 <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8018b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
  8018bb:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8018be:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018c2:	0f 84 e5 00 00 00    	je     8019ad <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8018ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018d1:	05 00 00 00 80       	add    $0x80000000,%eax
  8018d6:	c1 e8 0c             	shr    $0xc,%eax
  8018d9:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8018dc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018df:	89 d0                	mov    %edx,%eax
  8018e1:	01 c0                	add    %eax,%eax
  8018e3:	01 d0                	add    %edx,%eax
  8018e5:	c1 e0 02             	shl    $0x2,%eax
  8018e8:	05 40 30 80 00       	add    $0x803040,%eax
  8018ed:	8b 00                	mov    (%eax),%eax
  8018ef:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018f2:	0f 85 b8 00 00 00    	jne    8019b0 <free+0xf8>
  8018f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018fb:	89 d0                	mov    %edx,%eax
  8018fd:	01 c0                	add    %eax,%eax
  8018ff:	01 d0                	add    %edx,%eax
  801901:	c1 e0 02             	shl    $0x2,%eax
  801904:	05 48 30 80 00       	add    $0x803048,%eax
  801909:	8b 00                	mov    (%eax),%eax
  80190b:	85 c0                	test   %eax,%eax
  80190d:	0f 84 9d 00 00 00    	je     8019b0 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801913:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801916:	89 d0                	mov    %edx,%eax
  801918:	01 c0                	add    %eax,%eax
  80191a:	01 d0                	add    %edx,%eax
  80191c:	c1 e0 02             	shl    $0x2,%eax
  80191f:	05 44 30 80 00       	add    $0x803044,%eax
  801924:	8b 00                	mov    (%eax),%eax
  801926:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801929:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80192c:	c1 e0 0c             	shl    $0xc,%eax
  80192f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801932:	83 ec 08             	sub    $0x8,%esp
  801935:	ff 75 e4             	pushl  -0x1c(%ebp)
  801938:	ff 75 f0             	pushl  -0x10(%ebp)
  80193b:	e8 64 02 00 00       	call   801ba4 <sys_freeMem>
  801940:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801943:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80194a:	eb 57                	jmp    8019a3 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  80194c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801952:	01 c2                	add    %eax,%edx
  801954:	89 d0                	mov    %edx,%eax
  801956:	01 c0                	add    %eax,%eax
  801958:	01 d0                	add    %edx,%eax
  80195a:	c1 e0 02             	shl    $0x2,%eax
  80195d:	05 48 30 80 00       	add    $0x803048,%eax
  801962:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801968:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80196b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80196e:	01 c2                	add    %eax,%edx
  801970:	89 d0                	mov    %edx,%eax
  801972:	01 c0                	add    %eax,%eax
  801974:	01 d0                	add    %edx,%eax
  801976:	c1 e0 02             	shl    $0x2,%eax
  801979:	05 40 30 80 00       	add    $0x803040,%eax
  80197e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801984:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801987:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198a:	01 c2                	add    %eax,%edx
  80198c:	89 d0                	mov    %edx,%eax
  80198e:	01 c0                	add    %eax,%eax
  801990:	01 d0                	add    %edx,%eax
  801992:	c1 e0 02             	shl    $0x2,%eax
  801995:	05 44 30 80 00       	add    $0x803044,%eax
  80199a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8019a0:	ff 45 f4             	incl   -0xc(%ebp)
  8019a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8019a9:	7c a1                	jl     80194c <free+0x94>
  8019ab:	eb 04                	jmp    8019b1 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8019ad:	90                   	nop
  8019ae:	eb 01                	jmp    8019b1 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8019b0:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8019b9:	83 ec 04             	sub    $0x4,%esp
  8019bc:	68 58 29 80 00       	push   $0x802958
  8019c1:	68 ae 00 00 00       	push   $0xae
  8019c6:	68 2f 29 80 00       	push   $0x80292f
  8019cb:	e8 4f ed ff ff       	call   80071f <_panic>

008019d0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
  8019d3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8019d6:	83 ec 04             	sub    $0x4,%esp
  8019d9:	68 78 29 80 00       	push   $0x802978
  8019de:	68 ca 00 00 00       	push   $0xca
  8019e3:	68 2f 29 80 00       	push   $0x80292f
  8019e8:	e8 32 ed ff ff       	call   80071f <_panic>

008019ed <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019ed:	55                   	push   %ebp
  8019ee:	89 e5                	mov    %esp,%ebp
  8019f0:	57                   	push   %edi
  8019f1:	56                   	push   %esi
  8019f2:	53                   	push   %ebx
  8019f3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019ff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a02:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a05:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a08:	cd 30                	int    $0x30
  801a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a10:	83 c4 10             	add    $0x10,%esp
  801a13:	5b                   	pop    %ebx
  801a14:	5e                   	pop    %esi
  801a15:	5f                   	pop    %edi
  801a16:	5d                   	pop    %ebp
  801a17:	c3                   	ret    

00801a18 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a18:	55                   	push   %ebp
  801a19:	89 e5                	mov    %esp,%ebp
  801a1b:	83 ec 04             	sub    $0x4,%esp
  801a1e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a21:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a24:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a28:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2b:	6a 00                	push   $0x0
  801a2d:	6a 00                	push   $0x0
  801a2f:	52                   	push   %edx
  801a30:	ff 75 0c             	pushl  0xc(%ebp)
  801a33:	50                   	push   %eax
  801a34:	6a 00                	push   $0x0
  801a36:	e8 b2 ff ff ff       	call   8019ed <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
}
  801a3e:	90                   	nop
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 01                	push   $0x1
  801a50:	e8 98 ff ff ff       	call   8019ed <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	50                   	push   %eax
  801a69:	6a 05                	push   $0x5
  801a6b:	e8 7d ff ff ff       	call   8019ed <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
}
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	6a 00                	push   $0x0
  801a80:	6a 00                	push   $0x0
  801a82:	6a 02                	push   $0x2
  801a84:	e8 64 ff ff ff       	call   8019ed <syscall>
  801a89:	83 c4 18             	add    $0x18,%esp
}
  801a8c:	c9                   	leave  
  801a8d:	c3                   	ret    

00801a8e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a8e:	55                   	push   %ebp
  801a8f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 03                	push   $0x3
  801a9d:	e8 4b ff ff ff       	call   8019ed <syscall>
  801aa2:	83 c4 18             	add    $0x18,%esp
}
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aaa:	6a 00                	push   $0x0
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 04                	push   $0x4
  801ab6:	e8 32 ff ff ff       	call   8019ed <syscall>
  801abb:	83 c4 18             	add    $0x18,%esp
}
  801abe:	c9                   	leave  
  801abf:	c3                   	ret    

00801ac0 <sys_env_exit>:


void sys_env_exit(void)
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 06                	push   $0x6
  801acf:	e8 19 ff ff ff       	call   8019ed <syscall>
  801ad4:	83 c4 18             	add    $0x18,%esp
}
  801ad7:	90                   	nop
  801ad8:	c9                   	leave  
  801ad9:	c3                   	ret    

00801ada <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801add:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	52                   	push   %edx
  801aea:	50                   	push   %eax
  801aeb:	6a 07                	push   $0x7
  801aed:	e8 fb fe ff ff       	call   8019ed <syscall>
  801af2:	83 c4 18             	add    $0x18,%esp
}
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
  801afa:	56                   	push   %esi
  801afb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801afc:	8b 75 18             	mov    0x18(%ebp),%esi
  801aff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b02:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b08:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0b:	56                   	push   %esi
  801b0c:	53                   	push   %ebx
  801b0d:	51                   	push   %ecx
  801b0e:	52                   	push   %edx
  801b0f:	50                   	push   %eax
  801b10:	6a 08                	push   $0x8
  801b12:	e8 d6 fe ff ff       	call   8019ed <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b1d:	5b                   	pop    %ebx
  801b1e:	5e                   	pop    %esi
  801b1f:	5d                   	pop    %ebp
  801b20:	c3                   	ret    

00801b21 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b21:	55                   	push   %ebp
  801b22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b27:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	52                   	push   %edx
  801b31:	50                   	push   %eax
  801b32:	6a 09                	push   $0x9
  801b34:	e8 b4 fe ff ff       	call   8019ed <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
}
  801b3c:	c9                   	leave  
  801b3d:	c3                   	ret    

00801b3e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b3e:	55                   	push   %ebp
  801b3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	ff 75 0c             	pushl  0xc(%ebp)
  801b4a:	ff 75 08             	pushl  0x8(%ebp)
  801b4d:	6a 0a                	push   $0xa
  801b4f:	e8 99 fe ff ff       	call   8019ed <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
}
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 0b                	push   $0xb
  801b68:	e8 80 fe ff ff       	call   8019ed <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 0c                	push   $0xc
  801b81:	e8 67 fe ff ff       	call   8019ed <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 0d                	push   $0xd
  801b9a:	e8 4e fe ff ff       	call   8019ed <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	ff 75 0c             	pushl  0xc(%ebp)
  801bb0:	ff 75 08             	pushl  0x8(%ebp)
  801bb3:	6a 11                	push   $0x11
  801bb5:	e8 33 fe ff ff       	call   8019ed <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
	return;
  801bbd:	90                   	nop
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	ff 75 0c             	pushl  0xc(%ebp)
  801bcc:	ff 75 08             	pushl  0x8(%ebp)
  801bcf:	6a 12                	push   $0x12
  801bd1:	e8 17 fe ff ff       	call   8019ed <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd9:	90                   	nop
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 0e                	push   $0xe
  801beb:	e8 fd fd ff ff       	call   8019ed <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
}
  801bf3:	c9                   	leave  
  801bf4:	c3                   	ret    

00801bf5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bf5:	55                   	push   %ebp
  801bf6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	ff 75 08             	pushl  0x8(%ebp)
  801c03:	6a 0f                	push   $0xf
  801c05:	e8 e3 fd ff ff       	call   8019ed <syscall>
  801c0a:	83 c4 18             	add    $0x18,%esp
}
  801c0d:	c9                   	leave  
  801c0e:	c3                   	ret    

00801c0f <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c0f:	55                   	push   %ebp
  801c10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 10                	push   $0x10
  801c1e:	e8 ca fd ff ff       	call   8019ed <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
}
  801c26:	90                   	nop
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 14                	push   $0x14
  801c38:	e8 b0 fd ff ff       	call   8019ed <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
}
  801c40:	90                   	nop
  801c41:	c9                   	leave  
  801c42:	c3                   	ret    

00801c43 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 15                	push   $0x15
  801c52:	e8 96 fd ff ff       	call   8019ed <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
}
  801c5a:	90                   	nop
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_cputc>:


void
sys_cputc(const char c)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
  801c60:	83 ec 04             	sub    $0x4,%esp
  801c63:	8b 45 08             	mov    0x8(%ebp),%eax
  801c66:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c69:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	50                   	push   %eax
  801c76:	6a 16                	push   $0x16
  801c78:	e8 70 fd ff ff       	call   8019ed <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	90                   	nop
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 17                	push   $0x17
  801c92:	e8 56 fd ff ff       	call   8019ed <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
}
  801c9a:	90                   	nop
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	ff 75 0c             	pushl  0xc(%ebp)
  801cac:	50                   	push   %eax
  801cad:	6a 18                	push   $0x18
  801caf:	e8 39 fd ff ff       	call   8019ed <syscall>
  801cb4:	83 c4 18             	add    $0x18,%esp
}
  801cb7:	c9                   	leave  
  801cb8:	c3                   	ret    

00801cb9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cb9:	55                   	push   %ebp
  801cba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	52                   	push   %edx
  801cc9:	50                   	push   %eax
  801cca:	6a 1b                	push   $0x1b
  801ccc:	e8 1c fd ff ff       	call   8019ed <syscall>
  801cd1:	83 c4 18             	add    $0x18,%esp
}
  801cd4:	c9                   	leave  
  801cd5:	c3                   	ret    

00801cd6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cd6:	55                   	push   %ebp
  801cd7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	52                   	push   %edx
  801ce6:	50                   	push   %eax
  801ce7:	6a 19                	push   $0x19
  801ce9:	e8 ff fc ff ff       	call   8019ed <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
}
  801cf1:	90                   	nop
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	52                   	push   %edx
  801d04:	50                   	push   %eax
  801d05:	6a 1a                	push   $0x1a
  801d07:	e8 e1 fc ff ff       	call   8019ed <syscall>
  801d0c:	83 c4 18             	add    $0x18,%esp
}
  801d0f:	90                   	nop
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
  801d15:	83 ec 04             	sub    $0x4,%esp
  801d18:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d1e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d21:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d25:	8b 45 08             	mov    0x8(%ebp),%eax
  801d28:	6a 00                	push   $0x0
  801d2a:	51                   	push   %ecx
  801d2b:	52                   	push   %edx
  801d2c:	ff 75 0c             	pushl  0xc(%ebp)
  801d2f:	50                   	push   %eax
  801d30:	6a 1c                	push   $0x1c
  801d32:	e8 b6 fc ff ff       	call   8019ed <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d3f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d42:	8b 45 08             	mov    0x8(%ebp),%eax
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	52                   	push   %edx
  801d4c:	50                   	push   %eax
  801d4d:	6a 1d                	push   $0x1d
  801d4f:	e8 99 fc ff ff       	call   8019ed <syscall>
  801d54:	83 c4 18             	add    $0x18,%esp
}
  801d57:	c9                   	leave  
  801d58:	c3                   	ret    

00801d59 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d59:	55                   	push   %ebp
  801d5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d5c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d62:	8b 45 08             	mov    0x8(%ebp),%eax
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	51                   	push   %ecx
  801d6a:	52                   	push   %edx
  801d6b:	50                   	push   %eax
  801d6c:	6a 1e                	push   $0x1e
  801d6e:	e8 7a fc ff ff       	call   8019ed <syscall>
  801d73:	83 c4 18             	add    $0x18,%esp
}
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	52                   	push   %edx
  801d88:	50                   	push   %eax
  801d89:	6a 1f                	push   $0x1f
  801d8b:	e8 5d fc ff ff       	call   8019ed <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 20                	push   $0x20
  801da4:	e8 44 fc ff ff       	call   8019ed <syscall>
  801da9:	83 c4 18             	add    $0x18,%esp
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	ff 75 10             	pushl  0x10(%ebp)
  801dbb:	ff 75 0c             	pushl  0xc(%ebp)
  801dbe:	50                   	push   %eax
  801dbf:	6a 21                	push   $0x21
  801dc1:	e8 27 fc ff ff       	call   8019ed <syscall>
  801dc6:	83 c4 18             	add    $0x18,%esp
}
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	50                   	push   %eax
  801dda:	6a 22                	push   $0x22
  801ddc:	e8 0c fc ff ff       	call   8019ed <syscall>
  801de1:	83 c4 18             	add    $0x18,%esp
}
  801de4:	90                   	nop
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	50                   	push   %eax
  801df6:	6a 23                	push   $0x23
  801df8:	e8 f0 fb ff ff       	call   8019ed <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	90                   	nop
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
  801e06:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e09:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e0c:	8d 50 04             	lea    0x4(%eax),%edx
  801e0f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	52                   	push   %edx
  801e19:	50                   	push   %eax
  801e1a:	6a 24                	push   $0x24
  801e1c:	e8 cc fb ff ff       	call   8019ed <syscall>
  801e21:	83 c4 18             	add    $0x18,%esp
	return result;
  801e24:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e2d:	89 01                	mov    %eax,(%ecx)
  801e2f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e32:	8b 45 08             	mov    0x8(%ebp),%eax
  801e35:	c9                   	leave  
  801e36:	c2 04 00             	ret    $0x4

00801e39 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	ff 75 10             	pushl  0x10(%ebp)
  801e43:	ff 75 0c             	pushl  0xc(%ebp)
  801e46:	ff 75 08             	pushl  0x8(%ebp)
  801e49:	6a 13                	push   $0x13
  801e4b:	e8 9d fb ff ff       	call   8019ed <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
	return ;
  801e53:	90                   	nop
}
  801e54:	c9                   	leave  
  801e55:	c3                   	ret    

00801e56 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e56:	55                   	push   %ebp
  801e57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 25                	push   $0x25
  801e65:	e8 83 fb ff ff       	call   8019ed <syscall>
  801e6a:	83 c4 18             	add    $0x18,%esp
}
  801e6d:	c9                   	leave  
  801e6e:	c3                   	ret    

00801e6f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
  801e72:	83 ec 04             	sub    $0x4,%esp
  801e75:	8b 45 08             	mov    0x8(%ebp),%eax
  801e78:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e7b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	50                   	push   %eax
  801e88:	6a 26                	push   $0x26
  801e8a:	e8 5e fb ff ff       	call   8019ed <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e92:	90                   	nop
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <rsttst>:
void rsttst()
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 28                	push   $0x28
  801ea4:	e8 44 fb ff ff       	call   8019ed <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
	return ;
  801eac:	90                   	nop
}
  801ead:	c9                   	leave  
  801eae:	c3                   	ret    

00801eaf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801eaf:	55                   	push   %ebp
  801eb0:	89 e5                	mov    %esp,%ebp
  801eb2:	83 ec 04             	sub    $0x4,%esp
  801eb5:	8b 45 14             	mov    0x14(%ebp),%eax
  801eb8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ebb:	8b 55 18             	mov    0x18(%ebp),%edx
  801ebe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	ff 75 10             	pushl  0x10(%ebp)
  801ec7:	ff 75 0c             	pushl  0xc(%ebp)
  801eca:	ff 75 08             	pushl  0x8(%ebp)
  801ecd:	6a 27                	push   $0x27
  801ecf:	e8 19 fb ff ff       	call   8019ed <syscall>
  801ed4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed7:	90                   	nop
}
  801ed8:	c9                   	leave  
  801ed9:	c3                   	ret    

00801eda <chktst>:
void chktst(uint32 n)
{
  801eda:	55                   	push   %ebp
  801edb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	ff 75 08             	pushl  0x8(%ebp)
  801ee8:	6a 29                	push   $0x29
  801eea:	e8 fe fa ff ff       	call   8019ed <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef2:	90                   	nop
}
  801ef3:	c9                   	leave  
  801ef4:	c3                   	ret    

00801ef5 <inctst>:

void inctst()
{
  801ef5:	55                   	push   %ebp
  801ef6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 2a                	push   $0x2a
  801f04:	e8 e4 fa ff ff       	call   8019ed <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0c:	90                   	nop
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <gettst>:
uint32 gettst()
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 2b                	push   $0x2b
  801f1e:	e8 ca fa ff ff       	call   8019ed <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
  801f2b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 2c                	push   $0x2c
  801f3a:	e8 ae fa ff ff       	call   8019ed <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
  801f42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f45:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f49:	75 07                	jne    801f52 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f4b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f50:	eb 05                	jmp    801f57 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
  801f5c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 2c                	push   $0x2c
  801f6b:	e8 7d fa ff ff       	call   8019ed <syscall>
  801f70:	83 c4 18             	add    $0x18,%esp
  801f73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f76:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f7a:	75 07                	jne    801f83 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f7c:	b8 01 00 00 00       	mov    $0x1,%eax
  801f81:	eb 05                	jmp    801f88 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 2c                	push   $0x2c
  801f9c:	e8 4c fa ff ff       	call   8019ed <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
  801fa4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fa7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fab:	75 07                	jne    801fb4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fad:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb2:	eb 05                	jmp    801fb9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
  801fbe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 2c                	push   $0x2c
  801fcd:	e8 1b fa ff ff       	call   8019ed <syscall>
  801fd2:	83 c4 18             	add    $0x18,%esp
  801fd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fd8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fdc:	75 07                	jne    801fe5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fde:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe3:	eb 05                	jmp    801fea <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fe5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	ff 75 08             	pushl  0x8(%ebp)
  801ffa:	6a 2d                	push   $0x2d
  801ffc:	e8 ec f9 ff ff       	call   8019ed <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
	return ;
  802004:	90                   	nop
}
  802005:	c9                   	leave  
  802006:	c3                   	ret    
  802007:	90                   	nop

00802008 <__udivdi3>:
  802008:	55                   	push   %ebp
  802009:	57                   	push   %edi
  80200a:	56                   	push   %esi
  80200b:	53                   	push   %ebx
  80200c:	83 ec 1c             	sub    $0x1c,%esp
  80200f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802013:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802017:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80201b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80201f:	89 ca                	mov    %ecx,%edx
  802021:	89 f8                	mov    %edi,%eax
  802023:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802027:	85 f6                	test   %esi,%esi
  802029:	75 2d                	jne    802058 <__udivdi3+0x50>
  80202b:	39 cf                	cmp    %ecx,%edi
  80202d:	77 65                	ja     802094 <__udivdi3+0x8c>
  80202f:	89 fd                	mov    %edi,%ebp
  802031:	85 ff                	test   %edi,%edi
  802033:	75 0b                	jne    802040 <__udivdi3+0x38>
  802035:	b8 01 00 00 00       	mov    $0x1,%eax
  80203a:	31 d2                	xor    %edx,%edx
  80203c:	f7 f7                	div    %edi
  80203e:	89 c5                	mov    %eax,%ebp
  802040:	31 d2                	xor    %edx,%edx
  802042:	89 c8                	mov    %ecx,%eax
  802044:	f7 f5                	div    %ebp
  802046:	89 c1                	mov    %eax,%ecx
  802048:	89 d8                	mov    %ebx,%eax
  80204a:	f7 f5                	div    %ebp
  80204c:	89 cf                	mov    %ecx,%edi
  80204e:	89 fa                	mov    %edi,%edx
  802050:	83 c4 1c             	add    $0x1c,%esp
  802053:	5b                   	pop    %ebx
  802054:	5e                   	pop    %esi
  802055:	5f                   	pop    %edi
  802056:	5d                   	pop    %ebp
  802057:	c3                   	ret    
  802058:	39 ce                	cmp    %ecx,%esi
  80205a:	77 28                	ja     802084 <__udivdi3+0x7c>
  80205c:	0f bd fe             	bsr    %esi,%edi
  80205f:	83 f7 1f             	xor    $0x1f,%edi
  802062:	75 40                	jne    8020a4 <__udivdi3+0x9c>
  802064:	39 ce                	cmp    %ecx,%esi
  802066:	72 0a                	jb     802072 <__udivdi3+0x6a>
  802068:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80206c:	0f 87 9e 00 00 00    	ja     802110 <__udivdi3+0x108>
  802072:	b8 01 00 00 00       	mov    $0x1,%eax
  802077:	89 fa                	mov    %edi,%edx
  802079:	83 c4 1c             	add    $0x1c,%esp
  80207c:	5b                   	pop    %ebx
  80207d:	5e                   	pop    %esi
  80207e:	5f                   	pop    %edi
  80207f:	5d                   	pop    %ebp
  802080:	c3                   	ret    
  802081:	8d 76 00             	lea    0x0(%esi),%esi
  802084:	31 ff                	xor    %edi,%edi
  802086:	31 c0                	xor    %eax,%eax
  802088:	89 fa                	mov    %edi,%edx
  80208a:	83 c4 1c             	add    $0x1c,%esp
  80208d:	5b                   	pop    %ebx
  80208e:	5e                   	pop    %esi
  80208f:	5f                   	pop    %edi
  802090:	5d                   	pop    %ebp
  802091:	c3                   	ret    
  802092:	66 90                	xchg   %ax,%ax
  802094:	89 d8                	mov    %ebx,%eax
  802096:	f7 f7                	div    %edi
  802098:	31 ff                	xor    %edi,%edi
  80209a:	89 fa                	mov    %edi,%edx
  80209c:	83 c4 1c             	add    $0x1c,%esp
  80209f:	5b                   	pop    %ebx
  8020a0:	5e                   	pop    %esi
  8020a1:	5f                   	pop    %edi
  8020a2:	5d                   	pop    %ebp
  8020a3:	c3                   	ret    
  8020a4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020a9:	89 eb                	mov    %ebp,%ebx
  8020ab:	29 fb                	sub    %edi,%ebx
  8020ad:	89 f9                	mov    %edi,%ecx
  8020af:	d3 e6                	shl    %cl,%esi
  8020b1:	89 c5                	mov    %eax,%ebp
  8020b3:	88 d9                	mov    %bl,%cl
  8020b5:	d3 ed                	shr    %cl,%ebp
  8020b7:	89 e9                	mov    %ebp,%ecx
  8020b9:	09 f1                	or     %esi,%ecx
  8020bb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8020bf:	89 f9                	mov    %edi,%ecx
  8020c1:	d3 e0                	shl    %cl,%eax
  8020c3:	89 c5                	mov    %eax,%ebp
  8020c5:	89 d6                	mov    %edx,%esi
  8020c7:	88 d9                	mov    %bl,%cl
  8020c9:	d3 ee                	shr    %cl,%esi
  8020cb:	89 f9                	mov    %edi,%ecx
  8020cd:	d3 e2                	shl    %cl,%edx
  8020cf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020d3:	88 d9                	mov    %bl,%cl
  8020d5:	d3 e8                	shr    %cl,%eax
  8020d7:	09 c2                	or     %eax,%edx
  8020d9:	89 d0                	mov    %edx,%eax
  8020db:	89 f2                	mov    %esi,%edx
  8020dd:	f7 74 24 0c          	divl   0xc(%esp)
  8020e1:	89 d6                	mov    %edx,%esi
  8020e3:	89 c3                	mov    %eax,%ebx
  8020e5:	f7 e5                	mul    %ebp
  8020e7:	39 d6                	cmp    %edx,%esi
  8020e9:	72 19                	jb     802104 <__udivdi3+0xfc>
  8020eb:	74 0b                	je     8020f8 <__udivdi3+0xf0>
  8020ed:	89 d8                	mov    %ebx,%eax
  8020ef:	31 ff                	xor    %edi,%edi
  8020f1:	e9 58 ff ff ff       	jmp    80204e <__udivdi3+0x46>
  8020f6:	66 90                	xchg   %ax,%ax
  8020f8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8020fc:	89 f9                	mov    %edi,%ecx
  8020fe:	d3 e2                	shl    %cl,%edx
  802100:	39 c2                	cmp    %eax,%edx
  802102:	73 e9                	jae    8020ed <__udivdi3+0xe5>
  802104:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802107:	31 ff                	xor    %edi,%edi
  802109:	e9 40 ff ff ff       	jmp    80204e <__udivdi3+0x46>
  80210e:	66 90                	xchg   %ax,%ax
  802110:	31 c0                	xor    %eax,%eax
  802112:	e9 37 ff ff ff       	jmp    80204e <__udivdi3+0x46>
  802117:	90                   	nop

00802118 <__umoddi3>:
  802118:	55                   	push   %ebp
  802119:	57                   	push   %edi
  80211a:	56                   	push   %esi
  80211b:	53                   	push   %ebx
  80211c:	83 ec 1c             	sub    $0x1c,%esp
  80211f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802123:	8b 74 24 34          	mov    0x34(%esp),%esi
  802127:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80212b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80212f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802133:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802137:	89 f3                	mov    %esi,%ebx
  802139:	89 fa                	mov    %edi,%edx
  80213b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80213f:	89 34 24             	mov    %esi,(%esp)
  802142:	85 c0                	test   %eax,%eax
  802144:	75 1a                	jne    802160 <__umoddi3+0x48>
  802146:	39 f7                	cmp    %esi,%edi
  802148:	0f 86 a2 00 00 00    	jbe    8021f0 <__umoddi3+0xd8>
  80214e:	89 c8                	mov    %ecx,%eax
  802150:	89 f2                	mov    %esi,%edx
  802152:	f7 f7                	div    %edi
  802154:	89 d0                	mov    %edx,%eax
  802156:	31 d2                	xor    %edx,%edx
  802158:	83 c4 1c             	add    $0x1c,%esp
  80215b:	5b                   	pop    %ebx
  80215c:	5e                   	pop    %esi
  80215d:	5f                   	pop    %edi
  80215e:	5d                   	pop    %ebp
  80215f:	c3                   	ret    
  802160:	39 f0                	cmp    %esi,%eax
  802162:	0f 87 ac 00 00 00    	ja     802214 <__umoddi3+0xfc>
  802168:	0f bd e8             	bsr    %eax,%ebp
  80216b:	83 f5 1f             	xor    $0x1f,%ebp
  80216e:	0f 84 ac 00 00 00    	je     802220 <__umoddi3+0x108>
  802174:	bf 20 00 00 00       	mov    $0x20,%edi
  802179:	29 ef                	sub    %ebp,%edi
  80217b:	89 fe                	mov    %edi,%esi
  80217d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802181:	89 e9                	mov    %ebp,%ecx
  802183:	d3 e0                	shl    %cl,%eax
  802185:	89 d7                	mov    %edx,%edi
  802187:	89 f1                	mov    %esi,%ecx
  802189:	d3 ef                	shr    %cl,%edi
  80218b:	09 c7                	or     %eax,%edi
  80218d:	89 e9                	mov    %ebp,%ecx
  80218f:	d3 e2                	shl    %cl,%edx
  802191:	89 14 24             	mov    %edx,(%esp)
  802194:	89 d8                	mov    %ebx,%eax
  802196:	d3 e0                	shl    %cl,%eax
  802198:	89 c2                	mov    %eax,%edx
  80219a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80219e:	d3 e0                	shl    %cl,%eax
  8021a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021a8:	89 f1                	mov    %esi,%ecx
  8021aa:	d3 e8                	shr    %cl,%eax
  8021ac:	09 d0                	or     %edx,%eax
  8021ae:	d3 eb                	shr    %cl,%ebx
  8021b0:	89 da                	mov    %ebx,%edx
  8021b2:	f7 f7                	div    %edi
  8021b4:	89 d3                	mov    %edx,%ebx
  8021b6:	f7 24 24             	mull   (%esp)
  8021b9:	89 c6                	mov    %eax,%esi
  8021bb:	89 d1                	mov    %edx,%ecx
  8021bd:	39 d3                	cmp    %edx,%ebx
  8021bf:	0f 82 87 00 00 00    	jb     80224c <__umoddi3+0x134>
  8021c5:	0f 84 91 00 00 00    	je     80225c <__umoddi3+0x144>
  8021cb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8021cf:	29 f2                	sub    %esi,%edx
  8021d1:	19 cb                	sbb    %ecx,%ebx
  8021d3:	89 d8                	mov    %ebx,%eax
  8021d5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8021d9:	d3 e0                	shl    %cl,%eax
  8021db:	89 e9                	mov    %ebp,%ecx
  8021dd:	d3 ea                	shr    %cl,%edx
  8021df:	09 d0                	or     %edx,%eax
  8021e1:	89 e9                	mov    %ebp,%ecx
  8021e3:	d3 eb                	shr    %cl,%ebx
  8021e5:	89 da                	mov    %ebx,%edx
  8021e7:	83 c4 1c             	add    $0x1c,%esp
  8021ea:	5b                   	pop    %ebx
  8021eb:	5e                   	pop    %esi
  8021ec:	5f                   	pop    %edi
  8021ed:	5d                   	pop    %ebp
  8021ee:	c3                   	ret    
  8021ef:	90                   	nop
  8021f0:	89 fd                	mov    %edi,%ebp
  8021f2:	85 ff                	test   %edi,%edi
  8021f4:	75 0b                	jne    802201 <__umoddi3+0xe9>
  8021f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fb:	31 d2                	xor    %edx,%edx
  8021fd:	f7 f7                	div    %edi
  8021ff:	89 c5                	mov    %eax,%ebp
  802201:	89 f0                	mov    %esi,%eax
  802203:	31 d2                	xor    %edx,%edx
  802205:	f7 f5                	div    %ebp
  802207:	89 c8                	mov    %ecx,%eax
  802209:	f7 f5                	div    %ebp
  80220b:	89 d0                	mov    %edx,%eax
  80220d:	e9 44 ff ff ff       	jmp    802156 <__umoddi3+0x3e>
  802212:	66 90                	xchg   %ax,%ax
  802214:	89 c8                	mov    %ecx,%eax
  802216:	89 f2                	mov    %esi,%edx
  802218:	83 c4 1c             	add    $0x1c,%esp
  80221b:	5b                   	pop    %ebx
  80221c:	5e                   	pop    %esi
  80221d:	5f                   	pop    %edi
  80221e:	5d                   	pop    %ebp
  80221f:	c3                   	ret    
  802220:	3b 04 24             	cmp    (%esp),%eax
  802223:	72 06                	jb     80222b <__umoddi3+0x113>
  802225:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802229:	77 0f                	ja     80223a <__umoddi3+0x122>
  80222b:	89 f2                	mov    %esi,%edx
  80222d:	29 f9                	sub    %edi,%ecx
  80222f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802233:	89 14 24             	mov    %edx,(%esp)
  802236:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80223a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80223e:	8b 14 24             	mov    (%esp),%edx
  802241:	83 c4 1c             	add    $0x1c,%esp
  802244:	5b                   	pop    %ebx
  802245:	5e                   	pop    %esi
  802246:	5f                   	pop    %edi
  802247:	5d                   	pop    %ebp
  802248:	c3                   	ret    
  802249:	8d 76 00             	lea    0x0(%esi),%esi
  80224c:	2b 04 24             	sub    (%esp),%eax
  80224f:	19 fa                	sbb    %edi,%edx
  802251:	89 d1                	mov    %edx,%ecx
  802253:	89 c6                	mov    %eax,%esi
  802255:	e9 71 ff ff ff       	jmp    8021cb <__umoddi3+0xb3>
  80225a:	66 90                	xchg   %ax,%ax
  80225c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802260:	72 ea                	jb     80224c <__umoddi3+0x134>
  802262:	89 d9                	mov    %ebx,%ecx
  802264:	e9 62 ff ff ff       	jmp    8021cb <__umoddi3+0xb3>
