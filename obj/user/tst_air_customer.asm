
obj/user/tst_air_customer:     file format elf32-i386


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
  800031:	e8 dc 03 00 00       	call   800412 <libmain>
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
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	int32 parentenvID = sys_getparentenvid();
  800044:	e8 73 16 00 00       	call   8016bc <sys_getparentenvid>
  800049:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	char _customers[] = "customers";
  80004c:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80004f:	bb a9 20 80 00       	mov    $0x8020a9,%ebx
  800054:	ba 0a 00 00 00       	mov    $0xa,%edx
  800059:	89 c7                	mov    %eax,%edi
  80005b:	89 de                	mov    %ebx,%esi
  80005d:	89 d1                	mov    %edx,%ecx
  80005f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  800061:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800064:	bb b3 20 80 00       	mov    $0x8020b3,%ebx
  800069:	ba 03 00 00 00       	mov    $0x3,%edx
  80006e:	89 c7                	mov    %eax,%edi
  800070:	89 de                	mov    %ebx,%esi
  800072:	89 d1                	mov    %edx,%ecx
  800074:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  800076:	8d 45 a7             	lea    -0x59(%ebp),%eax
  800079:	bb bf 20 80 00       	mov    $0x8020bf,%ebx
  80007e:	ba 0f 00 00 00       	mov    $0xf,%edx
  800083:	89 c7                	mov    %eax,%edi
  800085:	89 de                	mov    %ebx,%esi
  800087:	89 d1                	mov    %edx,%ecx
  800089:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  80008b:	8d 45 98             	lea    -0x68(%ebp),%eax
  80008e:	bb ce 20 80 00       	mov    $0x8020ce,%ebx
  800093:	ba 0f 00 00 00       	mov    $0xf,%edx
  800098:	89 c7                	mov    %eax,%edi
  80009a:	89 de                	mov    %ebx,%esi
  80009c:	89 d1                	mov    %edx,%ecx
  80009e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000a0:	8d 45 83             	lea    -0x7d(%ebp),%eax
  8000a3:	bb dd 20 80 00       	mov    $0x8020dd,%ebx
  8000a8:	ba 15 00 00 00       	mov    $0x15,%edx
  8000ad:	89 c7                	mov    %eax,%edi
  8000af:	89 de                	mov    %ebx,%esi
  8000b1:	89 d1                	mov    %edx,%ecx
  8000b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000b5:	8d 85 6e ff ff ff    	lea    -0x92(%ebp),%eax
  8000bb:	bb f2 20 80 00       	mov    $0x8020f2,%ebx
  8000c0:	ba 15 00 00 00       	mov    $0x15,%edx
  8000c5:	89 c7                	mov    %eax,%edi
  8000c7:	89 de                	mov    %ebx,%esi
  8000c9:	89 d1                	mov    %edx,%ecx
  8000cb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  8000cd:	8d 85 5d ff ff ff    	lea    -0xa3(%ebp),%eax
  8000d3:	bb 07 21 80 00       	mov    $0x802107,%ebx
  8000d8:	ba 11 00 00 00       	mov    $0x11,%edx
  8000dd:	89 c7                	mov    %eax,%edi
  8000df:	89 de                	mov    %ebx,%esi
  8000e1:	89 d1                	mov    %edx,%ecx
  8000e3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  8000e5:	8d 85 4c ff ff ff    	lea    -0xb4(%ebp),%eax
  8000eb:	bb 18 21 80 00       	mov    $0x802118,%ebx
  8000f0:	ba 11 00 00 00       	mov    $0x11,%edx
  8000f5:	89 c7                	mov    %eax,%edi
  8000f7:	89 de                	mov    %ebx,%esi
  8000f9:	89 d1                	mov    %edx,%ecx
  8000fb:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  8000fd:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  800103:	bb 29 21 80 00       	mov    $0x802129,%ebx
  800108:	ba 11 00 00 00       	mov    $0x11,%edx
  80010d:	89 c7                	mov    %eax,%edi
  80010f:	89 de                	mov    %ebx,%esi
  800111:	89 d1                	mov    %edx,%ecx
  800113:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  800115:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  80011b:	bb 3a 21 80 00       	mov    $0x80213a,%ebx
  800120:	ba 09 00 00 00       	mov    $0x9,%edx
  800125:	89 c7                	mov    %eax,%edi
  800127:	89 de                	mov    %ebx,%esi
  800129:	89 d1                	mov    %edx,%ecx
  80012b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  80012d:	8d 85 28 ff ff ff    	lea    -0xd8(%ebp),%eax
  800133:	bb 43 21 80 00       	mov    $0x802143,%ebx
  800138:	ba 0a 00 00 00       	mov    $0xa,%edx
  80013d:	89 c7                	mov    %eax,%edi
  80013f:	89 de                	mov    %ebx,%esi
  800141:	89 d1                	mov    %edx,%ecx
  800143:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  800145:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  80014b:	bb 4d 21 80 00       	mov    $0x80214d,%ebx
  800150:	ba 0b 00 00 00       	mov    $0xb,%edx
  800155:	89 c7                	mov    %eax,%edi
  800157:	89 de                	mov    %ebx,%esi
  800159:	89 d1                	mov    %edx,%ecx
  80015b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  80015d:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  800163:	bb 58 21 80 00       	mov    $0x802158,%ebx
  800168:	ba 03 00 00 00       	mov    $0x3,%edx
  80016d:	89 c7                	mov    %eax,%edi
  80016f:	89 de                	mov    %ebx,%esi
  800171:	89 d1                	mov    %edx,%ecx
  800173:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  800175:	8d 85 07 ff ff ff    	lea    -0xf9(%ebp),%eax
  80017b:	bb 64 21 80 00       	mov    $0x802164,%ebx
  800180:	ba 0a 00 00 00       	mov    $0xa,%edx
  800185:	89 c7                	mov    %eax,%edi
  800187:	89 de                	mov    %ebx,%esi
  800189:	89 d1                	mov    %edx,%ecx
  80018b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  80018d:	8d 85 fd fe ff ff    	lea    -0x103(%ebp),%eax
  800193:	bb 6e 21 80 00       	mov    $0x80216e,%ebx
  800198:	ba 0a 00 00 00       	mov    $0xa,%edx
  80019d:	89 c7                	mov    %eax,%edi
  80019f:	89 de                	mov    %ebx,%esi
  8001a1:	89 d1                	mov    %edx,%ecx
  8001a3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001a5:	c7 85 f7 fe ff ff 63 	movl   $0x72656c63,-0x109(%ebp)
  8001ac:	6c 65 72 
  8001af:	66 c7 85 fb fe ff ff 	movw   $0x6b,-0x105(%ebp)
  8001b6:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001b8:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8001be:	bb 78 21 80 00       	mov    $0x802178,%ebx
  8001c3:	ba 0e 00 00 00       	mov    $0xe,%edx
  8001c8:	89 c7                	mov    %eax,%edi
  8001ca:	89 de                	mov    %ebx,%esi
  8001cc:	89 d1                	mov    %edx,%ecx
  8001ce:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  8001d0:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8001d6:	bb 86 21 80 00       	mov    $0x802186,%ebx
  8001db:	ba 0f 00 00 00       	mov    $0xf,%edx
  8001e0:	89 c7                	mov    %eax,%edi
  8001e2:	89 de                	mov    %ebx,%esi
  8001e4:	89 d1                	mov    %edx,%ecx
  8001e6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  8001e8:	8d 85 d3 fe ff ff    	lea    -0x12d(%ebp),%eax
  8001ee:	bb 95 21 80 00       	mov    $0x802195,%ebx
  8001f3:	ba 07 00 00 00       	mov    $0x7,%edx
  8001f8:	89 c7                	mov    %eax,%edi
  8001fa:	89 de                	mov    %ebx,%esi
  8001fc:	89 d1                	mov    %edx,%ecx
  8001fe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800200:	8d 85 cc fe ff ff    	lea    -0x134(%ebp),%eax
  800206:	bb 9c 21 80 00       	mov    $0x80219c,%ebx
  80020b:	ba 07 00 00 00       	mov    $0x7,%edx
  800210:	89 c7                	mov    %eax,%edi
  800212:	89 de                	mov    %ebx,%esi
  800214:	89 d1                	mov    %edx,%ecx
  800216:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	// Get the shared variables from the main program ***********************************

	struct Customer * customers = sget(parentenvID, _customers);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	8d 45 c2             	lea    -0x3e(%ebp),%eax
  80021e:	50                   	push   %eax
  80021f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800222:	e8 6b 11 00 00       	call   801392 <sget>
  800227:	83 c4 10             	add    $0x10,%esp
  80022a:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int* custCounter = sget(parentenvID, _custCounter);
  80022d:	83 ec 08             	sub    $0x8,%esp
  800230:	8d 45 b6             	lea    -0x4a(%ebp),%eax
  800233:	50                   	push   %eax
  800234:	ff 75 e4             	pushl  -0x1c(%ebp)
  800237:	e8 56 11 00 00       	call   801392 <sget>
  80023c:	83 c4 10             	add    $0x10,%esp
  80023f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int* cust_ready_queue = sget(parentenvID, _cust_ready_queue);
  800242:	83 ec 08             	sub    $0x8,%esp
  800245:	8d 85 3b ff ff ff    	lea    -0xc5(%ebp),%eax
  80024b:	50                   	push   %eax
  80024c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80024f:	e8 3e 11 00 00       	call   801392 <sget>
  800254:	83 c4 10             	add    $0x10,%esp
  800257:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* queue_in = sget(parentenvID, _queue_in);
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	8d 85 32 ff ff ff    	lea    -0xce(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	ff 75 e4             	pushl  -0x1c(%ebp)
  800267:	e8 26 11 00 00       	call   801392 <sget>
  80026c:	83 c4 10             	add    $0x10,%esp
  80026f:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	// *********************************************************************************

	int custId, flightType;
	sys_waitSemaphore(parentenvID, _custCounterCS);
  800272:	83 ec 08             	sub    $0x8,%esp
  800275:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80027b:	50                   	push   %eax
  80027c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80027f:	e8 67 16 00 00       	call   8018eb <sys_waitSemaphore>
  800284:	83 c4 10             	add    $0x10,%esp
	{
		custId = *custCounter;
  800287:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80028a:	8b 00                	mov    (%eax),%eax
  80028c:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//cprintf("custCounter= %d\n", *custCounter);
		*custCounter = *custCounter +1;
  80028f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	8d 50 01             	lea    0x1(%eax),%edx
  800297:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80029a:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custCounterCS);
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8002a5:	50                   	push   %eax
  8002a6:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002a9:	e8 5b 16 00 00       	call   801909 <sys_signalSemaphore>
  8002ae:	83 c4 10             	add    $0x10,%esp

	//wait on one of the clerks
	sys_waitSemaphore(parentenvID, _clerk);
  8002b1:	83 ec 08             	sub    $0x8,%esp
  8002b4:	8d 85 f7 fe ff ff    	lea    -0x109(%ebp),%eax
  8002ba:	50                   	push   %eax
  8002bb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002be:	e8 28 16 00 00       	call   8018eb <sys_waitSemaphore>
  8002c3:	83 c4 10             	add    $0x10,%esp

	//enqueue the request
	flightType = customers[custId].flightType;
  8002c6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8002c9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d3:	01 d0                	add    %edx,%eax
  8002d5:	8b 00                	mov    (%eax),%eax
  8002d7:	89 45 cc             	mov    %eax,-0x34(%ebp)
	sys_waitSemaphore(parentenvID, _custQueueCS);
  8002da:	83 ec 08             	sub    $0x8,%esp
  8002dd:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  8002e3:	50                   	push   %eax
  8002e4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002e7:	e8 ff 15 00 00       	call   8018eb <sys_waitSemaphore>
  8002ec:	83 c4 10             	add    $0x10,%esp
	{
		cust_ready_queue[*queue_in] = custId;
  8002ef:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002f2:	8b 00                	mov    (%eax),%eax
  8002f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002fe:	01 c2                	add    %eax,%edx
  800300:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800303:	89 02                	mov    %eax,(%edx)
		*queue_in = *queue_in +1;
  800305:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	8d 50 01             	lea    0x1(%eax),%edx
  80030d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800310:	89 10                	mov    %edx,(%eax)
	}
	sys_signalSemaphore(parentenvID, _custQueueCS);
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	8d 85 11 ff ff ff    	lea    -0xef(%ebp),%eax
  80031b:	50                   	push   %eax
  80031c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80031f:	e8 e5 15 00 00       	call   801909 <sys_signalSemaphore>
  800324:	83 c4 10             	add    $0x10,%esp

	//signal ready
	sys_signalSemaphore(parentenvID, _cust_ready);
  800327:	83 ec 08             	sub    $0x8,%esp
  80032a:	8d 85 1d ff ff ff    	lea    -0xe3(%ebp),%eax
  800330:	50                   	push   %eax
  800331:	ff 75 e4             	pushl  -0x1c(%ebp)
  800334:	e8 d0 15 00 00       	call   801909 <sys_signalSemaphore>
  800339:	83 c4 10             	add    $0x10,%esp

	//wait on finished
	char prefix[30]="cust_finished";
  80033c:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800342:	bb a3 21 80 00       	mov    $0x8021a3,%ebx
  800347:	ba 0e 00 00 00       	mov    $0xe,%edx
  80034c:	89 c7                	mov    %eax,%edi
  80034e:	89 de                	mov    %ebx,%esi
  800350:	89 d1                	mov    %edx,%ecx
  800352:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800354:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  80035a:	b9 04 00 00 00       	mov    $0x4,%ecx
  80035f:	b8 00 00 00 00       	mov    $0x0,%eax
  800364:	89 d7                	mov    %edx,%edi
  800366:	f3 ab                	rep stos %eax,%es:(%edi)
	char id[5]; char sname[50];
	ltostr(custId, id);
  800368:	83 ec 08             	sub    $0x8,%esp
  80036b:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  800371:	50                   	push   %eax
  800372:	ff 75 d0             	pushl  -0x30(%ebp)
  800375:	e8 96 0d 00 00       	call   801110 <ltostr>
  80037a:	83 c4 10             	add    $0x10,%esp
	strcconcat(prefix, id, sname);
  80037d:	83 ec 04             	sub    $0x4,%esp
  800380:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  800386:	50                   	push   %eax
  800387:	8d 85 a9 fe ff ff    	lea    -0x157(%ebp),%eax
  80038d:	50                   	push   %eax
  80038e:	8d 85 ae fe ff ff    	lea    -0x152(%ebp),%eax
  800394:	50                   	push   %eax
  800395:	e8 6e 0e 00 00       	call   801208 <strcconcat>
  80039a:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(parentenvID, sname);
  80039d:	83 ec 08             	sub    $0x8,%esp
  8003a0:	8d 85 77 fe ff ff    	lea    -0x189(%ebp),%eax
  8003a6:	50                   	push   %eax
  8003a7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8003aa:	e8 3c 15 00 00       	call   8018eb <sys_waitSemaphore>
  8003af:	83 c4 10             	add    $0x10,%esp

	//print the customer status
	if(customers[custId].booked == 1)
  8003b2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003b5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8003bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003bf:	01 d0                	add    %edx,%eax
  8003c1:	8b 40 04             	mov    0x4(%eax),%eax
  8003c4:	83 f8 01             	cmp    $0x1,%eax
  8003c7:	75 18                	jne    8003e1 <_main+0x3a9>
	{
		cprintf("cust %d: finished (BOOKED flight %d) \n", custId, flightType);
  8003c9:	83 ec 04             	sub    $0x4,%esp
  8003cc:	ff 75 cc             	pushl  -0x34(%ebp)
  8003cf:	ff 75 d0             	pushl  -0x30(%ebp)
  8003d2:	68 60 20 80 00       	push   $0x802060
  8003d7:	e8 0c 02 00 00       	call   8005e8 <cprintf>
  8003dc:	83 c4 10             	add    $0x10,%esp
  8003df:	eb 13                	jmp    8003f4 <_main+0x3bc>
	}
	else
	{
		cprintf("cust %d: finished (NOT BOOKED) \n", custId);
  8003e1:	83 ec 08             	sub    $0x8,%esp
  8003e4:	ff 75 d0             	pushl  -0x30(%ebp)
  8003e7:	68 88 20 80 00       	push   $0x802088
  8003ec:	e8 f7 01 00 00       	call   8005e8 <cprintf>
  8003f1:	83 c4 10             	add    $0x10,%esp
	}

	//customer is terminated
	sys_signalSemaphore(parentenvID, _custTerminated);
  8003f4:	83 ec 08             	sub    $0x8,%esp
  8003f7:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  8003fd:	50                   	push   %eax
  8003fe:	ff 75 e4             	pushl  -0x1c(%ebp)
  800401:	e8 03 15 00 00       	call   801909 <sys_signalSemaphore>
  800406:	83 c4 10             	add    $0x10,%esp

	return;
  800409:	90                   	nop
}
  80040a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80040d:	5b                   	pop    %ebx
  80040e:	5e                   	pop    %esi
  80040f:	5f                   	pop    %edi
  800410:	5d                   	pop    %ebp
  800411:	c3                   	ret    

00800412 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800418:	e8 86 12 00 00       	call   8016a3 <sys_getenvindex>
  80041d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800420:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800423:	89 d0                	mov    %edx,%eax
  800425:	01 c0                	add    %eax,%eax
  800427:	01 d0                	add    %edx,%eax
  800429:	c1 e0 02             	shl    $0x2,%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	c1 e0 06             	shl    $0x6,%eax
  800431:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800436:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80043b:	a1 20 30 80 00       	mov    0x803020,%eax
  800440:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800446:	84 c0                	test   %al,%al
  800448:	74 0f                	je     800459 <libmain+0x47>
		binaryname = myEnv->prog_name;
  80044a:	a1 20 30 80 00       	mov    0x803020,%eax
  80044f:	05 f4 02 00 00       	add    $0x2f4,%eax
  800454:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800459:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80045d:	7e 0a                	jle    800469 <libmain+0x57>
		binaryname = argv[0];
  80045f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800469:	83 ec 08             	sub    $0x8,%esp
  80046c:	ff 75 0c             	pushl  0xc(%ebp)
  80046f:	ff 75 08             	pushl  0x8(%ebp)
  800472:	e8 c1 fb ff ff       	call   800038 <_main>
  800477:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80047a:	e8 bf 13 00 00       	call   80183e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80047f:	83 ec 0c             	sub    $0xc,%esp
  800482:	68 dc 21 80 00       	push   $0x8021dc
  800487:	e8 5c 01 00 00       	call   8005e8 <cprintf>
  80048c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80048f:	a1 20 30 80 00       	mov    0x803020,%eax
  800494:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  80049a:	a1 20 30 80 00       	mov    0x803020,%eax
  80049f:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	52                   	push   %edx
  8004a9:	50                   	push   %eax
  8004aa:	68 04 22 80 00       	push   $0x802204
  8004af:	e8 34 01 00 00       	call   8005e8 <cprintf>
  8004b4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bc:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	50                   	push   %eax
  8004c6:	68 29 22 80 00       	push   $0x802229
  8004cb:	e8 18 01 00 00       	call   8005e8 <cprintf>
  8004d0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004d3:	83 ec 0c             	sub    $0xc,%esp
  8004d6:	68 dc 21 80 00       	push   $0x8021dc
  8004db:	e8 08 01 00 00       	call   8005e8 <cprintf>
  8004e0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004e3:	e8 70 13 00 00       	call   801858 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004e8:	e8 19 00 00 00       	call   800506 <exit>
}
  8004ed:	90                   	nop
  8004ee:	c9                   	leave  
  8004ef:	c3                   	ret    

008004f0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004f0:	55                   	push   %ebp
  8004f1:	89 e5                	mov    %esp,%ebp
  8004f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004f6:	83 ec 0c             	sub    $0xc,%esp
  8004f9:	6a 00                	push   $0x0
  8004fb:	e8 6f 11 00 00       	call   80166f <sys_env_destroy>
  800500:	83 c4 10             	add    $0x10,%esp
}
  800503:	90                   	nop
  800504:	c9                   	leave  
  800505:	c3                   	ret    

00800506 <exit>:

void
exit(void)
{
  800506:	55                   	push   %ebp
  800507:	89 e5                	mov    %esp,%ebp
  800509:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80050c:	e8 c4 11 00 00       	call   8016d5 <sys_env_exit>
}
  800511:	90                   	nop
  800512:	c9                   	leave  
  800513:	c3                   	ret    

00800514 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800514:	55                   	push   %ebp
  800515:	89 e5                	mov    %esp,%ebp
  800517:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80051a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051d:	8b 00                	mov    (%eax),%eax
  80051f:	8d 48 01             	lea    0x1(%eax),%ecx
  800522:	8b 55 0c             	mov    0xc(%ebp),%edx
  800525:	89 0a                	mov    %ecx,(%edx)
  800527:	8b 55 08             	mov    0x8(%ebp),%edx
  80052a:	88 d1                	mov    %dl,%cl
  80052c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80052f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800533:	8b 45 0c             	mov    0xc(%ebp),%eax
  800536:	8b 00                	mov    (%eax),%eax
  800538:	3d ff 00 00 00       	cmp    $0xff,%eax
  80053d:	75 2c                	jne    80056b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80053f:	a0 24 30 80 00       	mov    0x803024,%al
  800544:	0f b6 c0             	movzbl %al,%eax
  800547:	8b 55 0c             	mov    0xc(%ebp),%edx
  80054a:	8b 12                	mov    (%edx),%edx
  80054c:	89 d1                	mov    %edx,%ecx
  80054e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800551:	83 c2 08             	add    $0x8,%edx
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	50                   	push   %eax
  800558:	51                   	push   %ecx
  800559:	52                   	push   %edx
  80055a:	e8 ce 10 00 00       	call   80162d <sys_cputs>
  80055f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800562:	8b 45 0c             	mov    0xc(%ebp),%eax
  800565:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80056b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80056e:	8b 40 04             	mov    0x4(%eax),%eax
  800571:	8d 50 01             	lea    0x1(%eax),%edx
  800574:	8b 45 0c             	mov    0xc(%ebp),%eax
  800577:	89 50 04             	mov    %edx,0x4(%eax)
}
  80057a:	90                   	nop
  80057b:	c9                   	leave  
  80057c:	c3                   	ret    

0080057d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80057d:	55                   	push   %ebp
  80057e:	89 e5                	mov    %esp,%ebp
  800580:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800586:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80058d:	00 00 00 
	b.cnt = 0;
  800590:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800597:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80059a:	ff 75 0c             	pushl  0xc(%ebp)
  80059d:	ff 75 08             	pushl  0x8(%ebp)
  8005a0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005a6:	50                   	push   %eax
  8005a7:	68 14 05 80 00       	push   $0x800514
  8005ac:	e8 11 02 00 00       	call   8007c2 <vprintfmt>
  8005b1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005b4:	a0 24 30 80 00       	mov    0x803024,%al
  8005b9:	0f b6 c0             	movzbl %al,%eax
  8005bc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005c2:	83 ec 04             	sub    $0x4,%esp
  8005c5:	50                   	push   %eax
  8005c6:	52                   	push   %edx
  8005c7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005cd:	83 c0 08             	add    $0x8,%eax
  8005d0:	50                   	push   %eax
  8005d1:	e8 57 10 00 00       	call   80162d <sys_cputs>
  8005d6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005d9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005e0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005e6:	c9                   	leave  
  8005e7:	c3                   	ret    

008005e8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005e8:	55                   	push   %ebp
  8005e9:	89 e5                	mov    %esp,%ebp
  8005eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005ee:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fe:	83 ec 08             	sub    $0x8,%esp
  800601:	ff 75 f4             	pushl  -0xc(%ebp)
  800604:	50                   	push   %eax
  800605:	e8 73 ff ff ff       	call   80057d <vcprintf>
  80060a:	83 c4 10             	add    $0x10,%esp
  80060d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800610:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800613:	c9                   	leave  
  800614:	c3                   	ret    

00800615 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800615:	55                   	push   %ebp
  800616:	89 e5                	mov    %esp,%ebp
  800618:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80061b:	e8 1e 12 00 00       	call   80183e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800620:	8d 45 0c             	lea    0xc(%ebp),%eax
  800623:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800626:	8b 45 08             	mov    0x8(%ebp),%eax
  800629:	83 ec 08             	sub    $0x8,%esp
  80062c:	ff 75 f4             	pushl  -0xc(%ebp)
  80062f:	50                   	push   %eax
  800630:	e8 48 ff ff ff       	call   80057d <vcprintf>
  800635:	83 c4 10             	add    $0x10,%esp
  800638:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80063b:	e8 18 12 00 00       	call   801858 <sys_enable_interrupt>
	return cnt;
  800640:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800643:	c9                   	leave  
  800644:	c3                   	ret    

00800645 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800645:	55                   	push   %ebp
  800646:	89 e5                	mov    %esp,%ebp
  800648:	53                   	push   %ebx
  800649:	83 ec 14             	sub    $0x14,%esp
  80064c:	8b 45 10             	mov    0x10(%ebp),%eax
  80064f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800652:	8b 45 14             	mov    0x14(%ebp),%eax
  800655:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800658:	8b 45 18             	mov    0x18(%ebp),%eax
  80065b:	ba 00 00 00 00       	mov    $0x0,%edx
  800660:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800663:	77 55                	ja     8006ba <printnum+0x75>
  800665:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800668:	72 05                	jb     80066f <printnum+0x2a>
  80066a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80066d:	77 4b                	ja     8006ba <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80066f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800672:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800675:	8b 45 18             	mov    0x18(%ebp),%eax
  800678:	ba 00 00 00 00       	mov    $0x0,%edx
  80067d:	52                   	push   %edx
  80067e:	50                   	push   %eax
  80067f:	ff 75 f4             	pushl  -0xc(%ebp)
  800682:	ff 75 f0             	pushl  -0x10(%ebp)
  800685:	e8 72 17 00 00       	call   801dfc <__udivdi3>
  80068a:	83 c4 10             	add    $0x10,%esp
  80068d:	83 ec 04             	sub    $0x4,%esp
  800690:	ff 75 20             	pushl  0x20(%ebp)
  800693:	53                   	push   %ebx
  800694:	ff 75 18             	pushl  0x18(%ebp)
  800697:	52                   	push   %edx
  800698:	50                   	push   %eax
  800699:	ff 75 0c             	pushl  0xc(%ebp)
  80069c:	ff 75 08             	pushl  0x8(%ebp)
  80069f:	e8 a1 ff ff ff       	call   800645 <printnum>
  8006a4:	83 c4 20             	add    $0x20,%esp
  8006a7:	eb 1a                	jmp    8006c3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 0c             	pushl  0xc(%ebp)
  8006af:	ff 75 20             	pushl  0x20(%ebp)
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	ff d0                	call   *%eax
  8006b7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006ba:	ff 4d 1c             	decl   0x1c(%ebp)
  8006bd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006c1:	7f e6                	jg     8006a9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006c3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006c6:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d1:	53                   	push   %ebx
  8006d2:	51                   	push   %ecx
  8006d3:	52                   	push   %edx
  8006d4:	50                   	push   %eax
  8006d5:	e8 32 18 00 00       	call   801f0c <__umoddi3>
  8006da:	83 c4 10             	add    $0x10,%esp
  8006dd:	05 54 24 80 00       	add    $0x802454,%eax
  8006e2:	8a 00                	mov    (%eax),%al
  8006e4:	0f be c0             	movsbl %al,%eax
  8006e7:	83 ec 08             	sub    $0x8,%esp
  8006ea:	ff 75 0c             	pushl  0xc(%ebp)
  8006ed:	50                   	push   %eax
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	ff d0                	call   *%eax
  8006f3:	83 c4 10             	add    $0x10,%esp
}
  8006f6:	90                   	nop
  8006f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006fa:	c9                   	leave  
  8006fb:	c3                   	ret    

008006fc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006fc:	55                   	push   %ebp
  8006fd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ff:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800703:	7e 1c                	jle    800721 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800705:	8b 45 08             	mov    0x8(%ebp),%eax
  800708:	8b 00                	mov    (%eax),%eax
  80070a:	8d 50 08             	lea    0x8(%eax),%edx
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	89 10                	mov    %edx,(%eax)
  800712:	8b 45 08             	mov    0x8(%ebp),%eax
  800715:	8b 00                	mov    (%eax),%eax
  800717:	83 e8 08             	sub    $0x8,%eax
  80071a:	8b 50 04             	mov    0x4(%eax),%edx
  80071d:	8b 00                	mov    (%eax),%eax
  80071f:	eb 40                	jmp    800761 <getuint+0x65>
	else if (lflag)
  800721:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800725:	74 1e                	je     800745 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800727:	8b 45 08             	mov    0x8(%ebp),%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	8d 50 04             	lea    0x4(%eax),%edx
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	89 10                	mov    %edx,(%eax)
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	8b 00                	mov    (%eax),%eax
  800739:	83 e8 04             	sub    $0x4,%eax
  80073c:	8b 00                	mov    (%eax),%eax
  80073e:	ba 00 00 00 00       	mov    $0x0,%edx
  800743:	eb 1c                	jmp    800761 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	8d 50 04             	lea    0x4(%eax),%edx
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	89 10                	mov    %edx,(%eax)
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	8b 00                	mov    (%eax),%eax
  800757:	83 e8 04             	sub    $0x4,%eax
  80075a:	8b 00                	mov    (%eax),%eax
  80075c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800761:	5d                   	pop    %ebp
  800762:	c3                   	ret    

00800763 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800763:	55                   	push   %ebp
  800764:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800766:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80076a:	7e 1c                	jle    800788 <getint+0x25>
		return va_arg(*ap, long long);
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	8b 00                	mov    (%eax),%eax
  800771:	8d 50 08             	lea    0x8(%eax),%edx
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	89 10                	mov    %edx,(%eax)
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	8b 00                	mov    (%eax),%eax
  80077e:	83 e8 08             	sub    $0x8,%eax
  800781:	8b 50 04             	mov    0x4(%eax),%edx
  800784:	8b 00                	mov    (%eax),%eax
  800786:	eb 38                	jmp    8007c0 <getint+0x5d>
	else if (lflag)
  800788:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80078c:	74 1a                	je     8007a8 <getint+0x45>
		return va_arg(*ap, long);
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	8b 00                	mov    (%eax),%eax
  800793:	8d 50 04             	lea    0x4(%eax),%edx
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	89 10                	mov    %edx,(%eax)
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	8b 00                	mov    (%eax),%eax
  8007a0:	83 e8 04             	sub    $0x4,%eax
  8007a3:	8b 00                	mov    (%eax),%eax
  8007a5:	99                   	cltd   
  8007a6:	eb 18                	jmp    8007c0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ab:	8b 00                	mov    (%eax),%eax
  8007ad:	8d 50 04             	lea    0x4(%eax),%edx
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	89 10                	mov    %edx,(%eax)
  8007b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b8:	8b 00                	mov    (%eax),%eax
  8007ba:	83 e8 04             	sub    $0x4,%eax
  8007bd:	8b 00                	mov    (%eax),%eax
  8007bf:	99                   	cltd   
}
  8007c0:	5d                   	pop    %ebp
  8007c1:	c3                   	ret    

008007c2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007c2:	55                   	push   %ebp
  8007c3:	89 e5                	mov    %esp,%ebp
  8007c5:	56                   	push   %esi
  8007c6:	53                   	push   %ebx
  8007c7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007ca:	eb 17                	jmp    8007e3 <vprintfmt+0x21>
			if (ch == '\0')
  8007cc:	85 db                	test   %ebx,%ebx
  8007ce:	0f 84 af 03 00 00    	je     800b83 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	53                   	push   %ebx
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e6:	8d 50 01             	lea    0x1(%eax),%edx
  8007e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8007ec:	8a 00                	mov    (%eax),%al
  8007ee:	0f b6 d8             	movzbl %al,%ebx
  8007f1:	83 fb 25             	cmp    $0x25,%ebx
  8007f4:	75 d6                	jne    8007cc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007f6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007fa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800801:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800808:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80080f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800816:	8b 45 10             	mov    0x10(%ebp),%eax
  800819:	8d 50 01             	lea    0x1(%eax),%edx
  80081c:	89 55 10             	mov    %edx,0x10(%ebp)
  80081f:	8a 00                	mov    (%eax),%al
  800821:	0f b6 d8             	movzbl %al,%ebx
  800824:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800827:	83 f8 55             	cmp    $0x55,%eax
  80082a:	0f 87 2b 03 00 00    	ja     800b5b <vprintfmt+0x399>
  800830:	8b 04 85 78 24 80 00 	mov    0x802478(,%eax,4),%eax
  800837:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800839:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80083d:	eb d7                	jmp    800816 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80083f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800843:	eb d1                	jmp    800816 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800845:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80084c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80084f:	89 d0                	mov    %edx,%eax
  800851:	c1 e0 02             	shl    $0x2,%eax
  800854:	01 d0                	add    %edx,%eax
  800856:	01 c0                	add    %eax,%eax
  800858:	01 d8                	add    %ebx,%eax
  80085a:	83 e8 30             	sub    $0x30,%eax
  80085d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800860:	8b 45 10             	mov    0x10(%ebp),%eax
  800863:	8a 00                	mov    (%eax),%al
  800865:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800868:	83 fb 2f             	cmp    $0x2f,%ebx
  80086b:	7e 3e                	jle    8008ab <vprintfmt+0xe9>
  80086d:	83 fb 39             	cmp    $0x39,%ebx
  800870:	7f 39                	jg     8008ab <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800872:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800875:	eb d5                	jmp    80084c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800877:	8b 45 14             	mov    0x14(%ebp),%eax
  80087a:	83 c0 04             	add    $0x4,%eax
  80087d:	89 45 14             	mov    %eax,0x14(%ebp)
  800880:	8b 45 14             	mov    0x14(%ebp),%eax
  800883:	83 e8 04             	sub    $0x4,%eax
  800886:	8b 00                	mov    (%eax),%eax
  800888:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80088b:	eb 1f                	jmp    8008ac <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80088d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800891:	79 83                	jns    800816 <vprintfmt+0x54>
				width = 0;
  800893:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80089a:	e9 77 ff ff ff       	jmp    800816 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80089f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008a6:	e9 6b ff ff ff       	jmp    800816 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008ab:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008b0:	0f 89 60 ff ff ff    	jns    800816 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008bc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008c3:	e9 4e ff ff ff       	jmp    800816 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008c8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008cb:	e9 46 ff ff ff       	jmp    800816 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d3:	83 c0 04             	add    $0x4,%eax
  8008d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8008d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8008dc:	83 e8 04             	sub    $0x4,%eax
  8008df:	8b 00                	mov    (%eax),%eax
  8008e1:	83 ec 08             	sub    $0x8,%esp
  8008e4:	ff 75 0c             	pushl  0xc(%ebp)
  8008e7:	50                   	push   %eax
  8008e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008eb:	ff d0                	call   *%eax
  8008ed:	83 c4 10             	add    $0x10,%esp
			break;
  8008f0:	e9 89 02 00 00       	jmp    800b7e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f8:	83 c0 04             	add    $0x4,%eax
  8008fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800901:	83 e8 04             	sub    $0x4,%eax
  800904:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800906:	85 db                	test   %ebx,%ebx
  800908:	79 02                	jns    80090c <vprintfmt+0x14a>
				err = -err;
  80090a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80090c:	83 fb 64             	cmp    $0x64,%ebx
  80090f:	7f 0b                	jg     80091c <vprintfmt+0x15a>
  800911:	8b 34 9d c0 22 80 00 	mov    0x8022c0(,%ebx,4),%esi
  800918:	85 f6                	test   %esi,%esi
  80091a:	75 19                	jne    800935 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80091c:	53                   	push   %ebx
  80091d:	68 65 24 80 00       	push   $0x802465
  800922:	ff 75 0c             	pushl  0xc(%ebp)
  800925:	ff 75 08             	pushl  0x8(%ebp)
  800928:	e8 5e 02 00 00       	call   800b8b <printfmt>
  80092d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800930:	e9 49 02 00 00       	jmp    800b7e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800935:	56                   	push   %esi
  800936:	68 6e 24 80 00       	push   $0x80246e
  80093b:	ff 75 0c             	pushl  0xc(%ebp)
  80093e:	ff 75 08             	pushl  0x8(%ebp)
  800941:	e8 45 02 00 00       	call   800b8b <printfmt>
  800946:	83 c4 10             	add    $0x10,%esp
			break;
  800949:	e9 30 02 00 00       	jmp    800b7e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80094e:	8b 45 14             	mov    0x14(%ebp),%eax
  800951:	83 c0 04             	add    $0x4,%eax
  800954:	89 45 14             	mov    %eax,0x14(%ebp)
  800957:	8b 45 14             	mov    0x14(%ebp),%eax
  80095a:	83 e8 04             	sub    $0x4,%eax
  80095d:	8b 30                	mov    (%eax),%esi
  80095f:	85 f6                	test   %esi,%esi
  800961:	75 05                	jne    800968 <vprintfmt+0x1a6>
				p = "(null)";
  800963:	be 71 24 80 00       	mov    $0x802471,%esi
			if (width > 0 && padc != '-')
  800968:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80096c:	7e 6d                	jle    8009db <vprintfmt+0x219>
  80096e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800972:	74 67                	je     8009db <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800974:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800977:	83 ec 08             	sub    $0x8,%esp
  80097a:	50                   	push   %eax
  80097b:	56                   	push   %esi
  80097c:	e8 0c 03 00 00       	call   800c8d <strnlen>
  800981:	83 c4 10             	add    $0x10,%esp
  800984:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800987:	eb 16                	jmp    80099f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800989:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80098d:	83 ec 08             	sub    $0x8,%esp
  800990:	ff 75 0c             	pushl  0xc(%ebp)
  800993:	50                   	push   %eax
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	ff d0                	call   *%eax
  800999:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80099c:	ff 4d e4             	decl   -0x1c(%ebp)
  80099f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009a3:	7f e4                	jg     800989 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009a5:	eb 34                	jmp    8009db <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009a7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009ab:	74 1c                	je     8009c9 <vprintfmt+0x207>
  8009ad:	83 fb 1f             	cmp    $0x1f,%ebx
  8009b0:	7e 05                	jle    8009b7 <vprintfmt+0x1f5>
  8009b2:	83 fb 7e             	cmp    $0x7e,%ebx
  8009b5:	7e 12                	jle    8009c9 <vprintfmt+0x207>
					putch('?', putdat);
  8009b7:	83 ec 08             	sub    $0x8,%esp
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	6a 3f                	push   $0x3f
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	ff d0                	call   *%eax
  8009c4:	83 c4 10             	add    $0x10,%esp
  8009c7:	eb 0f                	jmp    8009d8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009c9:	83 ec 08             	sub    $0x8,%esp
  8009cc:	ff 75 0c             	pushl  0xc(%ebp)
  8009cf:	53                   	push   %ebx
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	ff d0                	call   *%eax
  8009d5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009d8:	ff 4d e4             	decl   -0x1c(%ebp)
  8009db:	89 f0                	mov    %esi,%eax
  8009dd:	8d 70 01             	lea    0x1(%eax),%esi
  8009e0:	8a 00                	mov    (%eax),%al
  8009e2:	0f be d8             	movsbl %al,%ebx
  8009e5:	85 db                	test   %ebx,%ebx
  8009e7:	74 24                	je     800a0d <vprintfmt+0x24b>
  8009e9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009ed:	78 b8                	js     8009a7 <vprintfmt+0x1e5>
  8009ef:	ff 4d e0             	decl   -0x20(%ebp)
  8009f2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009f6:	79 af                	jns    8009a7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009f8:	eb 13                	jmp    800a0d <vprintfmt+0x24b>
				putch(' ', putdat);
  8009fa:	83 ec 08             	sub    $0x8,%esp
  8009fd:	ff 75 0c             	pushl  0xc(%ebp)
  800a00:	6a 20                	push   $0x20
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a0a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a11:	7f e7                	jg     8009fa <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a13:	e9 66 01 00 00       	jmp    800b7e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 e8             	pushl  -0x18(%ebp)
  800a1e:	8d 45 14             	lea    0x14(%ebp),%eax
  800a21:	50                   	push   %eax
  800a22:	e8 3c fd ff ff       	call   800763 <getint>
  800a27:	83 c4 10             	add    $0x10,%esp
  800a2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a30:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a36:	85 d2                	test   %edx,%edx
  800a38:	79 23                	jns    800a5d <vprintfmt+0x29b>
				putch('-', putdat);
  800a3a:	83 ec 08             	sub    $0x8,%esp
  800a3d:	ff 75 0c             	pushl  0xc(%ebp)
  800a40:	6a 2d                	push   $0x2d
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	ff d0                	call   *%eax
  800a47:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a50:	f7 d8                	neg    %eax
  800a52:	83 d2 00             	adc    $0x0,%edx
  800a55:	f7 da                	neg    %edx
  800a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a5a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a5d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a64:	e9 bc 00 00 00       	jmp    800b25 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a69:	83 ec 08             	sub    $0x8,%esp
  800a6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a72:	50                   	push   %eax
  800a73:	e8 84 fc ff ff       	call   8006fc <getuint>
  800a78:	83 c4 10             	add    $0x10,%esp
  800a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a81:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a88:	e9 98 00 00 00       	jmp    800b25 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	6a 58                	push   $0x58
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	ff d0                	call   *%eax
  800a9a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a9d:	83 ec 08             	sub    $0x8,%esp
  800aa0:	ff 75 0c             	pushl  0xc(%ebp)
  800aa3:	6a 58                	push   $0x58
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	ff d0                	call   *%eax
  800aaa:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aad:	83 ec 08             	sub    $0x8,%esp
  800ab0:	ff 75 0c             	pushl  0xc(%ebp)
  800ab3:	6a 58                	push   $0x58
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	ff d0                	call   *%eax
  800aba:	83 c4 10             	add    $0x10,%esp
			break;
  800abd:	e9 bc 00 00 00       	jmp    800b7e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	6a 30                	push   $0x30
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	ff d0                	call   *%eax
  800acf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ad2:	83 ec 08             	sub    $0x8,%esp
  800ad5:	ff 75 0c             	pushl  0xc(%ebp)
  800ad8:	6a 78                	push   $0x78
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	ff d0                	call   *%eax
  800adf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ae2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae5:	83 c0 04             	add    $0x4,%eax
  800ae8:	89 45 14             	mov    %eax,0x14(%ebp)
  800aeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800aee:	83 e8 04             	sub    $0x4,%eax
  800af1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800af3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800afd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b04:	eb 1f                	jmp    800b25 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b06:	83 ec 08             	sub    $0x8,%esp
  800b09:	ff 75 e8             	pushl  -0x18(%ebp)
  800b0c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b0f:	50                   	push   %eax
  800b10:	e8 e7 fb ff ff       	call   8006fc <getuint>
  800b15:	83 c4 10             	add    $0x10,%esp
  800b18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b1e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b25:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b29:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b2c:	83 ec 04             	sub    $0x4,%esp
  800b2f:	52                   	push   %edx
  800b30:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b33:	50                   	push   %eax
  800b34:	ff 75 f4             	pushl  -0xc(%ebp)
  800b37:	ff 75 f0             	pushl  -0x10(%ebp)
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	ff 75 08             	pushl  0x8(%ebp)
  800b40:	e8 00 fb ff ff       	call   800645 <printnum>
  800b45:	83 c4 20             	add    $0x20,%esp
			break;
  800b48:	eb 34                	jmp    800b7e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b4a:	83 ec 08             	sub    $0x8,%esp
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	53                   	push   %ebx
  800b51:	8b 45 08             	mov    0x8(%ebp),%eax
  800b54:	ff d0                	call   *%eax
  800b56:	83 c4 10             	add    $0x10,%esp
			break;
  800b59:	eb 23                	jmp    800b7e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b5b:	83 ec 08             	sub    $0x8,%esp
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	6a 25                	push   $0x25
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	ff d0                	call   *%eax
  800b68:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b6b:	ff 4d 10             	decl   0x10(%ebp)
  800b6e:	eb 03                	jmp    800b73 <vprintfmt+0x3b1>
  800b70:	ff 4d 10             	decl   0x10(%ebp)
  800b73:	8b 45 10             	mov    0x10(%ebp),%eax
  800b76:	48                   	dec    %eax
  800b77:	8a 00                	mov    (%eax),%al
  800b79:	3c 25                	cmp    $0x25,%al
  800b7b:	75 f3                	jne    800b70 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b7d:	90                   	nop
		}
	}
  800b7e:	e9 47 fc ff ff       	jmp    8007ca <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b83:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b84:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b87:	5b                   	pop    %ebx
  800b88:	5e                   	pop    %esi
  800b89:	5d                   	pop    %ebp
  800b8a:	c3                   	ret    

00800b8b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b8b:	55                   	push   %ebp
  800b8c:	89 e5                	mov    %esp,%ebp
  800b8e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b91:	8d 45 10             	lea    0x10(%ebp),%eax
  800b94:	83 c0 04             	add    $0x4,%eax
  800b97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9d:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba0:	50                   	push   %eax
  800ba1:	ff 75 0c             	pushl  0xc(%ebp)
  800ba4:	ff 75 08             	pushl  0x8(%ebp)
  800ba7:	e8 16 fc ff ff       	call   8007c2 <vprintfmt>
  800bac:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800baf:	90                   	nop
  800bb0:	c9                   	leave  
  800bb1:	c3                   	ret    

00800bb2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bb2:	55                   	push   %ebp
  800bb3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb8:	8b 40 08             	mov    0x8(%eax),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc7:	8b 10                	mov    (%eax),%edx
  800bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcc:	8b 40 04             	mov    0x4(%eax),%eax
  800bcf:	39 c2                	cmp    %eax,%edx
  800bd1:	73 12                	jae    800be5 <sprintputch+0x33>
		*b->buf++ = ch;
  800bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd6:	8b 00                	mov    (%eax),%eax
  800bd8:	8d 48 01             	lea    0x1(%eax),%ecx
  800bdb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bde:	89 0a                	mov    %ecx,(%edx)
  800be0:	8b 55 08             	mov    0x8(%ebp),%edx
  800be3:	88 10                	mov    %dl,(%eax)
}
  800be5:	90                   	nop
  800be6:	5d                   	pop    %ebp
  800be7:	c3                   	ret    

00800be8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800be8:	55                   	push   %ebp
  800be9:	89 e5                	mov    %esp,%ebp
  800beb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	01 d0                	add    %edx,%eax
  800bff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c09:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c0d:	74 06                	je     800c15 <vsnprintf+0x2d>
  800c0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c13:	7f 07                	jg     800c1c <vsnprintf+0x34>
		return -E_INVAL;
  800c15:	b8 03 00 00 00       	mov    $0x3,%eax
  800c1a:	eb 20                	jmp    800c3c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c1c:	ff 75 14             	pushl  0x14(%ebp)
  800c1f:	ff 75 10             	pushl  0x10(%ebp)
  800c22:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c25:	50                   	push   %eax
  800c26:	68 b2 0b 80 00       	push   $0x800bb2
  800c2b:	e8 92 fb ff ff       	call   8007c2 <vprintfmt>
  800c30:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c36:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c3c:	c9                   	leave  
  800c3d:	c3                   	ret    

00800c3e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c3e:	55                   	push   %ebp
  800c3f:	89 e5                	mov    %esp,%ebp
  800c41:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c44:	8d 45 10             	lea    0x10(%ebp),%eax
  800c47:	83 c0 04             	add    $0x4,%eax
  800c4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c50:	ff 75 f4             	pushl  -0xc(%ebp)
  800c53:	50                   	push   %eax
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	ff 75 08             	pushl  0x8(%ebp)
  800c5a:	e8 89 ff ff ff       	call   800be8 <vsnprintf>
  800c5f:	83 c4 10             	add    $0x10,%esp
  800c62:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c68:	c9                   	leave  
  800c69:	c3                   	ret    

00800c6a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c6a:	55                   	push   %ebp
  800c6b:	89 e5                	mov    %esp,%ebp
  800c6d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c77:	eb 06                	jmp    800c7f <strlen+0x15>
		n++;
  800c79:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c7c:	ff 45 08             	incl   0x8(%ebp)
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	84 c0                	test   %al,%al
  800c86:	75 f1                	jne    800c79 <strlen+0xf>
		n++;
	return n;
  800c88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c8b:	c9                   	leave  
  800c8c:	c3                   	ret    

00800c8d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
  800c90:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c93:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c9a:	eb 09                	jmp    800ca5 <strnlen+0x18>
		n++;
  800c9c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c9f:	ff 45 08             	incl   0x8(%ebp)
  800ca2:	ff 4d 0c             	decl   0xc(%ebp)
  800ca5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ca9:	74 09                	je     800cb4 <strnlen+0x27>
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8a 00                	mov    (%eax),%al
  800cb0:	84 c0                	test   %al,%al
  800cb2:	75 e8                	jne    800c9c <strnlen+0xf>
		n++;
	return n;
  800cb4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cb7:	c9                   	leave  
  800cb8:	c3                   	ret    

00800cb9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cb9:	55                   	push   %ebp
  800cba:	89 e5                	mov    %esp,%ebp
  800cbc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cc5:	90                   	nop
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8d 50 01             	lea    0x1(%eax),%edx
  800ccc:	89 55 08             	mov    %edx,0x8(%ebp)
  800ccf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cd2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cd5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cd8:	8a 12                	mov    (%edx),%dl
  800cda:	88 10                	mov    %dl,(%eax)
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	84 c0                	test   %al,%al
  800ce0:	75 e4                	jne    800cc6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ce2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ce5:	c9                   	leave  
  800ce6:	c3                   	ret    

00800ce7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ce7:	55                   	push   %ebp
  800ce8:	89 e5                	mov    %esp,%ebp
  800cea:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cf3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cfa:	eb 1f                	jmp    800d1b <strncpy+0x34>
		*dst++ = *src;
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8d 50 01             	lea    0x1(%eax),%edx
  800d02:	89 55 08             	mov    %edx,0x8(%ebp)
  800d05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d08:	8a 12                	mov    (%edx),%dl
  800d0a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0f:	8a 00                	mov    (%eax),%al
  800d11:	84 c0                	test   %al,%al
  800d13:	74 03                	je     800d18 <strncpy+0x31>
			src++;
  800d15:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d18:	ff 45 fc             	incl   -0x4(%ebp)
  800d1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d1e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d21:	72 d9                	jb     800cfc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d23:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d26:	c9                   	leave  
  800d27:	c3                   	ret    

00800d28 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d28:	55                   	push   %ebp
  800d29:	89 e5                	mov    %esp,%ebp
  800d2b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d38:	74 30                	je     800d6a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d3a:	eb 16                	jmp    800d52 <strlcpy+0x2a>
			*dst++ = *src++;
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8d 50 01             	lea    0x1(%eax),%edx
  800d42:	89 55 08             	mov    %edx,0x8(%ebp)
  800d45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d48:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d4b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d4e:	8a 12                	mov    (%edx),%dl
  800d50:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d52:	ff 4d 10             	decl   0x10(%ebp)
  800d55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d59:	74 09                	je     800d64 <strlcpy+0x3c>
  800d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	84 c0                	test   %al,%al
  800d62:	75 d8                	jne    800d3c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d6a:	8b 55 08             	mov    0x8(%ebp),%edx
  800d6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d70:	29 c2                	sub    %eax,%edx
  800d72:	89 d0                	mov    %edx,%eax
}
  800d74:	c9                   	leave  
  800d75:	c3                   	ret    

00800d76 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d76:	55                   	push   %ebp
  800d77:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d79:	eb 06                	jmp    800d81 <strcmp+0xb>
		p++, q++;
  800d7b:	ff 45 08             	incl   0x8(%ebp)
  800d7e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	84 c0                	test   %al,%al
  800d88:	74 0e                	je     800d98 <strcmp+0x22>
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8a 10                	mov    (%eax),%dl
  800d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	38 c2                	cmp    %al,%dl
  800d96:	74 e3                	je     800d7b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	8a 00                	mov    (%eax),%al
  800d9d:	0f b6 d0             	movzbl %al,%edx
  800da0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	0f b6 c0             	movzbl %al,%eax
  800da8:	29 c2                	sub    %eax,%edx
  800daa:	89 d0                	mov    %edx,%eax
}
  800dac:	5d                   	pop    %ebp
  800dad:	c3                   	ret    

00800dae <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dae:	55                   	push   %ebp
  800daf:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800db1:	eb 09                	jmp    800dbc <strncmp+0xe>
		n--, p++, q++;
  800db3:	ff 4d 10             	decl   0x10(%ebp)
  800db6:	ff 45 08             	incl   0x8(%ebp)
  800db9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dbc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dc0:	74 17                	je     800dd9 <strncmp+0x2b>
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	8a 00                	mov    (%eax),%al
  800dc7:	84 c0                	test   %al,%al
  800dc9:	74 0e                	je     800dd9 <strncmp+0x2b>
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	8a 10                	mov    (%eax),%dl
  800dd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd3:	8a 00                	mov    (%eax),%al
  800dd5:	38 c2                	cmp    %al,%dl
  800dd7:	74 da                	je     800db3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddd:	75 07                	jne    800de6 <strncmp+0x38>
		return 0;
  800ddf:	b8 00 00 00 00       	mov    $0x0,%eax
  800de4:	eb 14                	jmp    800dfa <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8a 00                	mov    (%eax),%al
  800deb:	0f b6 d0             	movzbl %al,%edx
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	0f b6 c0             	movzbl %al,%eax
  800df6:	29 c2                	sub    %eax,%edx
  800df8:	89 d0                	mov    %edx,%eax
}
  800dfa:	5d                   	pop    %ebp
  800dfb:	c3                   	ret    

00800dfc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800dfc:	55                   	push   %ebp
  800dfd:	89 e5                	mov    %esp,%ebp
  800dff:	83 ec 04             	sub    $0x4,%esp
  800e02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e05:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e08:	eb 12                	jmp    800e1c <strchr+0x20>
		if (*s == c)
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e12:	75 05                	jne    800e19 <strchr+0x1d>
			return (char *) s;
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	eb 11                	jmp    800e2a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e19:	ff 45 08             	incl   0x8(%ebp)
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	84 c0                	test   %al,%al
  800e23:	75 e5                	jne    800e0a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e2a:	c9                   	leave  
  800e2b:	c3                   	ret    

00800e2c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e2c:	55                   	push   %ebp
  800e2d:	89 e5                	mov    %esp,%ebp
  800e2f:	83 ec 04             	sub    $0x4,%esp
  800e32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e35:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e38:	eb 0d                	jmp    800e47 <strfind+0x1b>
		if (*s == c)
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e42:	74 0e                	je     800e52 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e44:	ff 45 08             	incl   0x8(%ebp)
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	84 c0                	test   %al,%al
  800e4e:	75 ea                	jne    800e3a <strfind+0xe>
  800e50:	eb 01                	jmp    800e53 <strfind+0x27>
		if (*s == c)
			break;
  800e52:	90                   	nop
	return (char *) s;
  800e53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e56:	c9                   	leave  
  800e57:	c3                   	ret    

00800e58 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e58:	55                   	push   %ebp
  800e59:	89 e5                	mov    %esp,%ebp
  800e5b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e61:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e64:	8b 45 10             	mov    0x10(%ebp),%eax
  800e67:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e6a:	eb 0e                	jmp    800e7a <memset+0x22>
		*p++ = c;
  800e6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6f:	8d 50 01             	lea    0x1(%eax),%edx
  800e72:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e75:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e78:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e7a:	ff 4d f8             	decl   -0x8(%ebp)
  800e7d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e81:	79 e9                	jns    800e6c <memset+0x14>
		*p++ = c;

	return v;
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e86:	c9                   	leave  
  800e87:	c3                   	ret    

00800e88 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e88:	55                   	push   %ebp
  800e89:	89 e5                	mov    %esp,%ebp
  800e8b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e9a:	eb 16                	jmp    800eb2 <memcpy+0x2a>
		*d++ = *s++;
  800e9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9f:	8d 50 01             	lea    0x1(%eax),%edx
  800ea2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ea8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eae:	8a 12                	mov    (%edx),%dl
  800eb0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebb:	85 c0                	test   %eax,%eax
  800ebd:	75 dd                	jne    800e9c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ebf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec2:	c9                   	leave  
  800ec3:	c3                   	ret    

00800ec4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ec4:	55                   	push   %ebp
  800ec5:	89 e5                	mov    %esp,%ebp
  800ec7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  800eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ed6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800edc:	73 50                	jae    800f2e <memmove+0x6a>
  800ede:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee4:	01 d0                	add    %edx,%eax
  800ee6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ee9:	76 43                	jbe    800f2e <memmove+0x6a>
		s += n;
  800eeb:	8b 45 10             	mov    0x10(%ebp),%eax
  800eee:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ef1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ef7:	eb 10                	jmp    800f09 <memmove+0x45>
			*--d = *--s;
  800ef9:	ff 4d f8             	decl   -0x8(%ebp)
  800efc:	ff 4d fc             	decl   -0x4(%ebp)
  800eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f02:	8a 10                	mov    (%eax),%dl
  800f04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f07:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f09:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f0f:	89 55 10             	mov    %edx,0x10(%ebp)
  800f12:	85 c0                	test   %eax,%eax
  800f14:	75 e3                	jne    800ef9 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f16:	eb 23                	jmp    800f3b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f1b:	8d 50 01             	lea    0x1(%eax),%edx
  800f1e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f21:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f24:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f27:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f2a:	8a 12                	mov    (%edx),%dl
  800f2c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f31:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f34:	89 55 10             	mov    %edx,0x10(%ebp)
  800f37:	85 c0                	test   %eax,%eax
  800f39:	75 dd                	jne    800f18 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f3e:	c9                   	leave  
  800f3f:	c3                   	ret    

00800f40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f40:	55                   	push   %ebp
  800f41:	89 e5                	mov    %esp,%ebp
  800f43:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f52:	eb 2a                	jmp    800f7e <memcmp+0x3e>
		if (*s1 != *s2)
  800f54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f57:	8a 10                	mov    (%eax),%dl
  800f59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	38 c2                	cmp    %al,%dl
  800f60:	74 16                	je     800f78 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	0f b6 d0             	movzbl %al,%edx
  800f6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	0f b6 c0             	movzbl %al,%eax
  800f72:	29 c2                	sub    %eax,%edx
  800f74:	89 d0                	mov    %edx,%eax
  800f76:	eb 18                	jmp    800f90 <memcmp+0x50>
		s1++, s2++;
  800f78:	ff 45 fc             	incl   -0x4(%ebp)
  800f7b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f84:	89 55 10             	mov    %edx,0x10(%ebp)
  800f87:	85 c0                	test   %eax,%eax
  800f89:	75 c9                	jne    800f54 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f90:	c9                   	leave  
  800f91:	c3                   	ret    

00800f92 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f92:	55                   	push   %ebp
  800f93:	89 e5                	mov    %esp,%ebp
  800f95:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f98:	8b 55 08             	mov    0x8(%ebp),%edx
  800f9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9e:	01 d0                	add    %edx,%eax
  800fa0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fa3:	eb 15                	jmp    800fba <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f b6 d0             	movzbl %al,%edx
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	0f b6 c0             	movzbl %al,%eax
  800fb3:	39 c2                	cmp    %eax,%edx
  800fb5:	74 0d                	je     800fc4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fb7:	ff 45 08             	incl   0x8(%ebp)
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fc0:	72 e3                	jb     800fa5 <memfind+0x13>
  800fc2:	eb 01                	jmp    800fc5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fc4:	90                   	nop
	return (void *) s;
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc8:	c9                   	leave  
  800fc9:	c3                   	ret    

00800fca <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fca:	55                   	push   %ebp
  800fcb:	89 e5                	mov    %esp,%ebp
  800fcd:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fd0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fd7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fde:	eb 03                	jmp    800fe3 <strtol+0x19>
		s++;
  800fe0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	3c 20                	cmp    $0x20,%al
  800fea:	74 f4                	je     800fe0 <strtol+0x16>
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3c 09                	cmp    $0x9,%al
  800ff3:	74 eb                	je     800fe0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 00                	mov    (%eax),%al
  800ffa:	3c 2b                	cmp    $0x2b,%al
  800ffc:	75 05                	jne    801003 <strtol+0x39>
		s++;
  800ffe:	ff 45 08             	incl   0x8(%ebp)
  801001:	eb 13                	jmp    801016 <strtol+0x4c>
	else if (*s == '-')
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	3c 2d                	cmp    $0x2d,%al
  80100a:	75 0a                	jne    801016 <strtol+0x4c>
		s++, neg = 1;
  80100c:	ff 45 08             	incl   0x8(%ebp)
  80100f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801016:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101a:	74 06                	je     801022 <strtol+0x58>
  80101c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801020:	75 20                	jne    801042 <strtol+0x78>
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	3c 30                	cmp    $0x30,%al
  801029:	75 17                	jne    801042 <strtol+0x78>
  80102b:	8b 45 08             	mov    0x8(%ebp),%eax
  80102e:	40                   	inc    %eax
  80102f:	8a 00                	mov    (%eax),%al
  801031:	3c 78                	cmp    $0x78,%al
  801033:	75 0d                	jne    801042 <strtol+0x78>
		s += 2, base = 16;
  801035:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801039:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801040:	eb 28                	jmp    80106a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801042:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801046:	75 15                	jne    80105d <strtol+0x93>
  801048:	8b 45 08             	mov    0x8(%ebp),%eax
  80104b:	8a 00                	mov    (%eax),%al
  80104d:	3c 30                	cmp    $0x30,%al
  80104f:	75 0c                	jne    80105d <strtol+0x93>
		s++, base = 8;
  801051:	ff 45 08             	incl   0x8(%ebp)
  801054:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80105b:	eb 0d                	jmp    80106a <strtol+0xa0>
	else if (base == 0)
  80105d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801061:	75 07                	jne    80106a <strtol+0xa0>
		base = 10;
  801063:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	8a 00                	mov    (%eax),%al
  80106f:	3c 2f                	cmp    $0x2f,%al
  801071:	7e 19                	jle    80108c <strtol+0xc2>
  801073:	8b 45 08             	mov    0x8(%ebp),%eax
  801076:	8a 00                	mov    (%eax),%al
  801078:	3c 39                	cmp    $0x39,%al
  80107a:	7f 10                	jg     80108c <strtol+0xc2>
			dig = *s - '0';
  80107c:	8b 45 08             	mov    0x8(%ebp),%eax
  80107f:	8a 00                	mov    (%eax),%al
  801081:	0f be c0             	movsbl %al,%eax
  801084:	83 e8 30             	sub    $0x30,%eax
  801087:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80108a:	eb 42                	jmp    8010ce <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	3c 60                	cmp    $0x60,%al
  801093:	7e 19                	jle    8010ae <strtol+0xe4>
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	8a 00                	mov    (%eax),%al
  80109a:	3c 7a                	cmp    $0x7a,%al
  80109c:	7f 10                	jg     8010ae <strtol+0xe4>
			dig = *s - 'a' + 10;
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	8a 00                	mov    (%eax),%al
  8010a3:	0f be c0             	movsbl %al,%eax
  8010a6:	83 e8 57             	sub    $0x57,%eax
  8010a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010ac:	eb 20                	jmp    8010ce <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	3c 40                	cmp    $0x40,%al
  8010b5:	7e 39                	jle    8010f0 <strtol+0x126>
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	3c 5a                	cmp    $0x5a,%al
  8010be:	7f 30                	jg     8010f0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c3:	8a 00                	mov    (%eax),%al
  8010c5:	0f be c0             	movsbl %al,%eax
  8010c8:	83 e8 37             	sub    $0x37,%eax
  8010cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010d4:	7d 19                	jge    8010ef <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010d6:	ff 45 08             	incl   0x8(%ebp)
  8010d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010dc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010e0:	89 c2                	mov    %eax,%edx
  8010e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e5:	01 d0                	add    %edx,%eax
  8010e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010ea:	e9 7b ff ff ff       	jmp    80106a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010ef:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010f4:	74 08                	je     8010fe <strtol+0x134>
		*endptr = (char *) s;
  8010f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8010fc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801102:	74 07                	je     80110b <strtol+0x141>
  801104:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801107:	f7 d8                	neg    %eax
  801109:	eb 03                	jmp    80110e <strtol+0x144>
  80110b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <ltostr>:

void
ltostr(long value, char *str)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
  801113:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80111d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801124:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801128:	79 13                	jns    80113d <ltostr+0x2d>
	{
		neg = 1;
  80112a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801131:	8b 45 0c             	mov    0xc(%ebp),%eax
  801134:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801137:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80113a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801145:	99                   	cltd   
  801146:	f7 f9                	idiv   %ecx
  801148:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80114b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114e:	8d 50 01             	lea    0x1(%eax),%edx
  801151:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801154:	89 c2                	mov    %eax,%edx
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	01 d0                	add    %edx,%eax
  80115b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80115e:	83 c2 30             	add    $0x30,%edx
  801161:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801163:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801166:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80116b:	f7 e9                	imul   %ecx
  80116d:	c1 fa 02             	sar    $0x2,%edx
  801170:	89 c8                	mov    %ecx,%eax
  801172:	c1 f8 1f             	sar    $0x1f,%eax
  801175:	29 c2                	sub    %eax,%edx
  801177:	89 d0                	mov    %edx,%eax
  801179:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80117c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80117f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801184:	f7 e9                	imul   %ecx
  801186:	c1 fa 02             	sar    $0x2,%edx
  801189:	89 c8                	mov    %ecx,%eax
  80118b:	c1 f8 1f             	sar    $0x1f,%eax
  80118e:	29 c2                	sub    %eax,%edx
  801190:	89 d0                	mov    %edx,%eax
  801192:	c1 e0 02             	shl    $0x2,%eax
  801195:	01 d0                	add    %edx,%eax
  801197:	01 c0                	add    %eax,%eax
  801199:	29 c1                	sub    %eax,%ecx
  80119b:	89 ca                	mov    %ecx,%edx
  80119d:	85 d2                	test   %edx,%edx
  80119f:	75 9c                	jne    80113d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011ab:	48                   	dec    %eax
  8011ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011af:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011b3:	74 3d                	je     8011f2 <ltostr+0xe2>
		start = 1 ;
  8011b5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011bc:	eb 34                	jmp    8011f2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	01 d0                	add    %edx,%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d1:	01 c2                	add    %eax,%edx
  8011d3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d9:	01 c8                	add    %ecx,%eax
  8011db:	8a 00                	mov    (%eax),%al
  8011dd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011df:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e5:	01 c2                	add    %eax,%edx
  8011e7:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011ea:	88 02                	mov    %al,(%edx)
		start++ ;
  8011ec:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011ef:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011f8:	7c c4                	jl     8011be <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011fa:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801200:	01 d0                	add    %edx,%eax
  801202:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801205:	90                   	nop
  801206:	c9                   	leave  
  801207:	c3                   	ret    

00801208 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801208:	55                   	push   %ebp
  801209:	89 e5                	mov    %esp,%ebp
  80120b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80120e:	ff 75 08             	pushl  0x8(%ebp)
  801211:	e8 54 fa ff ff       	call   800c6a <strlen>
  801216:	83 c4 04             	add    $0x4,%esp
  801219:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80121c:	ff 75 0c             	pushl  0xc(%ebp)
  80121f:	e8 46 fa ff ff       	call   800c6a <strlen>
  801224:	83 c4 04             	add    $0x4,%esp
  801227:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80122a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801231:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801238:	eb 17                	jmp    801251 <strcconcat+0x49>
		final[s] = str1[s] ;
  80123a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	01 c2                	add    %eax,%edx
  801242:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	01 c8                	add    %ecx,%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80124e:	ff 45 fc             	incl   -0x4(%ebp)
  801251:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801254:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801257:	7c e1                	jl     80123a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801259:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801260:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801267:	eb 1f                	jmp    801288 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801269:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126c:	8d 50 01             	lea    0x1(%eax),%edx
  80126f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801272:	89 c2                	mov    %eax,%edx
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 c2                	add    %eax,%edx
  801279:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80127c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127f:	01 c8                	add    %ecx,%eax
  801281:	8a 00                	mov    (%eax),%al
  801283:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801285:	ff 45 f8             	incl   -0x8(%ebp)
  801288:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80128e:	7c d9                	jl     801269 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801290:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801293:	8b 45 10             	mov    0x10(%ebp),%eax
  801296:	01 d0                	add    %edx,%eax
  801298:	c6 00 00             	movb   $0x0,(%eax)
}
  80129b:	90                   	nop
  80129c:	c9                   	leave  
  80129d:	c3                   	ret    

0080129e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80129e:	55                   	push   %ebp
  80129f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ad:	8b 00                	mov    (%eax),%eax
  8012af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b9:	01 d0                	add    %edx,%eax
  8012bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012c1:	eb 0c                	jmp    8012cf <strsplit+0x31>
			*string++ = 0;
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	8d 50 01             	lea    0x1(%eax),%edx
  8012c9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012cc:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	8a 00                	mov    (%eax),%al
  8012d4:	84 c0                	test   %al,%al
  8012d6:	74 18                	je     8012f0 <strsplit+0x52>
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	8a 00                	mov    (%eax),%al
  8012dd:	0f be c0             	movsbl %al,%eax
  8012e0:	50                   	push   %eax
  8012e1:	ff 75 0c             	pushl  0xc(%ebp)
  8012e4:	e8 13 fb ff ff       	call   800dfc <strchr>
  8012e9:	83 c4 08             	add    $0x8,%esp
  8012ec:	85 c0                	test   %eax,%eax
  8012ee:	75 d3                	jne    8012c3 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8a 00                	mov    (%eax),%al
  8012f5:	84 c0                	test   %al,%al
  8012f7:	74 5a                	je     801353 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  8012f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8012fc:	8b 00                	mov    (%eax),%eax
  8012fe:	83 f8 0f             	cmp    $0xf,%eax
  801301:	75 07                	jne    80130a <strsplit+0x6c>
		{
			return 0;
  801303:	b8 00 00 00 00       	mov    $0x0,%eax
  801308:	eb 66                	jmp    801370 <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80130a:	8b 45 14             	mov    0x14(%ebp),%eax
  80130d:	8b 00                	mov    (%eax),%eax
  80130f:	8d 48 01             	lea    0x1(%eax),%ecx
  801312:	8b 55 14             	mov    0x14(%ebp),%edx
  801315:	89 0a                	mov    %ecx,(%edx)
  801317:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80131e:	8b 45 10             	mov    0x10(%ebp),%eax
  801321:	01 c2                	add    %eax,%edx
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801328:	eb 03                	jmp    80132d <strsplit+0x8f>
			string++;
  80132a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	84 c0                	test   %al,%al
  801334:	74 8b                	je     8012c1 <strsplit+0x23>
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	0f be c0             	movsbl %al,%eax
  80133e:	50                   	push   %eax
  80133f:	ff 75 0c             	pushl  0xc(%ebp)
  801342:	e8 b5 fa ff ff       	call   800dfc <strchr>
  801347:	83 c4 08             	add    $0x8,%esp
  80134a:	85 c0                	test   %eax,%eax
  80134c:	74 dc                	je     80132a <strsplit+0x8c>
			string++;
	}
  80134e:	e9 6e ff ff ff       	jmp    8012c1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801353:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801354:	8b 45 14             	mov    0x14(%ebp),%eax
  801357:	8b 00                	mov    (%eax),%eax
  801359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801360:	8b 45 10             	mov    0x10(%ebp),%eax
  801363:	01 d0                	add    %edx,%eax
  801365:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80136b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801370:	c9                   	leave  
  801371:	c3                   	ret    

00801372 <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801372:	55                   	push   %ebp
  801373:	89 e5                	mov    %esp,%ebp
  801375:	83 ec 18             	sub    $0x18,%esp
  801378:	8b 45 10             	mov    0x10(%ebp),%eax
  80137b:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  80137e:	83 ec 04             	sub    $0x4,%esp
  801381:	68 d0 25 80 00       	push   $0x8025d0
  801386:	6a 17                	push   $0x17
  801388:	68 ef 25 80 00       	push   $0x8025ef
  80138d:	e8 8a 08 00 00       	call   801c1c <_panic>

00801392 <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
  801395:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801398:	83 ec 04             	sub    $0x4,%esp
  80139b:	68 fb 25 80 00       	push   $0x8025fb
  8013a0:	6a 2f                	push   $0x2f
  8013a2:	68 ef 25 80 00       	push   $0x8025ef
  8013a7:	e8 70 08 00 00       	call   801c1c <_panic>

008013ac <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  8013ac:	55                   	push   %ebp
  8013ad:	89 e5                	mov    %esp,%ebp
  8013af:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  8013b2:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  8013b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8013bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013bf:	01 d0                	add    %edx,%eax
  8013c1:	48                   	dec    %eax
  8013c2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8013c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8013cd:	f7 75 ec             	divl   -0x14(%ebp)
  8013d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8013d3:	29 d0                	sub    %edx,%eax
  8013d5:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	c1 e8 0c             	shr    $0xc,%eax
  8013de:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8013e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8013e8:	e9 c8 00 00 00       	jmp    8014b5 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  8013ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8013f4:	eb 27                	jmp    80141d <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  8013f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013fc:	01 c2                	add    %eax,%edx
  8013fe:	89 d0                	mov    %edx,%eax
  801400:	01 c0                	add    %eax,%eax
  801402:	01 d0                	add    %edx,%eax
  801404:	c1 e0 02             	shl    $0x2,%eax
  801407:	05 48 30 80 00       	add    $0x803048,%eax
  80140c:	8b 00                	mov    (%eax),%eax
  80140e:	85 c0                	test   %eax,%eax
  801410:	74 08                	je     80141a <malloc+0x6e>
            	i += j;
  801412:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801415:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801418:	eb 0b                	jmp    801425 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  80141a:	ff 45 f0             	incl   -0x10(%ebp)
  80141d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801420:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801423:	72 d1                	jb     8013f6 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801425:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801428:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80142b:	0f 85 81 00 00 00    	jne    8014b2 <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801434:	05 00 00 08 00       	add    $0x80000,%eax
  801439:	c1 e0 0c             	shl    $0xc,%eax
  80143c:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  80143f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801446:	eb 1f                	jmp    801467 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801448:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80144b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80144e:	01 c2                	add    %eax,%edx
  801450:	89 d0                	mov    %edx,%eax
  801452:	01 c0                	add    %eax,%eax
  801454:	01 d0                	add    %edx,%eax
  801456:	c1 e0 02             	shl    $0x2,%eax
  801459:	05 48 30 80 00       	add    $0x803048,%eax
  80145e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801464:	ff 45 f0             	incl   -0x10(%ebp)
  801467:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80146a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80146d:	72 d9                	jb     801448 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  80146f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801472:	89 d0                	mov    %edx,%eax
  801474:	01 c0                	add    %eax,%eax
  801476:	01 d0                	add    %edx,%eax
  801478:	c1 e0 02             	shl    $0x2,%eax
  80147b:	8d 90 40 30 80 00    	lea    0x803040(%eax),%edx
  801481:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801484:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801486:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801489:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  80148c:	89 c8                	mov    %ecx,%eax
  80148e:	01 c0                	add    %eax,%eax
  801490:	01 c8                	add    %ecx,%eax
  801492:	c1 e0 02             	shl    $0x2,%eax
  801495:	05 44 30 80 00       	add    $0x803044,%eax
  80149a:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  80149c:	83 ec 08             	sub    $0x8,%esp
  80149f:	ff 75 08             	pushl  0x8(%ebp)
  8014a2:	ff 75 e0             	pushl  -0x20(%ebp)
  8014a5:	e8 2b 03 00 00       	call   8017d5 <sys_allocateMem>
  8014aa:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  8014ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8014b0:	eb 19                	jmp    8014cb <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  8014b2:	ff 45 f4             	incl   -0xc(%ebp)
  8014b5:	a1 04 30 80 00       	mov    0x803004,%eax
  8014ba:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  8014bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014c0:	0f 83 27 ff ff ff    	jae    8013ed <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  8014c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8014d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014d7:	0f 84 e5 00 00 00    	je     8015c2 <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  8014e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8014e6:	05 00 00 00 80       	add    $0x80000000,%eax
  8014eb:	c1 e8 0c             	shr    $0xc,%eax
  8014ee:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  8014f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014f4:	89 d0                	mov    %edx,%eax
  8014f6:	01 c0                	add    %eax,%eax
  8014f8:	01 d0                	add    %edx,%eax
  8014fa:	c1 e0 02             	shl    $0x2,%eax
  8014fd:	05 40 30 80 00       	add    $0x803040,%eax
  801502:	8b 00                	mov    (%eax),%eax
  801504:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801507:	0f 85 b8 00 00 00    	jne    8015c5 <free+0xf8>
  80150d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801510:	89 d0                	mov    %edx,%eax
  801512:	01 c0                	add    %eax,%eax
  801514:	01 d0                	add    %edx,%eax
  801516:	c1 e0 02             	shl    $0x2,%eax
  801519:	05 48 30 80 00       	add    $0x803048,%eax
  80151e:	8b 00                	mov    (%eax),%eax
  801520:	85 c0                	test   %eax,%eax
  801522:	0f 84 9d 00 00 00    	je     8015c5 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801528:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80152b:	89 d0                	mov    %edx,%eax
  80152d:	01 c0                	add    %eax,%eax
  80152f:	01 d0                	add    %edx,%eax
  801531:	c1 e0 02             	shl    $0x2,%eax
  801534:	05 44 30 80 00       	add    $0x803044,%eax
  801539:	8b 00                	mov    (%eax),%eax
  80153b:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  80153e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801541:	c1 e0 0c             	shl    $0xc,%eax
  801544:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801547:	83 ec 08             	sub    $0x8,%esp
  80154a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80154d:	ff 75 f0             	pushl  -0x10(%ebp)
  801550:	e8 64 02 00 00       	call   8017b9 <sys_freeMem>
  801555:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801558:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80155f:	eb 57                	jmp    8015b8 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801561:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801564:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801567:	01 c2                	add    %eax,%edx
  801569:	89 d0                	mov    %edx,%eax
  80156b:	01 c0                	add    %eax,%eax
  80156d:	01 d0                	add    %edx,%eax
  80156f:	c1 e0 02             	shl    $0x2,%eax
  801572:	05 48 30 80 00       	add    $0x803048,%eax
  801577:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  80157d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801580:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801583:	01 c2                	add    %eax,%edx
  801585:	89 d0                	mov    %edx,%eax
  801587:	01 c0                	add    %eax,%eax
  801589:	01 d0                	add    %edx,%eax
  80158b:	c1 e0 02             	shl    $0x2,%eax
  80158e:	05 40 30 80 00       	add    $0x803040,%eax
  801593:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801599:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80159c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80159f:	01 c2                	add    %eax,%edx
  8015a1:	89 d0                	mov    %edx,%eax
  8015a3:	01 c0                	add    %eax,%eax
  8015a5:	01 d0                	add    %edx,%eax
  8015a7:	c1 e0 02             	shl    $0x2,%eax
  8015aa:	05 44 30 80 00       	add    $0x803044,%eax
  8015af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  8015b5:	ff 45 f4             	incl   -0xc(%ebp)
  8015b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8015be:	7c a1                	jl     801561 <free+0x94>
  8015c0:	eb 04                	jmp    8015c6 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  8015c2:	90                   	nop
  8015c3:	eb 01                	jmp    8015c6 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  8015c5:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
  8015cb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  8015ce:	83 ec 04             	sub    $0x4,%esp
  8015d1:	68 18 26 80 00       	push   $0x802618
  8015d6:	68 ae 00 00 00       	push   $0xae
  8015db:	68 ef 25 80 00       	push   $0x8025ef
  8015e0:	e8 37 06 00 00       	call   801c1c <_panic>

008015e5 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8015e5:	55                   	push   %ebp
  8015e6:	89 e5                	mov    %esp,%ebp
  8015e8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  8015eb:	83 ec 04             	sub    $0x4,%esp
  8015ee:	68 38 26 80 00       	push   $0x802638
  8015f3:	68 ca 00 00 00       	push   $0xca
  8015f8:	68 ef 25 80 00       	push   $0x8025ef
  8015fd:	e8 1a 06 00 00       	call   801c1c <_panic>

00801602 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
  801605:	57                   	push   %edi
  801606:	56                   	push   %esi
  801607:	53                   	push   %ebx
  801608:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801611:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801614:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801617:	8b 7d 18             	mov    0x18(%ebp),%edi
  80161a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80161d:	cd 30                	int    $0x30
  80161f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801622:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801625:	83 c4 10             	add    $0x10,%esp
  801628:	5b                   	pop    %ebx
  801629:	5e                   	pop    %esi
  80162a:	5f                   	pop    %edi
  80162b:	5d                   	pop    %ebp
  80162c:	c3                   	ret    

0080162d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
  801630:	83 ec 04             	sub    $0x4,%esp
  801633:	8b 45 10             	mov    0x10(%ebp),%eax
  801636:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801639:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	52                   	push   %edx
  801645:	ff 75 0c             	pushl  0xc(%ebp)
  801648:	50                   	push   %eax
  801649:	6a 00                	push   $0x0
  80164b:	e8 b2 ff ff ff       	call   801602 <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_cgetc>:

int
sys_cgetc(void)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 01                	push   $0x1
  801665:	e8 98 ff ff ff       	call   801602 <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	50                   	push   %eax
  80167e:	6a 05                	push   $0x5
  801680:	e8 7d ff ff ff       	call   801602 <syscall>
  801685:	83 c4 18             	add    $0x18,%esp
}
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 02                	push   $0x2
  801699:	e8 64 ff ff ff       	call   801602 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 03                	push   $0x3
  8016b2:	e8 4b ff ff ff       	call   801602 <syscall>
  8016b7:	83 c4 18             	add    $0x18,%esp
}
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 04                	push   $0x4
  8016cb:	e8 32 ff ff ff       	call   801602 <syscall>
  8016d0:	83 c4 18             	add    $0x18,%esp
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <sys_env_exit>:


void sys_env_exit(void)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 06                	push   $0x6
  8016e4:	e8 19 ff ff ff       	call   801602 <syscall>
  8016e9:	83 c4 18             	add    $0x18,%esp
}
  8016ec:	90                   	nop
  8016ed:	c9                   	leave  
  8016ee:	c3                   	ret    

008016ef <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	52                   	push   %edx
  8016ff:	50                   	push   %eax
  801700:	6a 07                	push   $0x7
  801702:	e8 fb fe ff ff       	call   801602 <syscall>
  801707:	83 c4 18             	add    $0x18,%esp
}
  80170a:	c9                   	leave  
  80170b:	c3                   	ret    

0080170c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80170c:	55                   	push   %ebp
  80170d:	89 e5                	mov    %esp,%ebp
  80170f:	56                   	push   %esi
  801710:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801711:	8b 75 18             	mov    0x18(%ebp),%esi
  801714:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801717:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171d:	8b 45 08             	mov    0x8(%ebp),%eax
  801720:	56                   	push   %esi
  801721:	53                   	push   %ebx
  801722:	51                   	push   %ecx
  801723:	52                   	push   %edx
  801724:	50                   	push   %eax
  801725:	6a 08                	push   $0x8
  801727:	e8 d6 fe ff ff       	call   801602 <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
}
  80172f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801732:	5b                   	pop    %ebx
  801733:	5e                   	pop    %esi
  801734:	5d                   	pop    %ebp
  801735:	c3                   	ret    

00801736 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801739:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	6a 00                	push   $0x0
  801745:	52                   	push   %edx
  801746:	50                   	push   %eax
  801747:	6a 09                	push   $0x9
  801749:	e8 b4 fe ff ff       	call   801602 <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	ff 75 0c             	pushl  0xc(%ebp)
  80175f:	ff 75 08             	pushl  0x8(%ebp)
  801762:	6a 0a                	push   $0xa
  801764:	e8 99 fe ff ff       	call   801602 <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 0b                	push   $0xb
  80177d:	e8 80 fe ff ff       	call   801602 <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 0c                	push   $0xc
  801796:	e8 67 fe ff ff       	call   801602 <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 0d                	push   $0xd
  8017af:	e8 4e fe ff ff       	call   801602 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
}
  8017b7:	c9                   	leave  
  8017b8:	c3                   	ret    

008017b9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017b9:	55                   	push   %ebp
  8017ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	ff 75 0c             	pushl  0xc(%ebp)
  8017c5:	ff 75 08             	pushl  0x8(%ebp)
  8017c8:	6a 11                	push   $0x11
  8017ca:	e8 33 fe ff ff       	call   801602 <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
	return;
  8017d2:	90                   	nop
}
  8017d3:	c9                   	leave  
  8017d4:	c3                   	ret    

008017d5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017d5:	55                   	push   %ebp
  8017d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	ff 75 0c             	pushl  0xc(%ebp)
  8017e1:	ff 75 08             	pushl  0x8(%ebp)
  8017e4:	6a 12                	push   $0x12
  8017e6:	e8 17 fe ff ff       	call   801602 <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ee:	90                   	nop
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	6a 00                	push   $0x0
  8017fa:	6a 00                	push   $0x0
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 0e                	push   $0xe
  801800:	e8 fd fd ff ff       	call   801602 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
}
  801808:	c9                   	leave  
  801809:	c3                   	ret    

0080180a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80180a:	55                   	push   %ebp
  80180b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	ff 75 08             	pushl  0x8(%ebp)
  801818:	6a 0f                	push   $0xf
  80181a:	e8 e3 fd ff ff       	call   801602 <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	c9                   	leave  
  801823:	c3                   	ret    

00801824 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 10                	push   $0x10
  801833:	e8 ca fd ff ff       	call   801602 <syscall>
  801838:	83 c4 18             	add    $0x18,%esp
}
  80183b:	90                   	nop
  80183c:	c9                   	leave  
  80183d:	c3                   	ret    

0080183e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80183e:	55                   	push   %ebp
  80183f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 14                	push   $0x14
  80184d:	e8 b0 fd ff ff       	call   801602 <syscall>
  801852:	83 c4 18             	add    $0x18,%esp
}
  801855:	90                   	nop
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 15                	push   $0x15
  801867:	e8 96 fd ff ff       	call   801602 <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
}
  80186f:	90                   	nop
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_cputc>:


void
sys_cputc(const char c)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
  801875:	83 ec 04             	sub    $0x4,%esp
  801878:	8b 45 08             	mov    0x8(%ebp),%eax
  80187b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80187e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	50                   	push   %eax
  80188b:	6a 16                	push   $0x16
  80188d:	e8 70 fd ff ff       	call   801602 <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	90                   	nop
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 17                	push   $0x17
  8018a7:	e8 56 fd ff ff       	call   801602 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	90                   	nop
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	ff 75 0c             	pushl  0xc(%ebp)
  8018c1:	50                   	push   %eax
  8018c2:	6a 18                	push   $0x18
  8018c4:	e8 39 fd ff ff       	call   801602 <syscall>
  8018c9:	83 c4 18             	add    $0x18,%esp
}
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	52                   	push   %edx
  8018de:	50                   	push   %eax
  8018df:	6a 1b                	push   $0x1b
  8018e1:	e8 1c fd ff ff       	call   801602 <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	52                   	push   %edx
  8018fb:	50                   	push   %eax
  8018fc:	6a 19                	push   $0x19
  8018fe:	e8 ff fc ff ff       	call   801602 <syscall>
  801903:	83 c4 18             	add    $0x18,%esp
}
  801906:	90                   	nop
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80190c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190f:	8b 45 08             	mov    0x8(%ebp),%eax
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	52                   	push   %edx
  801919:	50                   	push   %eax
  80191a:	6a 1a                	push   $0x1a
  80191c:	e8 e1 fc ff ff       	call   801602 <syscall>
  801921:	83 c4 18             	add    $0x18,%esp
}
  801924:	90                   	nop
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
  80192a:	83 ec 04             	sub    $0x4,%esp
  80192d:	8b 45 10             	mov    0x10(%ebp),%eax
  801930:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801933:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801936:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80193a:	8b 45 08             	mov    0x8(%ebp),%eax
  80193d:	6a 00                	push   $0x0
  80193f:	51                   	push   %ecx
  801940:	52                   	push   %edx
  801941:	ff 75 0c             	pushl  0xc(%ebp)
  801944:	50                   	push   %eax
  801945:	6a 1c                	push   $0x1c
  801947:	e8 b6 fc ff ff       	call   801602 <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
}
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801954:	8b 55 0c             	mov    0xc(%ebp),%edx
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	52                   	push   %edx
  801961:	50                   	push   %eax
  801962:	6a 1d                	push   $0x1d
  801964:	e8 99 fc ff ff       	call   801602 <syscall>
  801969:	83 c4 18             	add    $0x18,%esp
}
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801971:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801974:	8b 55 0c             	mov    0xc(%ebp),%edx
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	6a 00                	push   $0x0
  80197c:	6a 00                	push   $0x0
  80197e:	51                   	push   %ecx
  80197f:	52                   	push   %edx
  801980:	50                   	push   %eax
  801981:	6a 1e                	push   $0x1e
  801983:	e8 7a fc ff ff       	call   801602 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
}
  80198b:	c9                   	leave  
  80198c:	c3                   	ret    

0080198d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80198d:	55                   	push   %ebp
  80198e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801990:	8b 55 0c             	mov    0xc(%ebp),%edx
  801993:	8b 45 08             	mov    0x8(%ebp),%eax
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	52                   	push   %edx
  80199d:	50                   	push   %eax
  80199e:	6a 1f                	push   $0x1f
  8019a0:	e8 5d fc ff ff       	call   801602 <syscall>
  8019a5:	83 c4 18             	add    $0x18,%esp
}
  8019a8:	c9                   	leave  
  8019a9:	c3                   	ret    

008019aa <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019aa:	55                   	push   %ebp
  8019ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 20                	push   $0x20
  8019b9:	e8 44 fc ff ff       	call   801602 <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	ff 75 10             	pushl  0x10(%ebp)
  8019d0:	ff 75 0c             	pushl  0xc(%ebp)
  8019d3:	50                   	push   %eax
  8019d4:	6a 21                	push   $0x21
  8019d6:	e8 27 fc ff ff       	call   801602 <syscall>
  8019db:	83 c4 18             	add    $0x18,%esp
}
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	50                   	push   %eax
  8019ef:	6a 22                	push   $0x22
  8019f1:	e8 0c fc ff ff       	call   801602 <syscall>
  8019f6:	83 c4 18             	add    $0x18,%esp
}
  8019f9:	90                   	nop
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	50                   	push   %eax
  801a0b:	6a 23                	push   $0x23
  801a0d:	e8 f0 fb ff ff       	call   801602 <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	90                   	nop
  801a16:	c9                   	leave  
  801a17:	c3                   	ret    

00801a18 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a18:	55                   	push   %ebp
  801a19:	89 e5                	mov    %esp,%ebp
  801a1b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a1e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a21:	8d 50 04             	lea    0x4(%eax),%edx
  801a24:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 00                	push   $0x0
  801a2d:	52                   	push   %edx
  801a2e:	50                   	push   %eax
  801a2f:	6a 24                	push   $0x24
  801a31:	e8 cc fb ff ff       	call   801602 <syscall>
  801a36:	83 c4 18             	add    $0x18,%esp
	return result;
  801a39:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a42:	89 01                	mov    %eax,(%ecx)
  801a44:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a47:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4a:	c9                   	leave  
  801a4b:	c2 04 00             	ret    $0x4

00801a4e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	ff 75 10             	pushl  0x10(%ebp)
  801a58:	ff 75 0c             	pushl  0xc(%ebp)
  801a5b:	ff 75 08             	pushl  0x8(%ebp)
  801a5e:	6a 13                	push   $0x13
  801a60:	e8 9d fb ff ff       	call   801602 <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
	return ;
  801a68:	90                   	nop
}
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <sys_rcr2>:
uint32 sys_rcr2()
{
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 00                	push   $0x0
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 25                	push   $0x25
  801a7a:	e8 83 fb ff ff       	call   801602 <syscall>
  801a7f:	83 c4 18             	add    $0x18,%esp
}
  801a82:	c9                   	leave  
  801a83:	c3                   	ret    

00801a84 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a84:	55                   	push   %ebp
  801a85:	89 e5                	mov    %esp,%ebp
  801a87:	83 ec 04             	sub    $0x4,%esp
  801a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a90:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	50                   	push   %eax
  801a9d:	6a 26                	push   $0x26
  801a9f:	e8 5e fb ff ff       	call   801602 <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa7:	90                   	nop
}
  801aa8:	c9                   	leave  
  801aa9:	c3                   	ret    

00801aaa <rsttst>:
void rsttst()
{
  801aaa:	55                   	push   %ebp
  801aab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 28                	push   $0x28
  801ab9:	e8 44 fb ff ff       	call   801602 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac1:	90                   	nop
}
  801ac2:	c9                   	leave  
  801ac3:	c3                   	ret    

00801ac4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ac4:	55                   	push   %ebp
  801ac5:	89 e5                	mov    %esp,%ebp
  801ac7:	83 ec 04             	sub    $0x4,%esp
  801aca:	8b 45 14             	mov    0x14(%ebp),%eax
  801acd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ad0:	8b 55 18             	mov    0x18(%ebp),%edx
  801ad3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ad7:	52                   	push   %edx
  801ad8:	50                   	push   %eax
  801ad9:	ff 75 10             	pushl  0x10(%ebp)
  801adc:	ff 75 0c             	pushl  0xc(%ebp)
  801adf:	ff 75 08             	pushl  0x8(%ebp)
  801ae2:	6a 27                	push   $0x27
  801ae4:	e8 19 fb ff ff       	call   801602 <syscall>
  801ae9:	83 c4 18             	add    $0x18,%esp
	return ;
  801aec:	90                   	nop
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <chktst>:
void chktst(uint32 n)
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	ff 75 08             	pushl  0x8(%ebp)
  801afd:	6a 29                	push   $0x29
  801aff:	e8 fe fa ff ff       	call   801602 <syscall>
  801b04:	83 c4 18             	add    $0x18,%esp
	return ;
  801b07:	90                   	nop
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <inctst>:

void inctst()
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 2a                	push   $0x2a
  801b19:	e8 e4 fa ff ff       	call   801602 <syscall>
  801b1e:	83 c4 18             	add    $0x18,%esp
	return ;
  801b21:	90                   	nop
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <gettst>:
uint32 gettst()
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 2b                	push   $0x2b
  801b33:	e8 ca fa ff ff       	call   801602 <syscall>
  801b38:	83 c4 18             	add    $0x18,%esp
}
  801b3b:	c9                   	leave  
  801b3c:	c3                   	ret    

00801b3d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
  801b40:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b43:	6a 00                	push   $0x0
  801b45:	6a 00                	push   $0x0
  801b47:	6a 00                	push   $0x0
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 2c                	push   $0x2c
  801b4f:	e8 ae fa ff ff       	call   801602 <syscall>
  801b54:	83 c4 18             	add    $0x18,%esp
  801b57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b5a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b5e:	75 07                	jne    801b67 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b60:	b8 01 00 00 00       	mov    $0x1,%eax
  801b65:	eb 05                	jmp    801b6c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b67:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b6c:	c9                   	leave  
  801b6d:	c3                   	ret    

00801b6e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
  801b71:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 2c                	push   $0x2c
  801b80:	e8 7d fa ff ff       	call   801602 <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
  801b88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b8b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b8f:	75 07                	jne    801b98 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b91:	b8 01 00 00 00       	mov    $0x1,%eax
  801b96:	eb 05                	jmp    801b9d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b98:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b9d:	c9                   	leave  
  801b9e:	c3                   	ret    

00801b9f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b9f:	55                   	push   %ebp
  801ba0:	89 e5                	mov    %esp,%ebp
  801ba2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 2c                	push   $0x2c
  801bb1:	e8 4c fa ff ff       	call   801602 <syscall>
  801bb6:	83 c4 18             	add    $0x18,%esp
  801bb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bbc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bc0:	75 07                	jne    801bc9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bc2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc7:	eb 05                	jmp    801bce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801bc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 2c                	push   $0x2c
  801be2:	e8 1b fa ff ff       	call   801602 <syscall>
  801be7:	83 c4 18             	add    $0x18,%esp
  801bea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bed:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bf1:	75 07                	jne    801bfa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bf3:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf8:	eb 05                	jmp    801bff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bff:	c9                   	leave  
  801c00:	c3                   	ret    

00801c01 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c01:	55                   	push   %ebp
  801c02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	ff 75 08             	pushl  0x8(%ebp)
  801c0f:	6a 2d                	push   $0x2d
  801c11:	e8 ec f9 ff ff       	call   801602 <syscall>
  801c16:	83 c4 18             	add    $0x18,%esp
	return ;
  801c19:	90                   	nop
}
  801c1a:	c9                   	leave  
  801c1b:	c3                   	ret    

00801c1c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c1c:	55                   	push   %ebp
  801c1d:	89 e5                	mov    %esp,%ebp
  801c1f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c22:	8d 45 10             	lea    0x10(%ebp),%eax
  801c25:	83 c0 04             	add    $0x4,%eax
  801c28:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c2b:	a1 40 30 98 00       	mov    0x983040,%eax
  801c30:	85 c0                	test   %eax,%eax
  801c32:	74 16                	je     801c4a <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c34:	a1 40 30 98 00       	mov    0x983040,%eax
  801c39:	83 ec 08             	sub    $0x8,%esp
  801c3c:	50                   	push   %eax
  801c3d:	68 5c 26 80 00       	push   $0x80265c
  801c42:	e8 a1 e9 ff ff       	call   8005e8 <cprintf>
  801c47:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c4a:	a1 00 30 80 00       	mov    0x803000,%eax
  801c4f:	ff 75 0c             	pushl  0xc(%ebp)
  801c52:	ff 75 08             	pushl  0x8(%ebp)
  801c55:	50                   	push   %eax
  801c56:	68 61 26 80 00       	push   $0x802661
  801c5b:	e8 88 e9 ff ff       	call   8005e8 <cprintf>
  801c60:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c63:	8b 45 10             	mov    0x10(%ebp),%eax
  801c66:	83 ec 08             	sub    $0x8,%esp
  801c69:	ff 75 f4             	pushl  -0xc(%ebp)
  801c6c:	50                   	push   %eax
  801c6d:	e8 0b e9 ff ff       	call   80057d <vcprintf>
  801c72:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801c75:	83 ec 08             	sub    $0x8,%esp
  801c78:	6a 00                	push   $0x0
  801c7a:	68 7d 26 80 00       	push   $0x80267d
  801c7f:	e8 f9 e8 ff ff       	call   80057d <vcprintf>
  801c84:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801c87:	e8 7a e8 ff ff       	call   800506 <exit>

	// should not return here
	while (1) ;
  801c8c:	eb fe                	jmp    801c8c <_panic+0x70>

00801c8e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
  801c91:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801c94:	a1 20 30 80 00       	mov    0x803020,%eax
  801c99:	8b 50 74             	mov    0x74(%eax),%edx
  801c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c9f:	39 c2                	cmp    %eax,%edx
  801ca1:	74 14                	je     801cb7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ca3:	83 ec 04             	sub    $0x4,%esp
  801ca6:	68 80 26 80 00       	push   $0x802680
  801cab:	6a 26                	push   $0x26
  801cad:	68 cc 26 80 00       	push   $0x8026cc
  801cb2:	e8 65 ff ff ff       	call   801c1c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801cb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801cbe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cc5:	e9 c2 00 00 00       	jmp    801d8c <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  801cca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ccd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd7:	01 d0                	add    %edx,%eax
  801cd9:	8b 00                	mov    (%eax),%eax
  801cdb:	85 c0                	test   %eax,%eax
  801cdd:	75 08                	jne    801ce7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801cdf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801ce2:	e9 a2 00 00 00       	jmp    801d89 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  801ce7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cee:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801cf5:	eb 69                	jmp    801d60 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801cf7:	a1 20 30 80 00       	mov    0x803020,%eax
  801cfc:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d02:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d05:	89 d0                	mov    %edx,%eax
  801d07:	01 c0                	add    %eax,%eax
  801d09:	01 d0                	add    %edx,%eax
  801d0b:	c1 e0 02             	shl    $0x2,%eax
  801d0e:	01 c8                	add    %ecx,%eax
  801d10:	8a 40 04             	mov    0x4(%eax),%al
  801d13:	84 c0                	test   %al,%al
  801d15:	75 46                	jne    801d5d <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d17:	a1 20 30 80 00       	mov    0x803020,%eax
  801d1c:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801d22:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d25:	89 d0                	mov    %edx,%eax
  801d27:	01 c0                	add    %eax,%eax
  801d29:	01 d0                	add    %edx,%eax
  801d2b:	c1 e0 02             	shl    $0x2,%eax
  801d2e:	01 c8                	add    %ecx,%eax
  801d30:	8b 00                	mov    (%eax),%eax
  801d32:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d35:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d38:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d3d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d42:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d49:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4c:	01 c8                	add    %ecx,%eax
  801d4e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d50:	39 c2                	cmp    %eax,%edx
  801d52:	75 09                	jne    801d5d <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801d54:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d5b:	eb 12                	jmp    801d6f <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d5d:	ff 45 e8             	incl   -0x18(%ebp)
  801d60:	a1 20 30 80 00       	mov    0x803020,%eax
  801d65:	8b 50 74             	mov    0x74(%eax),%edx
  801d68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d6b:	39 c2                	cmp    %eax,%edx
  801d6d:	77 88                	ja     801cf7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d6f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d73:	75 14                	jne    801d89 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801d75:	83 ec 04             	sub    $0x4,%esp
  801d78:	68 d8 26 80 00       	push   $0x8026d8
  801d7d:	6a 3a                	push   $0x3a
  801d7f:	68 cc 26 80 00       	push   $0x8026cc
  801d84:	e8 93 fe ff ff       	call   801c1c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801d89:	ff 45 f0             	incl   -0x10(%ebp)
  801d8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d8f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801d92:	0f 8c 32 ff ff ff    	jl     801cca <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d98:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d9f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801da6:	eb 26                	jmp    801dce <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801da8:	a1 20 30 80 00       	mov    0x803020,%eax
  801dad:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  801db3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801db6:	89 d0                	mov    %edx,%eax
  801db8:	01 c0                	add    %eax,%eax
  801dba:	01 d0                	add    %edx,%eax
  801dbc:	c1 e0 02             	shl    $0x2,%eax
  801dbf:	01 c8                	add    %ecx,%eax
  801dc1:	8a 40 04             	mov    0x4(%eax),%al
  801dc4:	3c 01                	cmp    $0x1,%al
  801dc6:	75 03                	jne    801dcb <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  801dc8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dcb:	ff 45 e0             	incl   -0x20(%ebp)
  801dce:	a1 20 30 80 00       	mov    0x803020,%eax
  801dd3:	8b 50 74             	mov    0x74(%eax),%edx
  801dd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801dd9:	39 c2                	cmp    %eax,%edx
  801ddb:	77 cb                	ja     801da8 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801de0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801de3:	74 14                	je     801df9 <CheckWSWithoutLastIndex+0x16b>
		panic(
  801de5:	83 ec 04             	sub    $0x4,%esp
  801de8:	68 2c 27 80 00       	push   $0x80272c
  801ded:	6a 44                	push   $0x44
  801def:	68 cc 26 80 00       	push   $0x8026cc
  801df4:	e8 23 fe ff ff       	call   801c1c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801df9:	90                   	nop
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <__udivdi3>:
  801dfc:	55                   	push   %ebp
  801dfd:	57                   	push   %edi
  801dfe:	56                   	push   %esi
  801dff:	53                   	push   %ebx
  801e00:	83 ec 1c             	sub    $0x1c,%esp
  801e03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e13:	89 ca                	mov    %ecx,%edx
  801e15:	89 f8                	mov    %edi,%eax
  801e17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e1b:	85 f6                	test   %esi,%esi
  801e1d:	75 2d                	jne    801e4c <__udivdi3+0x50>
  801e1f:	39 cf                	cmp    %ecx,%edi
  801e21:	77 65                	ja     801e88 <__udivdi3+0x8c>
  801e23:	89 fd                	mov    %edi,%ebp
  801e25:	85 ff                	test   %edi,%edi
  801e27:	75 0b                	jne    801e34 <__udivdi3+0x38>
  801e29:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2e:	31 d2                	xor    %edx,%edx
  801e30:	f7 f7                	div    %edi
  801e32:	89 c5                	mov    %eax,%ebp
  801e34:	31 d2                	xor    %edx,%edx
  801e36:	89 c8                	mov    %ecx,%eax
  801e38:	f7 f5                	div    %ebp
  801e3a:	89 c1                	mov    %eax,%ecx
  801e3c:	89 d8                	mov    %ebx,%eax
  801e3e:	f7 f5                	div    %ebp
  801e40:	89 cf                	mov    %ecx,%edi
  801e42:	89 fa                	mov    %edi,%edx
  801e44:	83 c4 1c             	add    $0x1c,%esp
  801e47:	5b                   	pop    %ebx
  801e48:	5e                   	pop    %esi
  801e49:	5f                   	pop    %edi
  801e4a:	5d                   	pop    %ebp
  801e4b:	c3                   	ret    
  801e4c:	39 ce                	cmp    %ecx,%esi
  801e4e:	77 28                	ja     801e78 <__udivdi3+0x7c>
  801e50:	0f bd fe             	bsr    %esi,%edi
  801e53:	83 f7 1f             	xor    $0x1f,%edi
  801e56:	75 40                	jne    801e98 <__udivdi3+0x9c>
  801e58:	39 ce                	cmp    %ecx,%esi
  801e5a:	72 0a                	jb     801e66 <__udivdi3+0x6a>
  801e5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e60:	0f 87 9e 00 00 00    	ja     801f04 <__udivdi3+0x108>
  801e66:	b8 01 00 00 00       	mov    $0x1,%eax
  801e6b:	89 fa                	mov    %edi,%edx
  801e6d:	83 c4 1c             	add    $0x1c,%esp
  801e70:	5b                   	pop    %ebx
  801e71:	5e                   	pop    %esi
  801e72:	5f                   	pop    %edi
  801e73:	5d                   	pop    %ebp
  801e74:	c3                   	ret    
  801e75:	8d 76 00             	lea    0x0(%esi),%esi
  801e78:	31 ff                	xor    %edi,%edi
  801e7a:	31 c0                	xor    %eax,%eax
  801e7c:	89 fa                	mov    %edi,%edx
  801e7e:	83 c4 1c             	add    $0x1c,%esp
  801e81:	5b                   	pop    %ebx
  801e82:	5e                   	pop    %esi
  801e83:	5f                   	pop    %edi
  801e84:	5d                   	pop    %ebp
  801e85:	c3                   	ret    
  801e86:	66 90                	xchg   %ax,%ax
  801e88:	89 d8                	mov    %ebx,%eax
  801e8a:	f7 f7                	div    %edi
  801e8c:	31 ff                	xor    %edi,%edi
  801e8e:	89 fa                	mov    %edi,%edx
  801e90:	83 c4 1c             	add    $0x1c,%esp
  801e93:	5b                   	pop    %ebx
  801e94:	5e                   	pop    %esi
  801e95:	5f                   	pop    %edi
  801e96:	5d                   	pop    %ebp
  801e97:	c3                   	ret    
  801e98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e9d:	89 eb                	mov    %ebp,%ebx
  801e9f:	29 fb                	sub    %edi,%ebx
  801ea1:	89 f9                	mov    %edi,%ecx
  801ea3:	d3 e6                	shl    %cl,%esi
  801ea5:	89 c5                	mov    %eax,%ebp
  801ea7:	88 d9                	mov    %bl,%cl
  801ea9:	d3 ed                	shr    %cl,%ebp
  801eab:	89 e9                	mov    %ebp,%ecx
  801ead:	09 f1                	or     %esi,%ecx
  801eaf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801eb3:	89 f9                	mov    %edi,%ecx
  801eb5:	d3 e0                	shl    %cl,%eax
  801eb7:	89 c5                	mov    %eax,%ebp
  801eb9:	89 d6                	mov    %edx,%esi
  801ebb:	88 d9                	mov    %bl,%cl
  801ebd:	d3 ee                	shr    %cl,%esi
  801ebf:	89 f9                	mov    %edi,%ecx
  801ec1:	d3 e2                	shl    %cl,%edx
  801ec3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec7:	88 d9                	mov    %bl,%cl
  801ec9:	d3 e8                	shr    %cl,%eax
  801ecb:	09 c2                	or     %eax,%edx
  801ecd:	89 d0                	mov    %edx,%eax
  801ecf:	89 f2                	mov    %esi,%edx
  801ed1:	f7 74 24 0c          	divl   0xc(%esp)
  801ed5:	89 d6                	mov    %edx,%esi
  801ed7:	89 c3                	mov    %eax,%ebx
  801ed9:	f7 e5                	mul    %ebp
  801edb:	39 d6                	cmp    %edx,%esi
  801edd:	72 19                	jb     801ef8 <__udivdi3+0xfc>
  801edf:	74 0b                	je     801eec <__udivdi3+0xf0>
  801ee1:	89 d8                	mov    %ebx,%eax
  801ee3:	31 ff                	xor    %edi,%edi
  801ee5:	e9 58 ff ff ff       	jmp    801e42 <__udivdi3+0x46>
  801eea:	66 90                	xchg   %ax,%ax
  801eec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ef0:	89 f9                	mov    %edi,%ecx
  801ef2:	d3 e2                	shl    %cl,%edx
  801ef4:	39 c2                	cmp    %eax,%edx
  801ef6:	73 e9                	jae    801ee1 <__udivdi3+0xe5>
  801ef8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801efb:	31 ff                	xor    %edi,%edi
  801efd:	e9 40 ff ff ff       	jmp    801e42 <__udivdi3+0x46>
  801f02:	66 90                	xchg   %ax,%ax
  801f04:	31 c0                	xor    %eax,%eax
  801f06:	e9 37 ff ff ff       	jmp    801e42 <__udivdi3+0x46>
  801f0b:	90                   	nop

00801f0c <__umoddi3>:
  801f0c:	55                   	push   %ebp
  801f0d:	57                   	push   %edi
  801f0e:	56                   	push   %esi
  801f0f:	53                   	push   %ebx
  801f10:	83 ec 1c             	sub    $0x1c,%esp
  801f13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f2b:	89 f3                	mov    %esi,%ebx
  801f2d:	89 fa                	mov    %edi,%edx
  801f2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f33:	89 34 24             	mov    %esi,(%esp)
  801f36:	85 c0                	test   %eax,%eax
  801f38:	75 1a                	jne    801f54 <__umoddi3+0x48>
  801f3a:	39 f7                	cmp    %esi,%edi
  801f3c:	0f 86 a2 00 00 00    	jbe    801fe4 <__umoddi3+0xd8>
  801f42:	89 c8                	mov    %ecx,%eax
  801f44:	89 f2                	mov    %esi,%edx
  801f46:	f7 f7                	div    %edi
  801f48:	89 d0                	mov    %edx,%eax
  801f4a:	31 d2                	xor    %edx,%edx
  801f4c:	83 c4 1c             	add    $0x1c,%esp
  801f4f:	5b                   	pop    %ebx
  801f50:	5e                   	pop    %esi
  801f51:	5f                   	pop    %edi
  801f52:	5d                   	pop    %ebp
  801f53:	c3                   	ret    
  801f54:	39 f0                	cmp    %esi,%eax
  801f56:	0f 87 ac 00 00 00    	ja     802008 <__umoddi3+0xfc>
  801f5c:	0f bd e8             	bsr    %eax,%ebp
  801f5f:	83 f5 1f             	xor    $0x1f,%ebp
  801f62:	0f 84 ac 00 00 00    	je     802014 <__umoddi3+0x108>
  801f68:	bf 20 00 00 00       	mov    $0x20,%edi
  801f6d:	29 ef                	sub    %ebp,%edi
  801f6f:	89 fe                	mov    %edi,%esi
  801f71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f75:	89 e9                	mov    %ebp,%ecx
  801f77:	d3 e0                	shl    %cl,%eax
  801f79:	89 d7                	mov    %edx,%edi
  801f7b:	89 f1                	mov    %esi,%ecx
  801f7d:	d3 ef                	shr    %cl,%edi
  801f7f:	09 c7                	or     %eax,%edi
  801f81:	89 e9                	mov    %ebp,%ecx
  801f83:	d3 e2                	shl    %cl,%edx
  801f85:	89 14 24             	mov    %edx,(%esp)
  801f88:	89 d8                	mov    %ebx,%eax
  801f8a:	d3 e0                	shl    %cl,%eax
  801f8c:	89 c2                	mov    %eax,%edx
  801f8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f92:	d3 e0                	shl    %cl,%eax
  801f94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f9c:	89 f1                	mov    %esi,%ecx
  801f9e:	d3 e8                	shr    %cl,%eax
  801fa0:	09 d0                	or     %edx,%eax
  801fa2:	d3 eb                	shr    %cl,%ebx
  801fa4:	89 da                	mov    %ebx,%edx
  801fa6:	f7 f7                	div    %edi
  801fa8:	89 d3                	mov    %edx,%ebx
  801faa:	f7 24 24             	mull   (%esp)
  801fad:	89 c6                	mov    %eax,%esi
  801faf:	89 d1                	mov    %edx,%ecx
  801fb1:	39 d3                	cmp    %edx,%ebx
  801fb3:	0f 82 87 00 00 00    	jb     802040 <__umoddi3+0x134>
  801fb9:	0f 84 91 00 00 00    	je     802050 <__umoddi3+0x144>
  801fbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fc3:	29 f2                	sub    %esi,%edx
  801fc5:	19 cb                	sbb    %ecx,%ebx
  801fc7:	89 d8                	mov    %ebx,%eax
  801fc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fcd:	d3 e0                	shl    %cl,%eax
  801fcf:	89 e9                	mov    %ebp,%ecx
  801fd1:	d3 ea                	shr    %cl,%edx
  801fd3:	09 d0                	or     %edx,%eax
  801fd5:	89 e9                	mov    %ebp,%ecx
  801fd7:	d3 eb                	shr    %cl,%ebx
  801fd9:	89 da                	mov    %ebx,%edx
  801fdb:	83 c4 1c             	add    $0x1c,%esp
  801fde:	5b                   	pop    %ebx
  801fdf:	5e                   	pop    %esi
  801fe0:	5f                   	pop    %edi
  801fe1:	5d                   	pop    %ebp
  801fe2:	c3                   	ret    
  801fe3:	90                   	nop
  801fe4:	89 fd                	mov    %edi,%ebp
  801fe6:	85 ff                	test   %edi,%edi
  801fe8:	75 0b                	jne    801ff5 <__umoddi3+0xe9>
  801fea:	b8 01 00 00 00       	mov    $0x1,%eax
  801fef:	31 d2                	xor    %edx,%edx
  801ff1:	f7 f7                	div    %edi
  801ff3:	89 c5                	mov    %eax,%ebp
  801ff5:	89 f0                	mov    %esi,%eax
  801ff7:	31 d2                	xor    %edx,%edx
  801ff9:	f7 f5                	div    %ebp
  801ffb:	89 c8                	mov    %ecx,%eax
  801ffd:	f7 f5                	div    %ebp
  801fff:	89 d0                	mov    %edx,%eax
  802001:	e9 44 ff ff ff       	jmp    801f4a <__umoddi3+0x3e>
  802006:	66 90                	xchg   %ax,%ax
  802008:	89 c8                	mov    %ecx,%eax
  80200a:	89 f2                	mov    %esi,%edx
  80200c:	83 c4 1c             	add    $0x1c,%esp
  80200f:	5b                   	pop    %ebx
  802010:	5e                   	pop    %esi
  802011:	5f                   	pop    %edi
  802012:	5d                   	pop    %ebp
  802013:	c3                   	ret    
  802014:	3b 04 24             	cmp    (%esp),%eax
  802017:	72 06                	jb     80201f <__umoddi3+0x113>
  802019:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80201d:	77 0f                	ja     80202e <__umoddi3+0x122>
  80201f:	89 f2                	mov    %esi,%edx
  802021:	29 f9                	sub    %edi,%ecx
  802023:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802027:	89 14 24             	mov    %edx,(%esp)
  80202a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80202e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802032:	8b 14 24             	mov    (%esp),%edx
  802035:	83 c4 1c             	add    $0x1c,%esp
  802038:	5b                   	pop    %ebx
  802039:	5e                   	pop    %esi
  80203a:	5f                   	pop    %edi
  80203b:	5d                   	pop    %ebp
  80203c:	c3                   	ret    
  80203d:	8d 76 00             	lea    0x0(%esi),%esi
  802040:	2b 04 24             	sub    (%esp),%eax
  802043:	19 fa                	sbb    %edi,%edx
  802045:	89 d1                	mov    %edx,%ecx
  802047:	89 c6                	mov    %eax,%esi
  802049:	e9 71 ff ff ff       	jmp    801fbf <__umoddi3+0xb3>
  80204e:	66 90                	xchg   %ax,%ax
  802050:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802054:	72 ea                	jb     802040 <__umoddi3+0x134>
  802056:	89 d9                	mov    %ebx,%ecx
  802058:	e9 62 ff ff ff       	jmp    801fbf <__umoddi3+0xb3>
