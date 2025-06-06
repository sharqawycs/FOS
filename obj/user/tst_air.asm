
obj/user/tst_air:     file format elf32-i386


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
  800031:	e8 c9 0a 00 00       	call   800aff <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <user/air.h>
int find(int* arr, int size, int val);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec fc 01 00 00    	sub    $0x1fc,%esp
	int envID = sys_getenvid();
  800044:	e8 0e 1f 00 00       	call   801f57 <sys_getenvid>
  800049:	89 45 bc             	mov    %eax,-0x44(%ebp)

	// *************************************************************************************************
	/// Shared Variables Region ************************************************************************
	// *************************************************************************************************

	int numOfCustomers = 15;
  80004c:	c7 45 b8 0f 00 00 00 	movl   $0xf,-0x48(%ebp)
	int flight1Customers = 3;
  800053:	c7 45 b4 03 00 00 00 	movl   $0x3,-0x4c(%ebp)
	int flight2Customers = 8;
  80005a:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%ebp)
	int flight3Customers = 4;
  800061:	c7 45 ac 04 00 00 00 	movl   $0x4,-0x54(%ebp)

	int flight1NumOfTickets = 8;
  800068:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%ebp)
	int flight2NumOfTickets = 15;
  80006f:	c7 45 a4 0f 00 00 00 	movl   $0xf,-0x5c(%ebp)

	char _customers[] = "customers";
  800076:	8d 85 6a ff ff ff    	lea    -0x96(%ebp),%eax
  80007c:	bb ae 2a 80 00       	mov    $0x802aae,%ebx
  800081:	ba 0a 00 00 00       	mov    $0xa,%edx
  800086:	89 c7                	mov    %eax,%edi
  800088:	89 de                	mov    %ebx,%esi
  80008a:	89 d1                	mov    %edx,%ecx
  80008c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custCounter[] = "custCounter";
  80008e:	8d 85 5e ff ff ff    	lea    -0xa2(%ebp),%eax
  800094:	bb b8 2a 80 00       	mov    $0x802ab8,%ebx
  800099:	ba 03 00 00 00       	mov    $0x3,%edx
  80009e:	89 c7                	mov    %eax,%edi
  8000a0:	89 de                	mov    %ebx,%esi
  8000a2:	89 d1                	mov    %edx,%ecx
  8000a4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1Counter[] = "flight1Counter";
  8000a6:	8d 85 4f ff ff ff    	lea    -0xb1(%ebp),%eax
  8000ac:	bb c4 2a 80 00       	mov    $0x802ac4,%ebx
  8000b1:	ba 0f 00 00 00       	mov    $0xf,%edx
  8000b6:	89 c7                	mov    %eax,%edi
  8000b8:	89 de                	mov    %ebx,%esi
  8000ba:	89 d1                	mov    %edx,%ecx
  8000bc:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2Counter[] = "flight2Counter";
  8000be:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  8000c4:	bb d3 2a 80 00       	mov    $0x802ad3,%ebx
  8000c9:	ba 0f 00 00 00       	mov    $0xf,%edx
  8000ce:	89 c7                	mov    %eax,%edi
  8000d0:	89 de                	mov    %ebx,%esi
  8000d2:	89 d1                	mov    %edx,%ecx
  8000d4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Counter[] = "flightBooked1Counter";
  8000d6:	8d 85 2b ff ff ff    	lea    -0xd5(%ebp),%eax
  8000dc:	bb e2 2a 80 00       	mov    $0x802ae2,%ebx
  8000e1:	ba 15 00 00 00       	mov    $0x15,%edx
  8000e6:	89 c7                	mov    %eax,%edi
  8000e8:	89 de                	mov    %ebx,%esi
  8000ea:	89 d1                	mov    %edx,%ecx
  8000ec:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Counter[] = "flightBooked2Counter";
  8000ee:	8d 85 16 ff ff ff    	lea    -0xea(%ebp),%eax
  8000f4:	bb f7 2a 80 00       	mov    $0x802af7,%ebx
  8000f9:	ba 15 00 00 00       	mov    $0x15,%edx
  8000fe:	89 c7                	mov    %eax,%edi
  800100:	89 de                	mov    %ebx,%esi
  800102:	89 d1                	mov    %edx,%ecx
  800104:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked1Arr[] = "flightBooked1Arr";
  800106:	8d 85 05 ff ff ff    	lea    -0xfb(%ebp),%eax
  80010c:	bb 0c 2b 80 00       	mov    $0x802b0c,%ebx
  800111:	ba 11 00 00 00       	mov    $0x11,%edx
  800116:	89 c7                	mov    %eax,%edi
  800118:	89 de                	mov    %ebx,%esi
  80011a:	89 d1                	mov    %edx,%ecx
  80011c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flightBooked2Arr[] = "flightBooked2Arr";
  80011e:	8d 85 f4 fe ff ff    	lea    -0x10c(%ebp),%eax
  800124:	bb 1d 2b 80 00       	mov    $0x802b1d,%ebx
  800129:	ba 11 00 00 00       	mov    $0x11,%edx
  80012e:	89 c7                	mov    %eax,%edi
  800130:	89 de                	mov    %ebx,%esi
  800132:	89 d1                	mov    %edx,%ecx
  800134:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _cust_ready_queue[] = "cust_ready_queue";
  800136:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80013c:	bb 2e 2b 80 00       	mov    $0x802b2e,%ebx
  800141:	ba 11 00 00 00       	mov    $0x11,%edx
  800146:	89 c7                	mov    %eax,%edi
  800148:	89 de                	mov    %ebx,%esi
  80014a:	89 d1                	mov    %edx,%ecx
  80014c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_in[] = "queue_in";
  80014e:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  800154:	bb 3f 2b 80 00       	mov    $0x802b3f,%ebx
  800159:	ba 09 00 00 00       	mov    $0x9,%edx
  80015e:	89 c7                	mov    %eax,%edi
  800160:	89 de                	mov    %ebx,%esi
  800162:	89 d1                	mov    %edx,%ecx
  800164:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _queue_out[] = "queue_out";
  800166:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
  80016c:	bb 48 2b 80 00       	mov    $0x802b48,%ebx
  800171:	ba 0a 00 00 00       	mov    $0xa,%edx
  800176:	89 c7                	mov    %eax,%edi
  800178:	89 de                	mov    %ebx,%esi
  80017a:	89 d1                	mov    %edx,%ecx
  80017c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _cust_ready[] = "cust_ready";
  80017e:	8d 85 c5 fe ff ff    	lea    -0x13b(%ebp),%eax
  800184:	bb 52 2b 80 00       	mov    $0x802b52,%ebx
  800189:	ba 0b 00 00 00       	mov    $0xb,%edx
  80018e:	89 c7                	mov    %eax,%edi
  800190:	89 de                	mov    %ebx,%esi
  800192:	89 d1                	mov    %edx,%ecx
  800194:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custQueueCS[] = "custQueueCS";
  800196:	8d 85 b9 fe ff ff    	lea    -0x147(%ebp),%eax
  80019c:	bb 5d 2b 80 00       	mov    $0x802b5d,%ebx
  8001a1:	ba 03 00 00 00       	mov    $0x3,%edx
  8001a6:	89 c7                	mov    %eax,%edi
  8001a8:	89 de                	mov    %ebx,%esi
  8001aa:	89 d1                	mov    %edx,%ecx
  8001ac:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	char _flight1CS[] = "flight1CS";
  8001ae:	8d 85 af fe ff ff    	lea    -0x151(%ebp),%eax
  8001b4:	bb 69 2b 80 00       	mov    $0x802b69,%ebx
  8001b9:	ba 0a 00 00 00       	mov    $0xa,%edx
  8001be:	89 c7                	mov    %eax,%edi
  8001c0:	89 de                	mov    %ebx,%esi
  8001c2:	89 d1                	mov    %edx,%ecx
  8001c4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _flight2CS[] = "flight2CS";
  8001c6:	8d 85 a5 fe ff ff    	lea    -0x15b(%ebp),%eax
  8001cc:	bb 73 2b 80 00       	mov    $0x802b73,%ebx
  8001d1:	ba 0a 00 00 00       	mov    $0xa,%edx
  8001d6:	89 c7                	mov    %eax,%edi
  8001d8:	89 de                	mov    %ebx,%esi
  8001da:	89 d1                	mov    %edx,%ecx
  8001dc:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _clerk[] = "clerk";
  8001de:	c7 85 9f fe ff ff 63 	movl   $0x72656c63,-0x161(%ebp)
  8001e5:	6c 65 72 
  8001e8:	66 c7 85 a3 fe ff ff 	movw   $0x6b,-0x15d(%ebp)
  8001ef:	6b 00 
	char _custCounterCS[] = "custCounterCS";
  8001f1:	8d 85 91 fe ff ff    	lea    -0x16f(%ebp),%eax
  8001f7:	bb 7d 2b 80 00       	mov    $0x802b7d,%ebx
  8001fc:	ba 0e 00 00 00       	mov    $0xe,%edx
  800201:	89 c7                	mov    %eax,%edi
  800203:	89 de                	mov    %ebx,%esi
  800205:	89 d1                	mov    %edx,%ecx
  800207:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _custTerminated[] = "custTerminated";
  800209:	8d 85 82 fe ff ff    	lea    -0x17e(%ebp),%eax
  80020f:	bb 8b 2b 80 00       	mov    $0x802b8b,%ebx
  800214:	ba 0f 00 00 00       	mov    $0xf,%edx
  800219:	89 c7                	mov    %eax,%edi
  80021b:	89 de                	mov    %ebx,%esi
  80021d:	89 d1                	mov    %edx,%ecx
  80021f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	char _taircl[] = "taircl";
  800221:	8d 85 7b fe ff ff    	lea    -0x185(%ebp),%eax
  800227:	bb 9a 2b 80 00       	mov    $0x802b9a,%ebx
  80022c:	ba 07 00 00 00       	mov    $0x7,%edx
  800231:	89 c7                	mov    %eax,%edi
  800233:	89 de                	mov    %ebx,%esi
  800235:	89 d1                	mov    %edx,%ecx
  800237:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
	char _taircu[] = "taircu";
  800239:	8d 85 74 fe ff ff    	lea    -0x18c(%ebp),%eax
  80023f:	bb a1 2b 80 00       	mov    $0x802ba1,%ebx
  800244:	ba 07 00 00 00       	mov    $0x7,%edx
  800249:	89 c7                	mov    %eax,%edi
  80024b:	89 de                	mov    %ebx,%esi
  80024d:	89 d1                	mov    %edx,%ecx
  80024f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)

	struct Customer * custs;
	custs = smalloc(_customers, sizeof(struct Customer)*numOfCustomers, 1);
  800251:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800254:	c1 e0 03             	shl    $0x3,%eax
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	6a 01                	push   $0x1
  80025c:	50                   	push   %eax
  80025d:	8d 85 6a ff ff ff    	lea    -0x96(%ebp),%eax
  800263:	50                   	push   %eax
  800264:	e8 d6 19 00 00       	call   801c3f <smalloc>
  800269:	83 c4 10             	add    $0x10,%esp
  80026c:	89 45 a0             	mov    %eax,-0x60(%ebp)
	//sys_createSharedObject("customers", sizeof(struct Customer)*numOfCustomers, 1, (void**)&custs);


	{
		int f1 = 0;
  80026f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for(;f1<flight1Customers; ++f1)
  800276:	eb 2e                	jmp    8002a6 <_main+0x26e>
		{
			custs[f1].booked = 0;
  800278:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800282:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800285:	01 d0                	add    %edx,%eax
  800287:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			custs[f1].flightType = 1;
  80028e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800291:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800298:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80029b:	01 d0                	add    %edx,%eax
  80029d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
	//sys_createSharedObject("customers", sizeof(struct Customer)*numOfCustomers, 1, (void**)&custs);


	{
		int f1 = 0;
		for(;f1<flight1Customers; ++f1)
  8002a3:	ff 45 e4             	incl   -0x1c(%ebp)
  8002a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002a9:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
  8002ac:	7c ca                	jl     800278 <_main+0x240>
		{
			custs[f1].booked = 0;
			custs[f1].flightType = 1;
		}

		int f2=f1;
  8002ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		for(;f2<f1+flight2Customers; ++f2)
  8002b4:	eb 2e                	jmp    8002e4 <_main+0x2ac>
		{
			custs[f2].booked = 0;
  8002b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002c0:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			custs[f2].flightType = 2;
  8002cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002cf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8002d6:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8002d9:	01 d0                	add    %edx,%eax
  8002db:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
			custs[f1].booked = 0;
			custs[f1].flightType = 1;
		}

		int f2=f1;
		for(;f2<f1+flight2Customers; ++f2)
  8002e1:	ff 45 e0             	incl   -0x20(%ebp)
  8002e4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002e7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002ea:	01 d0                	add    %edx,%eax
  8002ec:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002ef:	7f c5                	jg     8002b6 <_main+0x27e>
		{
			custs[f2].booked = 0;
			custs[f2].flightType = 2;
		}

		int f3=f2;
  8002f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002f4:	89 45 dc             	mov    %eax,-0x24(%ebp)
		for(;f3<f2+flight3Customers; ++f3)
  8002f7:	eb 2e                	jmp    800327 <_main+0x2ef>
		{
			custs[f3].booked = 0;
  8002f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002fc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800303:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800306:	01 d0                	add    %edx,%eax
  800308:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
			custs[f3].flightType = 3;
  80030f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800312:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800319:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
			custs[f2].booked = 0;
			custs[f2].flightType = 2;
		}

		int f3=f2;
		for(;f3<f2+flight3Customers; ++f3)
  800324:	ff 45 dc             	incl   -0x24(%ebp)
  800327:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80032a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80032d:	01 d0                	add    %edx,%eax
  80032f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800332:	7f c5                	jg     8002f9 <_main+0x2c1>
			custs[f3].booked = 0;
			custs[f3].flightType = 3;
		}
	}

	int* custCounter = smalloc(_custCounter, sizeof(int), 1);
  800334:	83 ec 04             	sub    $0x4,%esp
  800337:	6a 01                	push   $0x1
  800339:	6a 04                	push   $0x4
  80033b:	8d 85 5e ff ff ff    	lea    -0xa2(%ebp),%eax
  800341:	50                   	push   %eax
  800342:	e8 f8 18 00 00       	call   801c3f <smalloc>
  800347:	83 c4 10             	add    $0x10,%esp
  80034a:	89 45 9c             	mov    %eax,-0x64(%ebp)
	*custCounter = 0;
  80034d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800350:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int* flight1Counter = smalloc(_flight1Counter, sizeof(int), 1);
  800356:	83 ec 04             	sub    $0x4,%esp
  800359:	6a 01                	push   $0x1
  80035b:	6a 04                	push   $0x4
  80035d:	8d 85 4f ff ff ff    	lea    -0xb1(%ebp),%eax
  800363:	50                   	push   %eax
  800364:	e8 d6 18 00 00       	call   801c3f <smalloc>
  800369:	83 c4 10             	add    $0x10,%esp
  80036c:	89 45 98             	mov    %eax,-0x68(%ebp)
	*flight1Counter = flight1NumOfTickets;
  80036f:	8b 45 98             	mov    -0x68(%ebp),%eax
  800372:	8b 55 a8             	mov    -0x58(%ebp),%edx
  800375:	89 10                	mov    %edx,(%eax)

	int* flight2Counter = smalloc(_flight2Counter, sizeof(int), 1);
  800377:	83 ec 04             	sub    $0x4,%esp
  80037a:	6a 01                	push   $0x1
  80037c:	6a 04                	push   $0x4
  80037e:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  800384:	50                   	push   %eax
  800385:	e8 b5 18 00 00       	call   801c3f <smalloc>
  80038a:	83 c4 10             	add    $0x10,%esp
  80038d:	89 45 94             	mov    %eax,-0x6c(%ebp)
	*flight2Counter = flight2NumOfTickets;
  800390:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800393:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  800396:	89 10                	mov    %edx,(%eax)

	int* flight1BookedCounter = smalloc(_flightBooked1Counter, sizeof(int), 1);
  800398:	83 ec 04             	sub    $0x4,%esp
  80039b:	6a 01                	push   $0x1
  80039d:	6a 04                	push   $0x4
  80039f:	8d 85 2b ff ff ff    	lea    -0xd5(%ebp),%eax
  8003a5:	50                   	push   %eax
  8003a6:	e8 94 18 00 00       	call   801c3f <smalloc>
  8003ab:	83 c4 10             	add    $0x10,%esp
  8003ae:	89 45 90             	mov    %eax,-0x70(%ebp)
	*flight1BookedCounter = 0;
  8003b1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int* flight2BookedCounter = smalloc(_flightBooked2Counter, sizeof(int), 1);
  8003ba:	83 ec 04             	sub    $0x4,%esp
  8003bd:	6a 01                	push   $0x1
  8003bf:	6a 04                	push   $0x4
  8003c1:	8d 85 16 ff ff ff    	lea    -0xea(%ebp),%eax
  8003c7:	50                   	push   %eax
  8003c8:	e8 72 18 00 00       	call   801c3f <smalloc>
  8003cd:	83 c4 10             	add    $0x10,%esp
  8003d0:	89 45 8c             	mov    %eax,-0x74(%ebp)
	*flight2BookedCounter = 0;
  8003d3:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8003d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int* flight1BookedArr = smalloc(_flightBooked1Arr, sizeof(int)*flight1NumOfTickets, 1);
  8003dc:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003df:	c1 e0 02             	shl    $0x2,%eax
  8003e2:	83 ec 04             	sub    $0x4,%esp
  8003e5:	6a 01                	push   $0x1
  8003e7:	50                   	push   %eax
  8003e8:	8d 85 05 ff ff ff    	lea    -0xfb(%ebp),%eax
  8003ee:	50                   	push   %eax
  8003ef:	e8 4b 18 00 00       	call   801c3f <smalloc>
  8003f4:	83 c4 10             	add    $0x10,%esp
  8003f7:	89 45 88             	mov    %eax,-0x78(%ebp)
	int* flight2BookedArr = smalloc(_flightBooked2Arr, sizeof(int)*flight2NumOfTickets, 1);
  8003fa:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003fd:	c1 e0 02             	shl    $0x2,%eax
  800400:	83 ec 04             	sub    $0x4,%esp
  800403:	6a 01                	push   $0x1
  800405:	50                   	push   %eax
  800406:	8d 85 f4 fe ff ff    	lea    -0x10c(%ebp),%eax
  80040c:	50                   	push   %eax
  80040d:	e8 2d 18 00 00       	call   801c3f <smalloc>
  800412:	83 c4 10             	add    $0x10,%esp
  800415:	89 45 84             	mov    %eax,-0x7c(%ebp)

	int* cust_ready_queue = smalloc(_cust_ready_queue, sizeof(int)*numOfCustomers, 1);
  800418:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80041b:	c1 e0 02             	shl    $0x2,%eax
  80041e:	83 ec 04             	sub    $0x4,%esp
  800421:	6a 01                	push   $0x1
  800423:	50                   	push   %eax
  800424:	8d 85 e3 fe ff ff    	lea    -0x11d(%ebp),%eax
  80042a:	50                   	push   %eax
  80042b:	e8 0f 18 00 00       	call   801c3f <smalloc>
  800430:	83 c4 10             	add    $0x10,%esp
  800433:	89 45 80             	mov    %eax,-0x80(%ebp)

	int* queue_in = smalloc(_queue_in, sizeof(int), 1);
  800436:	83 ec 04             	sub    $0x4,%esp
  800439:	6a 01                	push   $0x1
  80043b:	6a 04                	push   $0x4
  80043d:	8d 85 da fe ff ff    	lea    -0x126(%ebp),%eax
  800443:	50                   	push   %eax
  800444:	e8 f6 17 00 00       	call   801c3f <smalloc>
  800449:	83 c4 10             	add    $0x10,%esp
  80044c:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
	*queue_in = 0;
  800452:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800458:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	int* queue_out = smalloc(_queue_out, sizeof(int), 1);
  80045e:	83 ec 04             	sub    $0x4,%esp
  800461:	6a 01                	push   $0x1
  800463:	6a 04                	push   $0x4
  800465:	8d 85 d0 fe ff ff    	lea    -0x130(%ebp),%eax
  80046b:	50                   	push   %eax
  80046c:	e8 ce 17 00 00       	call   801c3f <smalloc>
  800471:	83 c4 10             	add    $0x10,%esp
  800474:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
	*queue_out = 0;
  80047a:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	// *************************************************************************************************
	/// Semaphores Region ******************************************************************************
	// *************************************************************************************************
	sys_createSemaphore(_flight1CS, 1);
  800486:	83 ec 08             	sub    $0x8,%esp
  800489:	6a 01                	push   $0x1
  80048b:	8d 85 af fe ff ff    	lea    -0x151(%ebp),%eax
  800491:	50                   	push   %eax
  800492:	e8 e8 1c 00 00       	call   80217f <sys_createSemaphore>
  800497:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore(_flight2CS, 1);
  80049a:	83 ec 08             	sub    $0x8,%esp
  80049d:	6a 01                	push   $0x1
  80049f:	8d 85 a5 fe ff ff    	lea    -0x15b(%ebp),%eax
  8004a5:	50                   	push   %eax
  8004a6:	e8 d4 1c 00 00       	call   80217f <sys_createSemaphore>
  8004ab:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore(_custCounterCS, 1);
  8004ae:	83 ec 08             	sub    $0x8,%esp
  8004b1:	6a 01                	push   $0x1
  8004b3:	8d 85 91 fe ff ff    	lea    -0x16f(%ebp),%eax
  8004b9:	50                   	push   %eax
  8004ba:	e8 c0 1c 00 00       	call   80217f <sys_createSemaphore>
  8004bf:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore(_custQueueCS, 1);
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	6a 01                	push   $0x1
  8004c7:	8d 85 b9 fe ff ff    	lea    -0x147(%ebp),%eax
  8004cd:	50                   	push   %eax
  8004ce:	e8 ac 1c 00 00       	call   80217f <sys_createSemaphore>
  8004d3:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore(_clerk, 3);
  8004d6:	83 ec 08             	sub    $0x8,%esp
  8004d9:	6a 03                	push   $0x3
  8004db:	8d 85 9f fe ff ff    	lea    -0x161(%ebp),%eax
  8004e1:	50                   	push   %eax
  8004e2:	e8 98 1c 00 00       	call   80217f <sys_createSemaphore>
  8004e7:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore(_cust_ready, 0);
  8004ea:	83 ec 08             	sub    $0x8,%esp
  8004ed:	6a 00                	push   $0x0
  8004ef:	8d 85 c5 fe ff ff    	lea    -0x13b(%ebp),%eax
  8004f5:	50                   	push   %eax
  8004f6:	e8 84 1c 00 00       	call   80217f <sys_createSemaphore>
  8004fb:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore(_custTerminated, 0);
  8004fe:	83 ec 08             	sub    $0x8,%esp
  800501:	6a 00                	push   $0x0
  800503:	8d 85 82 fe ff ff    	lea    -0x17e(%ebp),%eax
  800509:	50                   	push   %eax
  80050a:	e8 70 1c 00 00       	call   80217f <sys_createSemaphore>
  80050f:	83 c4 10             	add    $0x10,%esp

	int s=0;
  800512:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
	for(s=0; s<numOfCustomers; ++s)
  800519:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  800520:	eb 78                	jmp    80059a <_main+0x562>
	{
		char prefix[30]="cust_finished";
  800522:	8d 85 56 fe ff ff    	lea    -0x1aa(%ebp),%eax
  800528:	bb a8 2b 80 00       	mov    $0x802ba8,%ebx
  80052d:	ba 0e 00 00 00       	mov    $0xe,%edx
  800532:	89 c7                	mov    %eax,%edi
  800534:	89 de                	mov    %ebx,%esi
  800536:	89 d1                	mov    %edx,%ecx
  800538:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80053a:	8d 95 64 fe ff ff    	lea    -0x19c(%ebp),%edx
  800540:	b9 04 00 00 00       	mov    $0x4,%ecx
  800545:	b8 00 00 00 00       	mov    $0x0,%eax
  80054a:	89 d7                	mov    %edx,%edi
  80054c:	f3 ab                	rep stos %eax,%es:(%edi)
		char id[5]; char sname[50];
		ltostr(s, id);
  80054e:	83 ec 08             	sub    $0x8,%esp
  800551:	8d 85 51 fe ff ff    	lea    -0x1af(%ebp),%eax
  800557:	50                   	push   %eax
  800558:	ff 75 d8             	pushl  -0x28(%ebp)
  80055b:	e8 7d 14 00 00       	call   8019dd <ltostr>
  800560:	83 c4 10             	add    $0x10,%esp
		strcconcat(prefix, id, sname);
  800563:	83 ec 04             	sub    $0x4,%esp
  800566:	8d 85 fc fd ff ff    	lea    -0x204(%ebp),%eax
  80056c:	50                   	push   %eax
  80056d:	8d 85 51 fe ff ff    	lea    -0x1af(%ebp),%eax
  800573:	50                   	push   %eax
  800574:	8d 85 56 fe ff ff    	lea    -0x1aa(%ebp),%eax
  80057a:	50                   	push   %eax
  80057b:	e8 55 15 00 00       	call   801ad5 <strcconcat>
  800580:	83 c4 10             	add    $0x10,%esp
		sys_createSemaphore(sname, 0);
  800583:	83 ec 08             	sub    $0x8,%esp
  800586:	6a 00                	push   $0x0
  800588:	8d 85 fc fd ff ff    	lea    -0x204(%ebp),%eax
  80058e:	50                   	push   %eax
  80058f:	e8 eb 1b 00 00       	call   80217f <sys_createSemaphore>
  800594:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore(_cust_ready, 0);

	sys_createSemaphore(_custTerminated, 0);

	int s=0;
	for(s=0; s<numOfCustomers; ++s)
  800597:	ff 45 d8             	incl   -0x28(%ebp)
  80059a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80059d:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  8005a0:	7c 80                	jl     800522 <_main+0x4ea>
	// start all clerks and customers ******************************************************************
	// *************************************************************************************************

	//3 clerks
	uint32 envId;
	envId = sys_create_env(_taircl, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8005a2:	a1 20 40 80 00       	mov    0x804020,%eax
  8005a7:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8005ad:	a1 20 40 80 00       	mov    0x804020,%eax
  8005b2:	8b 40 74             	mov    0x74(%eax),%eax
  8005b5:	83 ec 04             	sub    $0x4,%esp
  8005b8:	52                   	push   %edx
  8005b9:	50                   	push   %eax
  8005ba:	8d 85 7b fe ff ff    	lea    -0x185(%ebp),%eax
  8005c0:	50                   	push   %eax
  8005c1:	e8 ca 1c 00 00       	call   802290 <sys_create_env>
  8005c6:	83 c4 10             	add    $0x10,%esp
  8005c9:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
	sys_run_env(envId);
  8005cf:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8005d5:	83 ec 0c             	sub    $0xc,%esp
  8005d8:	50                   	push   %eax
  8005d9:	e8 cf 1c 00 00       	call   8022ad <sys_run_env>
  8005de:	83 c4 10             	add    $0x10,%esp

	envId = sys_create_env(_taircl, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  8005e1:	a1 20 40 80 00       	mov    0x804020,%eax
  8005e6:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  8005ec:	a1 20 40 80 00       	mov    0x804020,%eax
  8005f1:	8b 40 74             	mov    0x74(%eax),%eax
  8005f4:	83 ec 04             	sub    $0x4,%esp
  8005f7:	52                   	push   %edx
  8005f8:	50                   	push   %eax
  8005f9:	8d 85 7b fe ff ff    	lea    -0x185(%ebp),%eax
  8005ff:	50                   	push   %eax
  800600:	e8 8b 1c 00 00       	call   802290 <sys_create_env>
  800605:	83 c4 10             	add    $0x10,%esp
  800608:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
	sys_run_env(envId);
  80060e:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800614:	83 ec 0c             	sub    $0xc,%esp
  800617:	50                   	push   %eax
  800618:	e8 90 1c 00 00       	call   8022ad <sys_run_env>
  80061d:	83 c4 10             	add    $0x10,%esp

	envId = sys_create_env(_taircl, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800620:	a1 20 40 80 00       	mov    0x804020,%eax
  800625:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  80062b:	a1 20 40 80 00       	mov    0x804020,%eax
  800630:	8b 40 74             	mov    0x74(%eax),%eax
  800633:	83 ec 04             	sub    $0x4,%esp
  800636:	52                   	push   %edx
  800637:	50                   	push   %eax
  800638:	8d 85 7b fe ff ff    	lea    -0x185(%ebp),%eax
  80063e:	50                   	push   %eax
  80063f:	e8 4c 1c 00 00       	call   802290 <sys_create_env>
  800644:	83 c4 10             	add    $0x10,%esp
  800647:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
	sys_run_env(envId);
  80064d:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800653:	83 ec 0c             	sub    $0xc,%esp
  800656:	50                   	push   %eax
  800657:	e8 51 1c 00 00       	call   8022ad <sys_run_env>
  80065c:	83 c4 10             	add    $0x10,%esp

	//customers
	int c;
	for(c=0; c< numOfCustomers;++c)
  80065f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  800666:	eb 42                	jmp    8006aa <_main+0x672>
	{
		envId = sys_create_env(_taircu, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
  800668:	a1 20 40 80 00       	mov    0x804020,%eax
  80066d:	8b 90 38 03 00 00    	mov    0x338(%eax),%edx
  800673:	a1 20 40 80 00       	mov    0x804020,%eax
  800678:	8b 40 74             	mov    0x74(%eax),%eax
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	52                   	push   %edx
  80067f:	50                   	push   %eax
  800680:	8d 85 74 fe ff ff    	lea    -0x18c(%ebp),%eax
  800686:	50                   	push   %eax
  800687:	e8 04 1c 00 00       	call   802290 <sys_create_env>
  80068c:	83 c4 10             	add    $0x10,%esp
  80068f:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		sys_run_env(envId);
  800695:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	50                   	push   %eax
  80069f:	e8 09 1c 00 00       	call   8022ad <sys_run_env>
  8006a4:	83 c4 10             	add    $0x10,%esp
	envId = sys_create_env(_taircl, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(envId);

	//customers
	int c;
	for(c=0; c< numOfCustomers;++c)
  8006a7:	ff 45 d4             	incl   -0x2c(%ebp)
  8006aa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006ad:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  8006b0:	7c b6                	jl     800668 <_main+0x630>
		envId = sys_create_env(_taircu, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(envId);
	}

	//wait until all customers terminated
	for(c=0; c< numOfCustomers;++c)
  8006b2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8006b9:	eb 18                	jmp    8006d3 <_main+0x69b>
	{
		sys_waitSemaphore(envID, _custTerminated);
  8006bb:	83 ec 08             	sub    $0x8,%esp
  8006be:	8d 85 82 fe ff ff    	lea    -0x17e(%ebp),%eax
  8006c4:	50                   	push   %eax
  8006c5:	ff 75 bc             	pushl  -0x44(%ebp)
  8006c8:	e8 eb 1a 00 00       	call   8021b8 <sys_waitSemaphore>
  8006cd:	83 c4 10             	add    $0x10,%esp
		envId = sys_create_env(_taircu, (myEnv->page_WS_max_size), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(envId);
	}

	//wait until all customers terminated
	for(c=0; c< numOfCustomers;++c)
  8006d0:	ff 45 d4             	incl   -0x2c(%ebp)
  8006d3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006d6:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  8006d9:	7c e0                	jl     8006bb <_main+0x683>
	{
		sys_waitSemaphore(envID, _custTerminated);
	}

	env_sleep(1500);
  8006db:	83 ec 0c             	sub    $0xc,%esp
  8006de:	68 dc 05 00 00       	push   $0x5dc
  8006e3:	e8 01 1e 00 00       	call   8024e9 <env_sleep>
  8006e8:	83 c4 10             	add    $0x10,%esp

	//print out the results
	int b;
	for(b=0; b< (*flight1BookedCounter);++b)
  8006eb:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8006f2:	eb 45                	jmp    800739 <_main+0x701>
	{
		cprintf("cust %d booked flight 1, originally ordered %d\n", flight1BookedArr[b], custs[flight1BookedArr[b]].flightType);
  8006f4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8006f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006fe:	8b 45 88             	mov    -0x78(%ebp),%eax
  800701:	01 d0                	add    %edx,%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80070c:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80070f:	01 d0                	add    %edx,%eax
  800711:	8b 10                	mov    (%eax),%edx
  800713:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800716:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80071d:	8b 45 88             	mov    -0x78(%ebp),%eax
  800720:	01 c8                	add    %ecx,%eax
  800722:	8b 00                	mov    (%eax),%eax
  800724:	83 ec 04             	sub    $0x4,%esp
  800727:	52                   	push   %edx
  800728:	50                   	push   %eax
  800729:	68 20 28 80 00       	push   $0x802820
  80072e:	e8 82 07 00 00       	call   800eb5 <cprintf>
  800733:	83 c4 10             	add    $0x10,%esp

	env_sleep(1500);

	//print out the results
	int b;
	for(b=0; b< (*flight1BookedCounter);++b)
  800736:	ff 45 d0             	incl   -0x30(%ebp)
  800739:	8b 45 90             	mov    -0x70(%ebp),%eax
  80073c:	8b 00                	mov    (%eax),%eax
  80073e:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  800741:	7f b1                	jg     8006f4 <_main+0x6bc>
	{
		cprintf("cust %d booked flight 1, originally ordered %d\n", flight1BookedArr[b], custs[flight1BookedArr[b]].flightType);
	}

	for(b=0; b< (*flight2BookedCounter);++b)
  800743:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  80074a:	eb 45                	jmp    800791 <_main+0x759>
	{
		cprintf("cust %d booked flight 2, originally ordered %d\n", flight2BookedArr[b], custs[flight2BookedArr[b]].flightType);
  80074c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80074f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800756:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800759:	01 d0                	add    %edx,%eax
  80075b:	8b 00                	mov    (%eax),%eax
  80075d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800764:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800767:	01 d0                	add    %edx,%eax
  800769:	8b 10                	mov    (%eax),%edx
  80076b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80076e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800775:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800778:	01 c8                	add    %ecx,%eax
  80077a:	8b 00                	mov    (%eax),%eax
  80077c:	83 ec 04             	sub    $0x4,%esp
  80077f:	52                   	push   %edx
  800780:	50                   	push   %eax
  800781:	68 50 28 80 00       	push   $0x802850
  800786:	e8 2a 07 00 00       	call   800eb5 <cprintf>
  80078b:	83 c4 10             	add    $0x10,%esp
	for(b=0; b< (*flight1BookedCounter);++b)
	{
		cprintf("cust %d booked flight 1, originally ordered %d\n", flight1BookedArr[b], custs[flight1BookedArr[b]].flightType);
	}

	for(b=0; b< (*flight2BookedCounter);++b)
  80078e:	ff 45 d0             	incl   -0x30(%ebp)
  800791:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800794:	8b 00                	mov    (%eax),%eax
  800796:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  800799:	7f b1                	jg     80074c <_main+0x714>
		cprintf("cust %d booked flight 2, originally ordered %d\n", flight2BookedArr[b], custs[flight2BookedArr[b]].flightType);
	}

	//check out the final results and semaphores
	{
		int f1 = 0;
  80079b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
		for(;f1<flight1Customers; ++f1)
  8007a2:	eb 33                	jmp    8007d7 <_main+0x79f>
		{
			if(find(flight1BookedArr, flight1NumOfTickets, f1) != 1)
  8007a4:	83 ec 04             	sub    $0x4,%esp
  8007a7:	ff 75 cc             	pushl  -0x34(%ebp)
  8007aa:	ff 75 a8             	pushl  -0x58(%ebp)
  8007ad:	ff 75 88             	pushl  -0x78(%ebp)
  8007b0:	e8 05 03 00 00       	call   800aba <find>
  8007b5:	83 c4 10             	add    $0x10,%esp
  8007b8:	83 f8 01             	cmp    $0x1,%eax
  8007bb:	74 17                	je     8007d4 <_main+0x79c>
			{
				panic("Error, wrong booking for user %d\n", f1);
  8007bd:	ff 75 cc             	pushl  -0x34(%ebp)
  8007c0:	68 80 28 80 00       	push   $0x802880
  8007c5:	68 b2 00 00 00       	push   $0xb2
  8007ca:	68 a2 28 80 00       	push   $0x8028a2
  8007cf:	e8 2d 04 00 00       	call   800c01 <_panic>
	}

	//check out the final results and semaphores
	{
		int f1 = 0;
		for(;f1<flight1Customers; ++f1)
  8007d4:	ff 45 cc             	incl   -0x34(%ebp)
  8007d7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007da:	3b 45 b4             	cmp    -0x4c(%ebp),%eax
  8007dd:	7c c5                	jl     8007a4 <_main+0x76c>
			{
				panic("Error, wrong booking for user %d\n", f1);
			}
		}

		int f2=f1;
  8007df:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007e2:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(;f2<f1+flight2Customers; ++f2)
  8007e5:	eb 33                	jmp    80081a <_main+0x7e2>
		{
			if(find(flight2BookedArr, flight2NumOfTickets, f2) != 1)
  8007e7:	83 ec 04             	sub    $0x4,%esp
  8007ea:	ff 75 c8             	pushl  -0x38(%ebp)
  8007ed:	ff 75 a4             	pushl  -0x5c(%ebp)
  8007f0:	ff 75 84             	pushl  -0x7c(%ebp)
  8007f3:	e8 c2 02 00 00       	call   800aba <find>
  8007f8:	83 c4 10             	add    $0x10,%esp
  8007fb:	83 f8 01             	cmp    $0x1,%eax
  8007fe:	74 17                	je     800817 <_main+0x7df>
			{
				panic("Error, wrong booking for user %d\n", f2);
  800800:	ff 75 c8             	pushl  -0x38(%ebp)
  800803:	68 80 28 80 00       	push   $0x802880
  800808:	68 bb 00 00 00       	push   $0xbb
  80080d:	68 a2 28 80 00       	push   $0x8028a2
  800812:	e8 ea 03 00 00       	call   800c01 <_panic>
				panic("Error, wrong booking for user %d\n", f1);
			}
		}

		int f2=f1;
		for(;f2<f1+flight2Customers; ++f2)
  800817:	ff 45 c8             	incl   -0x38(%ebp)
  80081a:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80081d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800820:	01 d0                	add    %edx,%eax
  800822:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  800825:	7f c0                	jg     8007e7 <_main+0x7af>
			{
				panic("Error, wrong booking for user %d\n", f2);
			}
		}

		int f3=f2;
  800827:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80082a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		for(;f3<f2+flight3Customers; ++f3)
  80082d:	eb 4c                	jmp    80087b <_main+0x843>
		{
			if(find(flight1BookedArr, flight1NumOfTickets, f3) != 1 || find(flight2BookedArr, flight2NumOfTickets, f3) != 1)
  80082f:	83 ec 04             	sub    $0x4,%esp
  800832:	ff 75 c4             	pushl  -0x3c(%ebp)
  800835:	ff 75 a8             	pushl  -0x58(%ebp)
  800838:	ff 75 88             	pushl  -0x78(%ebp)
  80083b:	e8 7a 02 00 00       	call   800aba <find>
  800840:	83 c4 10             	add    $0x10,%esp
  800843:	83 f8 01             	cmp    $0x1,%eax
  800846:	75 19                	jne    800861 <_main+0x829>
  800848:	83 ec 04             	sub    $0x4,%esp
  80084b:	ff 75 c4             	pushl  -0x3c(%ebp)
  80084e:	ff 75 a4             	pushl  -0x5c(%ebp)
  800851:	ff 75 84             	pushl  -0x7c(%ebp)
  800854:	e8 61 02 00 00       	call   800aba <find>
  800859:	83 c4 10             	add    $0x10,%esp
  80085c:	83 f8 01             	cmp    $0x1,%eax
  80085f:	74 17                	je     800878 <_main+0x840>
			{
				panic("Error, wrong booking for user %d\n", f3);
  800861:	ff 75 c4             	pushl  -0x3c(%ebp)
  800864:	68 80 28 80 00       	push   $0x802880
  800869:	68 c4 00 00 00       	push   $0xc4
  80086e:	68 a2 28 80 00       	push   $0x8028a2
  800873:	e8 89 03 00 00       	call   800c01 <_panic>
				panic("Error, wrong booking for user %d\n", f2);
			}
		}

		int f3=f2;
		for(;f3<f2+flight3Customers; ++f3)
  800878:	ff 45 c4             	incl   -0x3c(%ebp)
  80087b:	8b 55 c8             	mov    -0x38(%ebp),%edx
  80087e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800881:	01 d0                	add    %edx,%eax
  800883:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  800886:	7f a7                	jg     80082f <_main+0x7f7>
			{
				panic("Error, wrong booking for user %d\n", f3);
			}
		}

		assert(sys_getSemaphoreValue(envID, _flight1CS) == 1);
  800888:	83 ec 08             	sub    $0x8,%esp
  80088b:	8d 85 af fe ff ff    	lea    -0x151(%ebp),%eax
  800891:	50                   	push   %eax
  800892:	ff 75 bc             	pushl  -0x44(%ebp)
  800895:	e8 01 19 00 00       	call   80219b <sys_getSemaphoreValue>
  80089a:	83 c4 10             	add    $0x10,%esp
  80089d:	83 f8 01             	cmp    $0x1,%eax
  8008a0:	74 19                	je     8008bb <_main+0x883>
  8008a2:	68 b4 28 80 00       	push   $0x8028b4
  8008a7:	68 e2 28 80 00       	push   $0x8028e2
  8008ac:	68 c8 00 00 00       	push   $0xc8
  8008b1:	68 a2 28 80 00       	push   $0x8028a2
  8008b6:	e8 46 03 00 00       	call   800c01 <_panic>
		assert(sys_getSemaphoreValue(envID, _flight2CS) == 1);
  8008bb:	83 ec 08             	sub    $0x8,%esp
  8008be:	8d 85 a5 fe ff ff    	lea    -0x15b(%ebp),%eax
  8008c4:	50                   	push   %eax
  8008c5:	ff 75 bc             	pushl  -0x44(%ebp)
  8008c8:	e8 ce 18 00 00       	call   80219b <sys_getSemaphoreValue>
  8008cd:	83 c4 10             	add    $0x10,%esp
  8008d0:	83 f8 01             	cmp    $0x1,%eax
  8008d3:	74 19                	je     8008ee <_main+0x8b6>
  8008d5:	68 f8 28 80 00       	push   $0x8028f8
  8008da:	68 e2 28 80 00       	push   $0x8028e2
  8008df:	68 c9 00 00 00       	push   $0xc9
  8008e4:	68 a2 28 80 00       	push   $0x8028a2
  8008e9:	e8 13 03 00 00       	call   800c01 <_panic>

		assert(sys_getSemaphoreValue(envID, _custCounterCS) ==  1);
  8008ee:	83 ec 08             	sub    $0x8,%esp
  8008f1:	8d 85 91 fe ff ff    	lea    -0x16f(%ebp),%eax
  8008f7:	50                   	push   %eax
  8008f8:	ff 75 bc             	pushl  -0x44(%ebp)
  8008fb:	e8 9b 18 00 00       	call   80219b <sys_getSemaphoreValue>
  800900:	83 c4 10             	add    $0x10,%esp
  800903:	83 f8 01             	cmp    $0x1,%eax
  800906:	74 19                	je     800921 <_main+0x8e9>
  800908:	68 28 29 80 00       	push   $0x802928
  80090d:	68 e2 28 80 00       	push   $0x8028e2
  800912:	68 cb 00 00 00       	push   $0xcb
  800917:	68 a2 28 80 00       	push   $0x8028a2
  80091c:	e8 e0 02 00 00       	call   800c01 <_panic>
		assert(sys_getSemaphoreValue(envID, _custQueueCS) ==  1);
  800921:	83 ec 08             	sub    $0x8,%esp
  800924:	8d 85 b9 fe ff ff    	lea    -0x147(%ebp),%eax
  80092a:	50                   	push   %eax
  80092b:	ff 75 bc             	pushl  -0x44(%ebp)
  80092e:	e8 68 18 00 00       	call   80219b <sys_getSemaphoreValue>
  800933:	83 c4 10             	add    $0x10,%esp
  800936:	83 f8 01             	cmp    $0x1,%eax
  800939:	74 19                	je     800954 <_main+0x91c>
  80093b:	68 5c 29 80 00       	push   $0x80295c
  800940:	68 e2 28 80 00       	push   $0x8028e2
  800945:	68 cc 00 00 00       	push   $0xcc
  80094a:	68 a2 28 80 00       	push   $0x8028a2
  80094f:	e8 ad 02 00 00       	call   800c01 <_panic>

		assert(sys_getSemaphoreValue(envID, _clerk) == 3);
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	8d 85 9f fe ff ff    	lea    -0x161(%ebp),%eax
  80095d:	50                   	push   %eax
  80095e:	ff 75 bc             	pushl  -0x44(%ebp)
  800961:	e8 35 18 00 00       	call   80219b <sys_getSemaphoreValue>
  800966:	83 c4 10             	add    $0x10,%esp
  800969:	83 f8 03             	cmp    $0x3,%eax
  80096c:	74 19                	je     800987 <_main+0x94f>
  80096e:	68 8c 29 80 00       	push   $0x80298c
  800973:	68 e2 28 80 00       	push   $0x8028e2
  800978:	68 ce 00 00 00       	push   $0xce
  80097d:	68 a2 28 80 00       	push   $0x8028a2
  800982:	e8 7a 02 00 00       	call   800c01 <_panic>

		assert(sys_getSemaphoreValue(envID, _cust_ready) == -3);
  800987:	83 ec 08             	sub    $0x8,%esp
  80098a:	8d 85 c5 fe ff ff    	lea    -0x13b(%ebp),%eax
  800990:	50                   	push   %eax
  800991:	ff 75 bc             	pushl  -0x44(%ebp)
  800994:	e8 02 18 00 00       	call   80219b <sys_getSemaphoreValue>
  800999:	83 c4 10             	add    $0x10,%esp
  80099c:	83 f8 fd             	cmp    $0xfffffffd,%eax
  80099f:	74 19                	je     8009ba <_main+0x982>
  8009a1:	68 b8 29 80 00       	push   $0x8029b8
  8009a6:	68 e2 28 80 00       	push   $0x8028e2
  8009ab:	68 d0 00 00 00       	push   $0xd0
  8009b0:	68 a2 28 80 00       	push   $0x8028a2
  8009b5:	e8 47 02 00 00       	call   800c01 <_panic>

		assert(sys_getSemaphoreValue(envID, _custTerminated) ==  0);
  8009ba:	83 ec 08             	sub    $0x8,%esp
  8009bd:	8d 85 82 fe ff ff    	lea    -0x17e(%ebp),%eax
  8009c3:	50                   	push   %eax
  8009c4:	ff 75 bc             	pushl  -0x44(%ebp)
  8009c7:	e8 cf 17 00 00       	call   80219b <sys_getSemaphoreValue>
  8009cc:	83 c4 10             	add    $0x10,%esp
  8009cf:	85 c0                	test   %eax,%eax
  8009d1:	74 19                	je     8009ec <_main+0x9b4>
  8009d3:	68 e8 29 80 00       	push   $0x8029e8
  8009d8:	68 e2 28 80 00       	push   $0x8028e2
  8009dd:	68 d2 00 00 00       	push   $0xd2
  8009e2:	68 a2 28 80 00       	push   $0x8028a2
  8009e7:	e8 15 02 00 00       	call   800c01 <_panic>

		int s=0;
  8009ec:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
		for(s=0; s<numOfCustomers; ++s)
  8009f3:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  8009fa:	e9 96 00 00 00       	jmp    800a95 <_main+0xa5d>
		{
			char prefix[30]="cust_finished";
  8009ff:	8d 85 33 fe ff ff    	lea    -0x1cd(%ebp),%eax
  800a05:	bb a8 2b 80 00       	mov    $0x802ba8,%ebx
  800a0a:	ba 0e 00 00 00       	mov    $0xe,%edx
  800a0f:	89 c7                	mov    %eax,%edi
  800a11:	89 de                	mov    %ebx,%esi
  800a13:	89 d1                	mov    %edx,%ecx
  800a15:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  800a17:	8d 95 41 fe ff ff    	lea    -0x1bf(%ebp),%edx
  800a1d:	b9 04 00 00 00       	mov    $0x4,%ecx
  800a22:	b8 00 00 00 00       	mov    $0x0,%eax
  800a27:	89 d7                	mov    %edx,%edi
  800a29:	f3 ab                	rep stos %eax,%es:(%edi)
			char id[5]; char cust_finishedSemaphoreName[50];
			ltostr(s, id);
  800a2b:	83 ec 08             	sub    $0x8,%esp
  800a2e:	8d 85 2e fe ff ff    	lea    -0x1d2(%ebp),%eax
  800a34:	50                   	push   %eax
  800a35:	ff 75 c0             	pushl  -0x40(%ebp)
  800a38:	e8 a0 0f 00 00       	call   8019dd <ltostr>
  800a3d:	83 c4 10             	add    $0x10,%esp
			strcconcat(prefix, id, cust_finishedSemaphoreName);
  800a40:	83 ec 04             	sub    $0x4,%esp
  800a43:	8d 85 fc fd ff ff    	lea    -0x204(%ebp),%eax
  800a49:	50                   	push   %eax
  800a4a:	8d 85 2e fe ff ff    	lea    -0x1d2(%ebp),%eax
  800a50:	50                   	push   %eax
  800a51:	8d 85 33 fe ff ff    	lea    -0x1cd(%ebp),%eax
  800a57:	50                   	push   %eax
  800a58:	e8 78 10 00 00       	call   801ad5 <strcconcat>
  800a5d:	83 c4 10             	add    $0x10,%esp
			assert(sys_getSemaphoreValue(envID, cust_finishedSemaphoreName) ==  0);
  800a60:	83 ec 08             	sub    $0x8,%esp
  800a63:	8d 85 fc fd ff ff    	lea    -0x204(%ebp),%eax
  800a69:	50                   	push   %eax
  800a6a:	ff 75 bc             	pushl  -0x44(%ebp)
  800a6d:	e8 29 17 00 00       	call   80219b <sys_getSemaphoreValue>
  800a72:	83 c4 10             	add    $0x10,%esp
  800a75:	85 c0                	test   %eax,%eax
  800a77:	74 19                	je     800a92 <_main+0xa5a>
  800a79:	68 1c 2a 80 00       	push   $0x802a1c
  800a7e:	68 e2 28 80 00       	push   $0x8028e2
  800a83:	68 db 00 00 00       	push   $0xdb
  800a88:	68 a2 28 80 00       	push   $0x8028a2
  800a8d:	e8 6f 01 00 00       	call   800c01 <_panic>
		assert(sys_getSemaphoreValue(envID, _cust_ready) == -3);

		assert(sys_getSemaphoreValue(envID, _custTerminated) ==  0);

		int s=0;
		for(s=0; s<numOfCustomers; ++s)
  800a92:	ff 45 c0             	incl   -0x40(%ebp)
  800a95:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a98:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  800a9b:	0f 8c 5e ff ff ff    	jl     8009ff <_main+0x9c7>
			ltostr(s, id);
			strcconcat(prefix, id, cust_finishedSemaphoreName);
			assert(sys_getSemaphoreValue(envID, cust_finishedSemaphoreName) ==  0);
		}

		cprintf("Congratulations, All reservations are successfully done... have a nice flight :)\n");
  800aa1:	83 ec 0c             	sub    $0xc,%esp
  800aa4:	68 5c 2a 80 00       	push   $0x802a5c
  800aa9:	e8 07 04 00 00       	call   800eb5 <cprintf>
  800aae:	83 c4 10             	add    $0x10,%esp
	}

}
  800ab1:	90                   	nop
  800ab2:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800ab5:	5b                   	pop    %ebx
  800ab6:	5e                   	pop    %esi
  800ab7:	5f                   	pop    %edi
  800ab8:	5d                   	pop    %ebp
  800ab9:	c3                   	ret    

00800aba <find>:


int find(int* arr, int size, int val)
{
  800aba:	55                   	push   %ebp
  800abb:	89 e5                	mov    %esp,%ebp
  800abd:	83 ec 10             	sub    $0x10,%esp

	int result = 0;
  800ac0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

	int i;
	for(i=0; i<size;++i )
  800ac7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ace:	eb 22                	jmp    800af2 <find+0x38>
	{
		if(arr[i] == val)
  800ad0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ad3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	01 d0                	add    %edx,%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ae4:	75 09                	jne    800aef <find+0x35>
		{
			result = 1;
  800ae6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
			break;
  800aed:	eb 0b                	jmp    800afa <find+0x40>
{

	int result = 0;

	int i;
	for(i=0; i<size;++i )
  800aef:	ff 45 f8             	incl   -0x8(%ebp)
  800af2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800af5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800af8:	7c d6                	jl     800ad0 <find+0x16>
			result = 1;
			break;
		}
	}

	return result;
  800afa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800afd:	c9                   	leave  
  800afe:	c3                   	ret    

00800aff <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
  800b02:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b05:	e8 66 14 00 00       	call   801f70 <sys_getenvindex>
  800b0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b10:	89 d0                	mov    %edx,%eax
  800b12:	01 c0                	add    %eax,%eax
  800b14:	01 d0                	add    %edx,%eax
  800b16:	c1 e0 02             	shl    $0x2,%eax
  800b19:	01 d0                	add    %edx,%eax
  800b1b:	c1 e0 06             	shl    $0x6,%eax
  800b1e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b23:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b28:	a1 20 40 80 00       	mov    0x804020,%eax
  800b2d:	8a 80 f4 02 00 00    	mov    0x2f4(%eax),%al
  800b33:	84 c0                	test   %al,%al
  800b35:	74 0f                	je     800b46 <libmain+0x47>
		binaryname = myEnv->prog_name;
  800b37:	a1 20 40 80 00       	mov    0x804020,%eax
  800b3c:	05 f4 02 00 00       	add    $0x2f4,%eax
  800b41:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800b46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b4a:	7e 0a                	jle    800b56 <libmain+0x57>
		binaryname = argv[0];
  800b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800b56:	83 ec 08             	sub    $0x8,%esp
  800b59:	ff 75 0c             	pushl  0xc(%ebp)
  800b5c:	ff 75 08             	pushl  0x8(%ebp)
  800b5f:	e8 d4 f4 ff ff       	call   800038 <_main>
  800b64:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800b67:	e8 9f 15 00 00       	call   80210b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800b6c:	83 ec 0c             	sub    $0xc,%esp
  800b6f:	68 e0 2b 80 00       	push   $0x802be0
  800b74:	e8 3c 03 00 00       	call   800eb5 <cprintf>
  800b79:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b7c:	a1 20 40 80 00       	mov    0x804020,%eax
  800b81:	8b 90 ec 02 00 00    	mov    0x2ec(%eax),%edx
  800b87:	a1 20 40 80 00       	mov    0x804020,%eax
  800b8c:	8b 80 dc 02 00 00    	mov    0x2dc(%eax),%eax
  800b92:	83 ec 04             	sub    $0x4,%esp
  800b95:	52                   	push   %edx
  800b96:	50                   	push   %eax
  800b97:	68 08 2c 80 00       	push   $0x802c08
  800b9c:	e8 14 03 00 00       	call   800eb5 <cprintf>
  800ba1:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800ba4:	a1 20 40 80 00       	mov    0x804020,%eax
  800ba9:	8b 80 3c 03 00 00    	mov    0x33c(%eax),%eax
  800baf:	83 ec 08             	sub    $0x8,%esp
  800bb2:	50                   	push   %eax
  800bb3:	68 2d 2c 80 00       	push   $0x802c2d
  800bb8:	e8 f8 02 00 00       	call   800eb5 <cprintf>
  800bbd:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800bc0:	83 ec 0c             	sub    $0xc,%esp
  800bc3:	68 e0 2b 80 00       	push   $0x802be0
  800bc8:	e8 e8 02 00 00       	call   800eb5 <cprintf>
  800bcd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800bd0:	e8 50 15 00 00       	call   802125 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800bd5:	e8 19 00 00 00       	call   800bf3 <exit>
}
  800bda:	90                   	nop
  800bdb:	c9                   	leave  
  800bdc:	c3                   	ret    

00800bdd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800bdd:	55                   	push   %ebp
  800bde:	89 e5                	mov    %esp,%ebp
  800be0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800be3:	83 ec 0c             	sub    $0xc,%esp
  800be6:	6a 00                	push   $0x0
  800be8:	e8 4f 13 00 00       	call   801f3c <sys_env_destroy>
  800bed:	83 c4 10             	add    $0x10,%esp
}
  800bf0:	90                   	nop
  800bf1:	c9                   	leave  
  800bf2:	c3                   	ret    

00800bf3 <exit>:

void
exit(void)
{
  800bf3:	55                   	push   %ebp
  800bf4:	89 e5                	mov    %esp,%ebp
  800bf6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800bf9:	e8 a4 13 00 00       	call   801fa2 <sys_env_exit>
}
  800bfe:	90                   	nop
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c07:	8d 45 10             	lea    0x10(%ebp),%eax
  800c0a:	83 c0 04             	add    $0x4,%eax
  800c0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c10:	a1 30 40 80 00       	mov    0x804030,%eax
  800c15:	85 c0                	test   %eax,%eax
  800c17:	74 16                	je     800c2f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c19:	a1 30 40 80 00       	mov    0x804030,%eax
  800c1e:	83 ec 08             	sub    $0x8,%esp
  800c21:	50                   	push   %eax
  800c22:	68 44 2c 80 00       	push   $0x802c44
  800c27:	e8 89 02 00 00       	call   800eb5 <cprintf>
  800c2c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c2f:	a1 00 40 80 00       	mov    0x804000,%eax
  800c34:	ff 75 0c             	pushl  0xc(%ebp)
  800c37:	ff 75 08             	pushl  0x8(%ebp)
  800c3a:	50                   	push   %eax
  800c3b:	68 49 2c 80 00       	push   $0x802c49
  800c40:	e8 70 02 00 00       	call   800eb5 <cprintf>
  800c45:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800c48:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4b:	83 ec 08             	sub    $0x8,%esp
  800c4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c51:	50                   	push   %eax
  800c52:	e8 f3 01 00 00       	call   800e4a <vcprintf>
  800c57:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800c5a:	83 ec 08             	sub    $0x8,%esp
  800c5d:	6a 00                	push   $0x0
  800c5f:	68 65 2c 80 00       	push   $0x802c65
  800c64:	e8 e1 01 00 00       	call   800e4a <vcprintf>
  800c69:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800c6c:	e8 82 ff ff ff       	call   800bf3 <exit>

	// should not return here
	while (1) ;
  800c71:	eb fe                	jmp    800c71 <_panic+0x70>

00800c73 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
  800c76:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800c79:	a1 20 40 80 00       	mov    0x804020,%eax
  800c7e:	8b 50 74             	mov    0x74(%eax),%edx
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	39 c2                	cmp    %eax,%edx
  800c86:	74 14                	je     800c9c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800c88:	83 ec 04             	sub    $0x4,%esp
  800c8b:	68 68 2c 80 00       	push   $0x802c68
  800c90:	6a 26                	push   $0x26
  800c92:	68 b4 2c 80 00       	push   $0x802cb4
  800c97:	e8 65 ff ff ff       	call   800c01 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800c9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800ca3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800caa:	e9 c2 00 00 00       	jmp    800d71 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800caf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cb2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbc:	01 d0                	add    %edx,%eax
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	85 c0                	test   %eax,%eax
  800cc2:	75 08                	jne    800ccc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800cc4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800cc7:	e9 a2 00 00 00       	jmp    800d6e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800ccc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800cd3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800cda:	eb 69                	jmp    800d45 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800cdc:	a1 20 40 80 00       	mov    0x804020,%eax
  800ce1:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800ce7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800cea:	89 d0                	mov    %edx,%eax
  800cec:	01 c0                	add    %eax,%eax
  800cee:	01 d0                	add    %edx,%eax
  800cf0:	c1 e0 02             	shl    $0x2,%eax
  800cf3:	01 c8                	add    %ecx,%eax
  800cf5:	8a 40 04             	mov    0x4(%eax),%al
  800cf8:	84 c0                	test   %al,%al
  800cfa:	75 46                	jne    800d42 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800cfc:	a1 20 40 80 00       	mov    0x804020,%eax
  800d01:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d07:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d0a:	89 d0                	mov    %edx,%eax
  800d0c:	01 c0                	add    %eax,%eax
  800d0e:	01 d0                	add    %edx,%eax
  800d10:	c1 e0 02             	shl    $0x2,%eax
  800d13:	01 c8                	add    %ecx,%eax
  800d15:	8b 00                	mov    (%eax),%eax
  800d17:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d1a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d22:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d24:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d27:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	01 c8                	add    %ecx,%eax
  800d33:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d35:	39 c2                	cmp    %eax,%edx
  800d37:	75 09                	jne    800d42 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800d39:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d40:	eb 12                	jmp    800d54 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d42:	ff 45 e8             	incl   -0x18(%ebp)
  800d45:	a1 20 40 80 00       	mov    0x804020,%eax
  800d4a:	8b 50 74             	mov    0x74(%eax),%edx
  800d4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800d50:	39 c2                	cmp    %eax,%edx
  800d52:	77 88                	ja     800cdc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800d54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d58:	75 14                	jne    800d6e <CheckWSWithoutLastIndex+0xfb>
			panic(
  800d5a:	83 ec 04             	sub    $0x4,%esp
  800d5d:	68 c0 2c 80 00       	push   $0x802cc0
  800d62:	6a 3a                	push   $0x3a
  800d64:	68 b4 2c 80 00       	push   $0x802cb4
  800d69:	e8 93 fe ff ff       	call   800c01 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800d6e:	ff 45 f0             	incl   -0x10(%ebp)
  800d71:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d74:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800d77:	0f 8c 32 ff ff ff    	jl     800caf <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800d7d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d84:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800d8b:	eb 26                	jmp    800db3 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800d8d:	a1 20 40 80 00       	mov    0x804020,%eax
  800d92:	8b 88 34 03 00 00    	mov    0x334(%eax),%ecx
  800d98:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d9b:	89 d0                	mov    %edx,%eax
  800d9d:	01 c0                	add    %eax,%eax
  800d9f:	01 d0                	add    %edx,%eax
  800da1:	c1 e0 02             	shl    $0x2,%eax
  800da4:	01 c8                	add    %ecx,%eax
  800da6:	8a 40 04             	mov    0x4(%eax),%al
  800da9:	3c 01                	cmp    $0x1,%al
  800dab:	75 03                	jne    800db0 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800dad:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800db0:	ff 45 e0             	incl   -0x20(%ebp)
  800db3:	a1 20 40 80 00       	mov    0x804020,%eax
  800db8:	8b 50 74             	mov    0x74(%eax),%edx
  800dbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dbe:	39 c2                	cmp    %eax,%edx
  800dc0:	77 cb                	ja     800d8d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800dc8:	74 14                	je     800dde <CheckWSWithoutLastIndex+0x16b>
		panic(
  800dca:	83 ec 04             	sub    $0x4,%esp
  800dcd:	68 14 2d 80 00       	push   $0x802d14
  800dd2:	6a 44                	push   $0x44
  800dd4:	68 b4 2c 80 00       	push   $0x802cb4
  800dd9:	e8 23 fe ff ff       	call   800c01 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800dde:	90                   	nop
  800ddf:	c9                   	leave  
  800de0:	c3                   	ret    

00800de1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800de1:	55                   	push   %ebp
  800de2:	89 e5                	mov    %esp,%ebp
  800de4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800de7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dea:	8b 00                	mov    (%eax),%eax
  800dec:	8d 48 01             	lea    0x1(%eax),%ecx
  800def:	8b 55 0c             	mov    0xc(%ebp),%edx
  800df2:	89 0a                	mov    %ecx,(%edx)
  800df4:	8b 55 08             	mov    0x8(%ebp),%edx
  800df7:	88 d1                	mov    %dl,%cl
  800df9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dfc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e03:	8b 00                	mov    (%eax),%eax
  800e05:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e0a:	75 2c                	jne    800e38 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e0c:	a0 24 40 80 00       	mov    0x804024,%al
  800e11:	0f b6 c0             	movzbl %al,%eax
  800e14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e17:	8b 12                	mov    (%edx),%edx
  800e19:	89 d1                	mov    %edx,%ecx
  800e1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1e:	83 c2 08             	add    $0x8,%edx
  800e21:	83 ec 04             	sub    $0x4,%esp
  800e24:	50                   	push   %eax
  800e25:	51                   	push   %ecx
  800e26:	52                   	push   %edx
  800e27:	e8 ce 10 00 00       	call   801efa <sys_cputs>
  800e2c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3b:	8b 40 04             	mov    0x4(%eax),%eax
  800e3e:	8d 50 01             	lea    0x1(%eax),%edx
  800e41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e44:	89 50 04             	mov    %edx,0x4(%eax)
}
  800e47:	90                   	nop
  800e48:	c9                   	leave  
  800e49:	c3                   	ret    

00800e4a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800e4a:	55                   	push   %ebp
  800e4b:	89 e5                	mov    %esp,%ebp
  800e4d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800e53:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800e5a:	00 00 00 
	b.cnt = 0;
  800e5d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800e64:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800e67:	ff 75 0c             	pushl  0xc(%ebp)
  800e6a:	ff 75 08             	pushl  0x8(%ebp)
  800e6d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e73:	50                   	push   %eax
  800e74:	68 e1 0d 80 00       	push   $0x800de1
  800e79:	e8 11 02 00 00       	call   80108f <vprintfmt>
  800e7e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800e81:	a0 24 40 80 00       	mov    0x804024,%al
  800e86:	0f b6 c0             	movzbl %al,%eax
  800e89:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800e8f:	83 ec 04             	sub    $0x4,%esp
  800e92:	50                   	push   %eax
  800e93:	52                   	push   %edx
  800e94:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e9a:	83 c0 08             	add    $0x8,%eax
  800e9d:	50                   	push   %eax
  800e9e:	e8 57 10 00 00       	call   801efa <sys_cputs>
  800ea3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ea6:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800ead:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800eb3:	c9                   	leave  
  800eb4:	c3                   	ret    

00800eb5 <cprintf>:

int cprintf(const char *fmt, ...) {
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
  800eb8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ebb:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800ec2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ec5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	83 ec 08             	sub    $0x8,%esp
  800ece:	ff 75 f4             	pushl  -0xc(%ebp)
  800ed1:	50                   	push   %eax
  800ed2:	e8 73 ff ff ff       	call   800e4a <vcprintf>
  800ed7:	83 c4 10             	add    $0x10,%esp
  800eda:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800edd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ee0:	c9                   	leave  
  800ee1:	c3                   	ret    

00800ee2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ee2:	55                   	push   %ebp
  800ee3:	89 e5                	mov    %esp,%ebp
  800ee5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ee8:	e8 1e 12 00 00       	call   80210b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800eed:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ef0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef6:	83 ec 08             	sub    $0x8,%esp
  800ef9:	ff 75 f4             	pushl  -0xc(%ebp)
  800efc:	50                   	push   %eax
  800efd:	e8 48 ff ff ff       	call   800e4a <vcprintf>
  800f02:	83 c4 10             	add    $0x10,%esp
  800f05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f08:	e8 18 12 00 00       	call   802125 <sys_enable_interrupt>
	return cnt;
  800f0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f10:	c9                   	leave  
  800f11:	c3                   	ret    

00800f12 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f12:	55                   	push   %ebp
  800f13:	89 e5                	mov    %esp,%ebp
  800f15:	53                   	push   %ebx
  800f16:	83 ec 14             	sub    $0x14,%esp
  800f19:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f22:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f25:	8b 45 18             	mov    0x18(%ebp),%eax
  800f28:	ba 00 00 00 00       	mov    $0x0,%edx
  800f2d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f30:	77 55                	ja     800f87 <printnum+0x75>
  800f32:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f35:	72 05                	jb     800f3c <printnum+0x2a>
  800f37:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f3a:	77 4b                	ja     800f87 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f3c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f3f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800f42:	8b 45 18             	mov    0x18(%ebp),%eax
  800f45:	ba 00 00 00 00       	mov    $0x0,%edx
  800f4a:	52                   	push   %edx
  800f4b:	50                   	push   %eax
  800f4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f4f:	ff 75 f0             	pushl  -0x10(%ebp)
  800f52:	e8 49 16 00 00       	call   8025a0 <__udivdi3>
  800f57:	83 c4 10             	add    $0x10,%esp
  800f5a:	83 ec 04             	sub    $0x4,%esp
  800f5d:	ff 75 20             	pushl  0x20(%ebp)
  800f60:	53                   	push   %ebx
  800f61:	ff 75 18             	pushl  0x18(%ebp)
  800f64:	52                   	push   %edx
  800f65:	50                   	push   %eax
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	ff 75 08             	pushl  0x8(%ebp)
  800f6c:	e8 a1 ff ff ff       	call   800f12 <printnum>
  800f71:	83 c4 20             	add    $0x20,%esp
  800f74:	eb 1a                	jmp    800f90 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	ff 75 20             	pushl  0x20(%ebp)
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	ff d0                	call   *%eax
  800f84:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800f87:	ff 4d 1c             	decl   0x1c(%ebp)
  800f8a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800f8e:	7f e6                	jg     800f76 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800f90:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800f93:	bb 00 00 00 00       	mov    $0x0,%ebx
  800f98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f9b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f9e:	53                   	push   %ebx
  800f9f:	51                   	push   %ecx
  800fa0:	52                   	push   %edx
  800fa1:	50                   	push   %eax
  800fa2:	e8 09 17 00 00       	call   8026b0 <__umoddi3>
  800fa7:	83 c4 10             	add    $0x10,%esp
  800faa:	05 74 2f 80 00       	add    $0x802f74,%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	0f be c0             	movsbl %al,%eax
  800fb4:	83 ec 08             	sub    $0x8,%esp
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	50                   	push   %eax
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	ff d0                	call   *%eax
  800fc0:	83 c4 10             	add    $0x10,%esp
}
  800fc3:	90                   	nop
  800fc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800fc7:	c9                   	leave  
  800fc8:	c3                   	ret    

00800fc9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800fc9:	55                   	push   %ebp
  800fca:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800fcc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800fd0:	7e 1c                	jle    800fee <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd5:	8b 00                	mov    (%eax),%eax
  800fd7:	8d 50 08             	lea    0x8(%eax),%edx
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	89 10                	mov    %edx,(%eax)
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	8b 00                	mov    (%eax),%eax
  800fe4:	83 e8 08             	sub    $0x8,%eax
  800fe7:	8b 50 04             	mov    0x4(%eax),%edx
  800fea:	8b 00                	mov    (%eax),%eax
  800fec:	eb 40                	jmp    80102e <getuint+0x65>
	else if (lflag)
  800fee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff2:	74 1e                	je     801012 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	8b 00                	mov    (%eax),%eax
  800ff9:	8d 50 04             	lea    0x4(%eax),%edx
  800ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fff:	89 10                	mov    %edx,(%eax)
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8b 00                	mov    (%eax),%eax
  801006:	83 e8 04             	sub    $0x4,%eax
  801009:	8b 00                	mov    (%eax),%eax
  80100b:	ba 00 00 00 00       	mov    $0x0,%edx
  801010:	eb 1c                	jmp    80102e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8b 00                	mov    (%eax),%eax
  801017:	8d 50 04             	lea    0x4(%eax),%edx
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	89 10                	mov    %edx,(%eax)
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8b 00                	mov    (%eax),%eax
  801024:	83 e8 04             	sub    $0x4,%eax
  801027:	8b 00                	mov    (%eax),%eax
  801029:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80102e:	5d                   	pop    %ebp
  80102f:	c3                   	ret    

00801030 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801033:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801037:	7e 1c                	jle    801055 <getint+0x25>
		return va_arg(*ap, long long);
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
  80103c:	8b 00                	mov    (%eax),%eax
  80103e:	8d 50 08             	lea    0x8(%eax),%edx
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	89 10                	mov    %edx,(%eax)
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8b 00                	mov    (%eax),%eax
  80104b:	83 e8 08             	sub    $0x8,%eax
  80104e:	8b 50 04             	mov    0x4(%eax),%edx
  801051:	8b 00                	mov    (%eax),%eax
  801053:	eb 38                	jmp    80108d <getint+0x5d>
	else if (lflag)
  801055:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801059:	74 1a                	je     801075 <getint+0x45>
		return va_arg(*ap, long);
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	8b 00                	mov    (%eax),%eax
  801060:	8d 50 04             	lea    0x4(%eax),%edx
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	89 10                	mov    %edx,(%eax)
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8b 00                	mov    (%eax),%eax
  80106d:	83 e8 04             	sub    $0x4,%eax
  801070:	8b 00                	mov    (%eax),%eax
  801072:	99                   	cltd   
  801073:	eb 18                	jmp    80108d <getint+0x5d>
	else
		return va_arg(*ap, int);
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8b 00                	mov    (%eax),%eax
  80107a:	8d 50 04             	lea    0x4(%eax),%edx
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
  801080:	89 10                	mov    %edx,(%eax)
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	8b 00                	mov    (%eax),%eax
  801087:	83 e8 04             	sub    $0x4,%eax
  80108a:	8b 00                	mov    (%eax),%eax
  80108c:	99                   	cltd   
}
  80108d:	5d                   	pop    %ebp
  80108e:	c3                   	ret    

0080108f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80108f:	55                   	push   %ebp
  801090:	89 e5                	mov    %esp,%ebp
  801092:	56                   	push   %esi
  801093:	53                   	push   %ebx
  801094:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801097:	eb 17                	jmp    8010b0 <vprintfmt+0x21>
			if (ch == '\0')
  801099:	85 db                	test   %ebx,%ebx
  80109b:	0f 84 af 03 00 00    	je     801450 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8010a1:	83 ec 08             	sub    $0x8,%esp
  8010a4:	ff 75 0c             	pushl  0xc(%ebp)
  8010a7:	53                   	push   %ebx
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ab:	ff d0                	call   *%eax
  8010ad:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b3:	8d 50 01             	lea    0x1(%eax),%edx
  8010b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b9:	8a 00                	mov    (%eax),%al
  8010bb:	0f b6 d8             	movzbl %al,%ebx
  8010be:	83 fb 25             	cmp    $0x25,%ebx
  8010c1:	75 d6                	jne    801099 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8010c3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8010c7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8010ce:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8010d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8010dc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8010e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e6:	8d 50 01             	lea    0x1(%eax),%edx
  8010e9:	89 55 10             	mov    %edx,0x10(%ebp)
  8010ec:	8a 00                	mov    (%eax),%al
  8010ee:	0f b6 d8             	movzbl %al,%ebx
  8010f1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8010f4:	83 f8 55             	cmp    $0x55,%eax
  8010f7:	0f 87 2b 03 00 00    	ja     801428 <vprintfmt+0x399>
  8010fd:	8b 04 85 98 2f 80 00 	mov    0x802f98(,%eax,4),%eax
  801104:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801106:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80110a:	eb d7                	jmp    8010e3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80110c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801110:	eb d1                	jmp    8010e3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801112:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801119:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80111c:	89 d0                	mov    %edx,%eax
  80111e:	c1 e0 02             	shl    $0x2,%eax
  801121:	01 d0                	add    %edx,%eax
  801123:	01 c0                	add    %eax,%eax
  801125:	01 d8                	add    %ebx,%eax
  801127:	83 e8 30             	sub    $0x30,%eax
  80112a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80112d:	8b 45 10             	mov    0x10(%ebp),%eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801135:	83 fb 2f             	cmp    $0x2f,%ebx
  801138:	7e 3e                	jle    801178 <vprintfmt+0xe9>
  80113a:	83 fb 39             	cmp    $0x39,%ebx
  80113d:	7f 39                	jg     801178 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80113f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801142:	eb d5                	jmp    801119 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801144:	8b 45 14             	mov    0x14(%ebp),%eax
  801147:	83 c0 04             	add    $0x4,%eax
  80114a:	89 45 14             	mov    %eax,0x14(%ebp)
  80114d:	8b 45 14             	mov    0x14(%ebp),%eax
  801150:	83 e8 04             	sub    $0x4,%eax
  801153:	8b 00                	mov    (%eax),%eax
  801155:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801158:	eb 1f                	jmp    801179 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80115a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80115e:	79 83                	jns    8010e3 <vprintfmt+0x54>
				width = 0;
  801160:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801167:	e9 77 ff ff ff       	jmp    8010e3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80116c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801173:	e9 6b ff ff ff       	jmp    8010e3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801178:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801179:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80117d:	0f 89 60 ff ff ff    	jns    8010e3 <vprintfmt+0x54>
				width = precision, precision = -1;
  801183:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801186:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801189:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801190:	e9 4e ff ff ff       	jmp    8010e3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801195:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801198:	e9 46 ff ff ff       	jmp    8010e3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80119d:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a0:	83 c0 04             	add    $0x4,%eax
  8011a3:	89 45 14             	mov    %eax,0x14(%ebp)
  8011a6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a9:	83 e8 04             	sub    $0x4,%eax
  8011ac:	8b 00                	mov    (%eax),%eax
  8011ae:	83 ec 08             	sub    $0x8,%esp
  8011b1:	ff 75 0c             	pushl  0xc(%ebp)
  8011b4:	50                   	push   %eax
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	ff d0                	call   *%eax
  8011ba:	83 c4 10             	add    $0x10,%esp
			break;
  8011bd:	e9 89 02 00 00       	jmp    80144b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8011c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c5:	83 c0 04             	add    $0x4,%eax
  8011c8:	89 45 14             	mov    %eax,0x14(%ebp)
  8011cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ce:	83 e8 04             	sub    $0x4,%eax
  8011d1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8011d3:	85 db                	test   %ebx,%ebx
  8011d5:	79 02                	jns    8011d9 <vprintfmt+0x14a>
				err = -err;
  8011d7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8011d9:	83 fb 64             	cmp    $0x64,%ebx
  8011dc:	7f 0b                	jg     8011e9 <vprintfmt+0x15a>
  8011de:	8b 34 9d e0 2d 80 00 	mov    0x802de0(,%ebx,4),%esi
  8011e5:	85 f6                	test   %esi,%esi
  8011e7:	75 19                	jne    801202 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8011e9:	53                   	push   %ebx
  8011ea:	68 85 2f 80 00       	push   $0x802f85
  8011ef:	ff 75 0c             	pushl  0xc(%ebp)
  8011f2:	ff 75 08             	pushl  0x8(%ebp)
  8011f5:	e8 5e 02 00 00       	call   801458 <printfmt>
  8011fa:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8011fd:	e9 49 02 00 00       	jmp    80144b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801202:	56                   	push   %esi
  801203:	68 8e 2f 80 00       	push   $0x802f8e
  801208:	ff 75 0c             	pushl  0xc(%ebp)
  80120b:	ff 75 08             	pushl  0x8(%ebp)
  80120e:	e8 45 02 00 00       	call   801458 <printfmt>
  801213:	83 c4 10             	add    $0x10,%esp
			break;
  801216:	e9 30 02 00 00       	jmp    80144b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80121b:	8b 45 14             	mov    0x14(%ebp),%eax
  80121e:	83 c0 04             	add    $0x4,%eax
  801221:	89 45 14             	mov    %eax,0x14(%ebp)
  801224:	8b 45 14             	mov    0x14(%ebp),%eax
  801227:	83 e8 04             	sub    $0x4,%eax
  80122a:	8b 30                	mov    (%eax),%esi
  80122c:	85 f6                	test   %esi,%esi
  80122e:	75 05                	jne    801235 <vprintfmt+0x1a6>
				p = "(null)";
  801230:	be 91 2f 80 00       	mov    $0x802f91,%esi
			if (width > 0 && padc != '-')
  801235:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801239:	7e 6d                	jle    8012a8 <vprintfmt+0x219>
  80123b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80123f:	74 67                	je     8012a8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801241:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801244:	83 ec 08             	sub    $0x8,%esp
  801247:	50                   	push   %eax
  801248:	56                   	push   %esi
  801249:	e8 0c 03 00 00       	call   80155a <strnlen>
  80124e:	83 c4 10             	add    $0x10,%esp
  801251:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801254:	eb 16                	jmp    80126c <vprintfmt+0x1dd>
					putch(padc, putdat);
  801256:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80125a:	83 ec 08             	sub    $0x8,%esp
  80125d:	ff 75 0c             	pushl  0xc(%ebp)
  801260:	50                   	push   %eax
  801261:	8b 45 08             	mov    0x8(%ebp),%eax
  801264:	ff d0                	call   *%eax
  801266:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801269:	ff 4d e4             	decl   -0x1c(%ebp)
  80126c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801270:	7f e4                	jg     801256 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801272:	eb 34                	jmp    8012a8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801274:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801278:	74 1c                	je     801296 <vprintfmt+0x207>
  80127a:	83 fb 1f             	cmp    $0x1f,%ebx
  80127d:	7e 05                	jle    801284 <vprintfmt+0x1f5>
  80127f:	83 fb 7e             	cmp    $0x7e,%ebx
  801282:	7e 12                	jle    801296 <vprintfmt+0x207>
					putch('?', putdat);
  801284:	83 ec 08             	sub    $0x8,%esp
  801287:	ff 75 0c             	pushl  0xc(%ebp)
  80128a:	6a 3f                	push   $0x3f
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	ff d0                	call   *%eax
  801291:	83 c4 10             	add    $0x10,%esp
  801294:	eb 0f                	jmp    8012a5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801296:	83 ec 08             	sub    $0x8,%esp
  801299:	ff 75 0c             	pushl  0xc(%ebp)
  80129c:	53                   	push   %ebx
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	ff d0                	call   *%eax
  8012a2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012a5:	ff 4d e4             	decl   -0x1c(%ebp)
  8012a8:	89 f0                	mov    %esi,%eax
  8012aa:	8d 70 01             	lea    0x1(%eax),%esi
  8012ad:	8a 00                	mov    (%eax),%al
  8012af:	0f be d8             	movsbl %al,%ebx
  8012b2:	85 db                	test   %ebx,%ebx
  8012b4:	74 24                	je     8012da <vprintfmt+0x24b>
  8012b6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012ba:	78 b8                	js     801274 <vprintfmt+0x1e5>
  8012bc:	ff 4d e0             	decl   -0x20(%ebp)
  8012bf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012c3:	79 af                	jns    801274 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012c5:	eb 13                	jmp    8012da <vprintfmt+0x24b>
				putch(' ', putdat);
  8012c7:	83 ec 08             	sub    $0x8,%esp
  8012ca:	ff 75 0c             	pushl  0xc(%ebp)
  8012cd:	6a 20                	push   $0x20
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	ff d0                	call   *%eax
  8012d4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012d7:	ff 4d e4             	decl   -0x1c(%ebp)
  8012da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012de:	7f e7                	jg     8012c7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8012e0:	e9 66 01 00 00       	jmp    80144b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8012e5:	83 ec 08             	sub    $0x8,%esp
  8012e8:	ff 75 e8             	pushl  -0x18(%ebp)
  8012eb:	8d 45 14             	lea    0x14(%ebp),%eax
  8012ee:	50                   	push   %eax
  8012ef:	e8 3c fd ff ff       	call   801030 <getint>
  8012f4:	83 c4 10             	add    $0x10,%esp
  8012f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8012fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8012fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801300:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801303:	85 d2                	test   %edx,%edx
  801305:	79 23                	jns    80132a <vprintfmt+0x29b>
				putch('-', putdat);
  801307:	83 ec 08             	sub    $0x8,%esp
  80130a:	ff 75 0c             	pushl  0xc(%ebp)
  80130d:	6a 2d                	push   $0x2d
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	ff d0                	call   *%eax
  801314:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801317:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80131a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131d:	f7 d8                	neg    %eax
  80131f:	83 d2 00             	adc    $0x0,%edx
  801322:	f7 da                	neg    %edx
  801324:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801327:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80132a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801331:	e9 bc 00 00 00       	jmp    8013f2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801336:	83 ec 08             	sub    $0x8,%esp
  801339:	ff 75 e8             	pushl  -0x18(%ebp)
  80133c:	8d 45 14             	lea    0x14(%ebp),%eax
  80133f:	50                   	push   %eax
  801340:	e8 84 fc ff ff       	call   800fc9 <getuint>
  801345:	83 c4 10             	add    $0x10,%esp
  801348:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80134b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80134e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801355:	e9 98 00 00 00       	jmp    8013f2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80135a:	83 ec 08             	sub    $0x8,%esp
  80135d:	ff 75 0c             	pushl  0xc(%ebp)
  801360:	6a 58                	push   $0x58
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	ff d0                	call   *%eax
  801367:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80136a:	83 ec 08             	sub    $0x8,%esp
  80136d:	ff 75 0c             	pushl  0xc(%ebp)
  801370:	6a 58                	push   $0x58
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	ff d0                	call   *%eax
  801377:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80137a:	83 ec 08             	sub    $0x8,%esp
  80137d:	ff 75 0c             	pushl  0xc(%ebp)
  801380:	6a 58                	push   $0x58
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	ff d0                	call   *%eax
  801387:	83 c4 10             	add    $0x10,%esp
			break;
  80138a:	e9 bc 00 00 00       	jmp    80144b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80138f:	83 ec 08             	sub    $0x8,%esp
  801392:	ff 75 0c             	pushl  0xc(%ebp)
  801395:	6a 30                	push   $0x30
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	ff d0                	call   *%eax
  80139c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80139f:	83 ec 08             	sub    $0x8,%esp
  8013a2:	ff 75 0c             	pushl  0xc(%ebp)
  8013a5:	6a 78                	push   $0x78
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	ff d0                	call   *%eax
  8013ac:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8013af:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b2:	83 c0 04             	add    $0x4,%eax
  8013b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8013b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013bb:	83 e8 04             	sub    $0x4,%eax
  8013be:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8013c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8013ca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8013d1:	eb 1f                	jmp    8013f2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8013d3:	83 ec 08             	sub    $0x8,%esp
  8013d6:	ff 75 e8             	pushl  -0x18(%ebp)
  8013d9:	8d 45 14             	lea    0x14(%ebp),%eax
  8013dc:	50                   	push   %eax
  8013dd:	e8 e7 fb ff ff       	call   800fc9 <getuint>
  8013e2:	83 c4 10             	add    $0x10,%esp
  8013e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8013eb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8013f2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8013f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8013f9:	83 ec 04             	sub    $0x4,%esp
  8013fc:	52                   	push   %edx
  8013fd:	ff 75 e4             	pushl  -0x1c(%ebp)
  801400:	50                   	push   %eax
  801401:	ff 75 f4             	pushl  -0xc(%ebp)
  801404:	ff 75 f0             	pushl  -0x10(%ebp)
  801407:	ff 75 0c             	pushl  0xc(%ebp)
  80140a:	ff 75 08             	pushl  0x8(%ebp)
  80140d:	e8 00 fb ff ff       	call   800f12 <printnum>
  801412:	83 c4 20             	add    $0x20,%esp
			break;
  801415:	eb 34                	jmp    80144b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801417:	83 ec 08             	sub    $0x8,%esp
  80141a:	ff 75 0c             	pushl  0xc(%ebp)
  80141d:	53                   	push   %ebx
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	ff d0                	call   *%eax
  801423:	83 c4 10             	add    $0x10,%esp
			break;
  801426:	eb 23                	jmp    80144b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801428:	83 ec 08             	sub    $0x8,%esp
  80142b:	ff 75 0c             	pushl  0xc(%ebp)
  80142e:	6a 25                	push   $0x25
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	ff d0                	call   *%eax
  801435:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801438:	ff 4d 10             	decl   0x10(%ebp)
  80143b:	eb 03                	jmp    801440 <vprintfmt+0x3b1>
  80143d:	ff 4d 10             	decl   0x10(%ebp)
  801440:	8b 45 10             	mov    0x10(%ebp),%eax
  801443:	48                   	dec    %eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	3c 25                	cmp    $0x25,%al
  801448:	75 f3                	jne    80143d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80144a:	90                   	nop
		}
	}
  80144b:	e9 47 fc ff ff       	jmp    801097 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801450:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801451:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801454:	5b                   	pop    %ebx
  801455:	5e                   	pop    %esi
  801456:	5d                   	pop    %ebp
  801457:	c3                   	ret    

00801458 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801458:	55                   	push   %ebp
  801459:	89 e5                	mov    %esp,%ebp
  80145b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80145e:	8d 45 10             	lea    0x10(%ebp),%eax
  801461:	83 c0 04             	add    $0x4,%eax
  801464:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801467:	8b 45 10             	mov    0x10(%ebp),%eax
  80146a:	ff 75 f4             	pushl  -0xc(%ebp)
  80146d:	50                   	push   %eax
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	ff 75 08             	pushl  0x8(%ebp)
  801474:	e8 16 fc ff ff       	call   80108f <vprintfmt>
  801479:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80147c:	90                   	nop
  80147d:	c9                   	leave  
  80147e:	c3                   	ret    

0080147f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801482:	8b 45 0c             	mov    0xc(%ebp),%eax
  801485:	8b 40 08             	mov    0x8(%eax),%eax
  801488:	8d 50 01             	lea    0x1(%eax),%edx
  80148b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801491:	8b 45 0c             	mov    0xc(%ebp),%eax
  801494:	8b 10                	mov    (%eax),%edx
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	8b 40 04             	mov    0x4(%eax),%eax
  80149c:	39 c2                	cmp    %eax,%edx
  80149e:	73 12                	jae    8014b2 <sprintputch+0x33>
		*b->buf++ = ch;
  8014a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a3:	8b 00                	mov    (%eax),%eax
  8014a5:	8d 48 01             	lea    0x1(%eax),%ecx
  8014a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ab:	89 0a                	mov    %ecx,(%edx)
  8014ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8014b0:	88 10                	mov    %dl,(%eax)
}
  8014b2:	90                   	nop
  8014b3:	5d                   	pop    %ebp
  8014b4:	c3                   	ret    

008014b5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	01 d0                	add    %edx,%eax
  8014cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8014d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014da:	74 06                	je     8014e2 <vsnprintf+0x2d>
  8014dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014e0:	7f 07                	jg     8014e9 <vsnprintf+0x34>
		return -E_INVAL;
  8014e2:	b8 03 00 00 00       	mov    $0x3,%eax
  8014e7:	eb 20                	jmp    801509 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8014e9:	ff 75 14             	pushl  0x14(%ebp)
  8014ec:	ff 75 10             	pushl  0x10(%ebp)
  8014ef:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8014f2:	50                   	push   %eax
  8014f3:	68 7f 14 80 00       	push   $0x80147f
  8014f8:	e8 92 fb ff ff       	call   80108f <vprintfmt>
  8014fd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801500:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801503:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801506:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
  80150e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801511:	8d 45 10             	lea    0x10(%ebp),%eax
  801514:	83 c0 04             	add    $0x4,%eax
  801517:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80151a:	8b 45 10             	mov    0x10(%ebp),%eax
  80151d:	ff 75 f4             	pushl  -0xc(%ebp)
  801520:	50                   	push   %eax
  801521:	ff 75 0c             	pushl  0xc(%ebp)
  801524:	ff 75 08             	pushl  0x8(%ebp)
  801527:	e8 89 ff ff ff       	call   8014b5 <vsnprintf>
  80152c:	83 c4 10             	add    $0x10,%esp
  80152f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801532:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801535:	c9                   	leave  
  801536:	c3                   	ret    

00801537 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801537:	55                   	push   %ebp
  801538:	89 e5                	mov    %esp,%ebp
  80153a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80153d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801544:	eb 06                	jmp    80154c <strlen+0x15>
		n++;
  801546:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801549:	ff 45 08             	incl   0x8(%ebp)
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	8a 00                	mov    (%eax),%al
  801551:	84 c0                	test   %al,%al
  801553:	75 f1                	jne    801546 <strlen+0xf>
		n++;
	return n;
  801555:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801558:	c9                   	leave  
  801559:	c3                   	ret    

0080155a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80155a:	55                   	push   %ebp
  80155b:	89 e5                	mov    %esp,%ebp
  80155d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801560:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801567:	eb 09                	jmp    801572 <strnlen+0x18>
		n++;
  801569:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80156c:	ff 45 08             	incl   0x8(%ebp)
  80156f:	ff 4d 0c             	decl   0xc(%ebp)
  801572:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801576:	74 09                	je     801581 <strnlen+0x27>
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	84 c0                	test   %al,%al
  80157f:	75 e8                	jne    801569 <strnlen+0xf>
		n++;
	return n;
  801581:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801592:	90                   	nop
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	8d 50 01             	lea    0x1(%eax),%edx
  801599:	89 55 08             	mov    %edx,0x8(%ebp)
  80159c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159f:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015a5:	8a 12                	mov    (%edx),%dl
  8015a7:	88 10                	mov    %dl,(%eax)
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	84 c0                	test   %al,%al
  8015ad:	75 e4                	jne    801593 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015af:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
  8015b7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c7:	eb 1f                	jmp    8015e8 <strncpy+0x34>
		*dst++ = *src;
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	8d 50 01             	lea    0x1(%eax),%edx
  8015cf:	89 55 08             	mov    %edx,0x8(%ebp)
  8015d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d5:	8a 12                	mov    (%edx),%dl
  8015d7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015dc:	8a 00                	mov    (%eax),%al
  8015de:	84 c0                	test   %al,%al
  8015e0:	74 03                	je     8015e5 <strncpy+0x31>
			src++;
  8015e2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8015e5:	ff 45 fc             	incl   -0x4(%ebp)
  8015e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015eb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8015ee:	72 d9                	jb     8015c9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8015f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
  8015f8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801601:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801605:	74 30                	je     801637 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801607:	eb 16                	jmp    80161f <strlcpy+0x2a>
			*dst++ = *src++;
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8d 50 01             	lea    0x1(%eax),%edx
  80160f:	89 55 08             	mov    %edx,0x8(%ebp)
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8d 4a 01             	lea    0x1(%edx),%ecx
  801618:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80161b:	8a 12                	mov    (%edx),%dl
  80161d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80161f:	ff 4d 10             	decl   0x10(%ebp)
  801622:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801626:	74 09                	je     801631 <strlcpy+0x3c>
  801628:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	84 c0                	test   %al,%al
  80162f:	75 d8                	jne    801609 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
  801634:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801637:	8b 55 08             	mov    0x8(%ebp),%edx
  80163a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80163d:	29 c2                	sub    %eax,%edx
  80163f:	89 d0                	mov    %edx,%eax
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801646:	eb 06                	jmp    80164e <strcmp+0xb>
		p++, q++;
  801648:	ff 45 08             	incl   0x8(%ebp)
  80164b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	84 c0                	test   %al,%al
  801655:	74 0e                	je     801665 <strcmp+0x22>
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 10                	mov    (%eax),%dl
  80165c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165f:	8a 00                	mov    (%eax),%al
  801661:	38 c2                	cmp    %al,%dl
  801663:	74 e3                	je     801648 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	0f b6 d0             	movzbl %al,%edx
  80166d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	0f b6 c0             	movzbl %al,%eax
  801675:	29 c2                	sub    %eax,%edx
  801677:	89 d0                	mov    %edx,%eax
}
  801679:	5d                   	pop    %ebp
  80167a:	c3                   	ret    

0080167b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80167e:	eb 09                	jmp    801689 <strncmp+0xe>
		n--, p++, q++;
  801680:	ff 4d 10             	decl   0x10(%ebp)
  801683:	ff 45 08             	incl   0x8(%ebp)
  801686:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801689:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80168d:	74 17                	je     8016a6 <strncmp+0x2b>
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	84 c0                	test   %al,%al
  801696:	74 0e                	je     8016a6 <strncmp+0x2b>
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 10                	mov    (%eax),%dl
  80169d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	38 c2                	cmp    %al,%dl
  8016a4:	74 da                	je     801680 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8016a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016aa:	75 07                	jne    8016b3 <strncmp+0x38>
		return 0;
  8016ac:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b1:	eb 14                	jmp    8016c7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	8a 00                	mov    (%eax),%al
  8016b8:	0f b6 d0             	movzbl %al,%edx
  8016bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	0f b6 c0             	movzbl %al,%eax
  8016c3:	29 c2                	sub    %eax,%edx
  8016c5:	89 d0                	mov    %edx,%eax
}
  8016c7:	5d                   	pop    %ebp
  8016c8:	c3                   	ret    

008016c9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 04             	sub    $0x4,%esp
  8016cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016d5:	eb 12                	jmp    8016e9 <strchr+0x20>
		if (*s == c)
  8016d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016da:	8a 00                	mov    (%eax),%al
  8016dc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8016df:	75 05                	jne    8016e6 <strchr+0x1d>
			return (char *) s;
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	eb 11                	jmp    8016f7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8016e6:	ff 45 08             	incl   0x8(%ebp)
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	84 c0                	test   %al,%al
  8016f0:	75 e5                	jne    8016d7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8016f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016f7:	c9                   	leave  
  8016f8:	c3                   	ret    

008016f9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8016f9:	55                   	push   %ebp
  8016fa:	89 e5                	mov    %esp,%ebp
  8016fc:	83 ec 04             	sub    $0x4,%esp
  8016ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801702:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801705:	eb 0d                	jmp    801714 <strfind+0x1b>
		if (*s == c)
  801707:	8b 45 08             	mov    0x8(%ebp),%eax
  80170a:	8a 00                	mov    (%eax),%al
  80170c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80170f:	74 0e                	je     80171f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801711:	ff 45 08             	incl   0x8(%ebp)
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	8a 00                	mov    (%eax),%al
  801719:	84 c0                	test   %al,%al
  80171b:	75 ea                	jne    801707 <strfind+0xe>
  80171d:	eb 01                	jmp    801720 <strfind+0x27>
		if (*s == c)
			break;
  80171f:	90                   	nop
	return (char *) s;
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801723:	c9                   	leave  
  801724:	c3                   	ret    

00801725 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801725:	55                   	push   %ebp
  801726:	89 e5                	mov    %esp,%ebp
  801728:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801731:	8b 45 10             	mov    0x10(%ebp),%eax
  801734:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801737:	eb 0e                	jmp    801747 <memset+0x22>
		*p++ = c;
  801739:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80173c:	8d 50 01             	lea    0x1(%eax),%edx
  80173f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801742:	8b 55 0c             	mov    0xc(%ebp),%edx
  801745:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801747:	ff 4d f8             	decl   -0x8(%ebp)
  80174a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80174e:	79 e9                	jns    801739 <memset+0x14>
		*p++ = c;

	return v;
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
  801758:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80175b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801761:	8b 45 08             	mov    0x8(%ebp),%eax
  801764:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801767:	eb 16                	jmp    80177f <memcpy+0x2a>
		*d++ = *s++;
  801769:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80176c:	8d 50 01             	lea    0x1(%eax),%edx
  80176f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801772:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801775:	8d 4a 01             	lea    0x1(%edx),%ecx
  801778:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80177b:	8a 12                	mov    (%edx),%dl
  80177d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80177f:	8b 45 10             	mov    0x10(%ebp),%eax
  801782:	8d 50 ff             	lea    -0x1(%eax),%edx
  801785:	89 55 10             	mov    %edx,0x10(%ebp)
  801788:	85 c0                	test   %eax,%eax
  80178a:	75 dd                	jne    801769 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;
	
	s = src;
  801797:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80179d:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8017a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017a9:	73 50                	jae    8017fb <memmove+0x6a>
  8017ab:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b1:	01 d0                	add    %edx,%eax
  8017b3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017b6:	76 43                	jbe    8017fb <memmove+0x6a>
		s += n;
  8017b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017bb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8017be:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017c4:	eb 10                	jmp    8017d6 <memmove+0x45>
			*--d = *--s;
  8017c6:	ff 4d f8             	decl   -0x8(%ebp)
  8017c9:	ff 4d fc             	decl   -0x4(%ebp)
  8017cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017cf:	8a 10                	mov    (%eax),%dl
  8017d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8017d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8017df:	85 c0                	test   %eax,%eax
  8017e1:	75 e3                	jne    8017c6 <memmove+0x35>
	const char *s;
	char *d;
	
	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8017e3:	eb 23                	jmp    801808 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8017e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e8:	8d 50 01             	lea    0x1(%eax),%edx
  8017eb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017f4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017f7:	8a 12                	mov    (%edx),%dl
  8017f9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8017fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801801:	89 55 10             	mov    %edx,0x10(%ebp)
  801804:	85 c0                	test   %eax,%eax
  801806:	75 dd                	jne    8017e5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801808:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
  801810:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801819:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80181f:	eb 2a                	jmp    80184b <memcmp+0x3e>
		if (*s1 != *s2)
  801821:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801824:	8a 10                	mov    (%eax),%dl
  801826:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801829:	8a 00                	mov    (%eax),%al
  80182b:	38 c2                	cmp    %al,%dl
  80182d:	74 16                	je     801845 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80182f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801832:	8a 00                	mov    (%eax),%al
  801834:	0f b6 d0             	movzbl %al,%edx
  801837:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80183a:	8a 00                	mov    (%eax),%al
  80183c:	0f b6 c0             	movzbl %al,%eax
  80183f:	29 c2                	sub    %eax,%edx
  801841:	89 d0                	mov    %edx,%eax
  801843:	eb 18                	jmp    80185d <memcmp+0x50>
		s1++, s2++;
  801845:	ff 45 fc             	incl   -0x4(%ebp)
  801848:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80184b:	8b 45 10             	mov    0x10(%ebp),%eax
  80184e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801851:	89 55 10             	mov    %edx,0x10(%ebp)
  801854:	85 c0                	test   %eax,%eax
  801856:	75 c9                	jne    801821 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801858:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185d:	c9                   	leave  
  80185e:	c3                   	ret    

0080185f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80185f:	55                   	push   %ebp
  801860:	89 e5                	mov    %esp,%ebp
  801862:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801865:	8b 55 08             	mov    0x8(%ebp),%edx
  801868:	8b 45 10             	mov    0x10(%ebp),%eax
  80186b:	01 d0                	add    %edx,%eax
  80186d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801870:	eb 15                	jmp    801887 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	8a 00                	mov    (%eax),%al
  801877:	0f b6 d0             	movzbl %al,%edx
  80187a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187d:	0f b6 c0             	movzbl %al,%eax
  801880:	39 c2                	cmp    %eax,%edx
  801882:	74 0d                	je     801891 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801884:	ff 45 08             	incl   0x8(%ebp)
  801887:	8b 45 08             	mov    0x8(%ebp),%eax
  80188a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80188d:	72 e3                	jb     801872 <memfind+0x13>
  80188f:	eb 01                	jmp    801892 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801891:	90                   	nop
	return (void *) s;
  801892:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
  80189a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80189d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8018a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018ab:	eb 03                	jmp    8018b0 <strtol+0x19>
		s++;
  8018ad:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b3:	8a 00                	mov    (%eax),%al
  8018b5:	3c 20                	cmp    $0x20,%al
  8018b7:	74 f4                	je     8018ad <strtol+0x16>
  8018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bc:	8a 00                	mov    (%eax),%al
  8018be:	3c 09                	cmp    $0x9,%al
  8018c0:	74 eb                	je     8018ad <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8018c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c5:	8a 00                	mov    (%eax),%al
  8018c7:	3c 2b                	cmp    $0x2b,%al
  8018c9:	75 05                	jne    8018d0 <strtol+0x39>
		s++;
  8018cb:	ff 45 08             	incl   0x8(%ebp)
  8018ce:	eb 13                	jmp    8018e3 <strtol+0x4c>
	else if (*s == '-')
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	3c 2d                	cmp    $0x2d,%al
  8018d7:	75 0a                	jne    8018e3 <strtol+0x4c>
		s++, neg = 1;
  8018d9:	ff 45 08             	incl   0x8(%ebp)
  8018dc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8018e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018e7:	74 06                	je     8018ef <strtol+0x58>
  8018e9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8018ed:	75 20                	jne    80190f <strtol+0x78>
  8018ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f2:	8a 00                	mov    (%eax),%al
  8018f4:	3c 30                	cmp    $0x30,%al
  8018f6:	75 17                	jne    80190f <strtol+0x78>
  8018f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fb:	40                   	inc    %eax
  8018fc:	8a 00                	mov    (%eax),%al
  8018fe:	3c 78                	cmp    $0x78,%al
  801900:	75 0d                	jne    80190f <strtol+0x78>
		s += 2, base = 16;
  801902:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801906:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80190d:	eb 28                	jmp    801937 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80190f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801913:	75 15                	jne    80192a <strtol+0x93>
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	8a 00                	mov    (%eax),%al
  80191a:	3c 30                	cmp    $0x30,%al
  80191c:	75 0c                	jne    80192a <strtol+0x93>
		s++, base = 8;
  80191e:	ff 45 08             	incl   0x8(%ebp)
  801921:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801928:	eb 0d                	jmp    801937 <strtol+0xa0>
	else if (base == 0)
  80192a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80192e:	75 07                	jne    801937 <strtol+0xa0>
		base = 10;
  801930:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801937:	8b 45 08             	mov    0x8(%ebp),%eax
  80193a:	8a 00                	mov    (%eax),%al
  80193c:	3c 2f                	cmp    $0x2f,%al
  80193e:	7e 19                	jle    801959 <strtol+0xc2>
  801940:	8b 45 08             	mov    0x8(%ebp),%eax
  801943:	8a 00                	mov    (%eax),%al
  801945:	3c 39                	cmp    $0x39,%al
  801947:	7f 10                	jg     801959 <strtol+0xc2>
			dig = *s - '0';
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	8a 00                	mov    (%eax),%al
  80194e:	0f be c0             	movsbl %al,%eax
  801951:	83 e8 30             	sub    $0x30,%eax
  801954:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801957:	eb 42                	jmp    80199b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801959:	8b 45 08             	mov    0x8(%ebp),%eax
  80195c:	8a 00                	mov    (%eax),%al
  80195e:	3c 60                	cmp    $0x60,%al
  801960:	7e 19                	jle    80197b <strtol+0xe4>
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	8a 00                	mov    (%eax),%al
  801967:	3c 7a                	cmp    $0x7a,%al
  801969:	7f 10                	jg     80197b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	8a 00                	mov    (%eax),%al
  801970:	0f be c0             	movsbl %al,%eax
  801973:	83 e8 57             	sub    $0x57,%eax
  801976:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801979:	eb 20                	jmp    80199b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80197b:	8b 45 08             	mov    0x8(%ebp),%eax
  80197e:	8a 00                	mov    (%eax),%al
  801980:	3c 40                	cmp    $0x40,%al
  801982:	7e 39                	jle    8019bd <strtol+0x126>
  801984:	8b 45 08             	mov    0x8(%ebp),%eax
  801987:	8a 00                	mov    (%eax),%al
  801989:	3c 5a                	cmp    $0x5a,%al
  80198b:	7f 30                	jg     8019bd <strtol+0x126>
			dig = *s - 'A' + 10;
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	8a 00                	mov    (%eax),%al
  801992:	0f be c0             	movsbl %al,%eax
  801995:	83 e8 37             	sub    $0x37,%eax
  801998:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80199b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80199e:	3b 45 10             	cmp    0x10(%ebp),%eax
  8019a1:	7d 19                	jge    8019bc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8019a3:	ff 45 08             	incl   0x8(%ebp)
  8019a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8019ad:	89 c2                	mov    %eax,%edx
  8019af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b2:	01 d0                	add    %edx,%eax
  8019b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8019b7:	e9 7b ff ff ff       	jmp    801937 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8019bc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8019bd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019c1:	74 08                	je     8019cb <strtol+0x134>
		*endptr = (char *) s;
  8019c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c6:	8b 55 08             	mov    0x8(%ebp),%edx
  8019c9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8019cb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019cf:	74 07                	je     8019d8 <strtol+0x141>
  8019d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019d4:	f7 d8                	neg    %eax
  8019d6:	eb 03                	jmp    8019db <strtol+0x144>
  8019d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <ltostr>:

void
ltostr(long value, char *str)
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
  8019e0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8019e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8019ea:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8019f1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8019f5:	79 13                	jns    801a0a <ltostr+0x2d>
	{
		neg = 1;
  8019f7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8019fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a01:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a04:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a07:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a12:	99                   	cltd   
  801a13:	f7 f9                	idiv   %ecx
  801a15:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a18:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a1b:	8d 50 01             	lea    0x1(%eax),%edx
  801a1e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a21:	89 c2                	mov    %eax,%edx
  801a23:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a26:	01 d0                	add    %edx,%eax
  801a28:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a2b:	83 c2 30             	add    $0x30,%edx
  801a2e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a30:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a33:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a38:	f7 e9                	imul   %ecx
  801a3a:	c1 fa 02             	sar    $0x2,%edx
  801a3d:	89 c8                	mov    %ecx,%eax
  801a3f:	c1 f8 1f             	sar    $0x1f,%eax
  801a42:	29 c2                	sub    %eax,%edx
  801a44:	89 d0                	mov    %edx,%eax
  801a46:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801a49:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a4c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a51:	f7 e9                	imul   %ecx
  801a53:	c1 fa 02             	sar    $0x2,%edx
  801a56:	89 c8                	mov    %ecx,%eax
  801a58:	c1 f8 1f             	sar    $0x1f,%eax
  801a5b:	29 c2                	sub    %eax,%edx
  801a5d:	89 d0                	mov    %edx,%eax
  801a5f:	c1 e0 02             	shl    $0x2,%eax
  801a62:	01 d0                	add    %edx,%eax
  801a64:	01 c0                	add    %eax,%eax
  801a66:	29 c1                	sub    %eax,%ecx
  801a68:	89 ca                	mov    %ecx,%edx
  801a6a:	85 d2                	test   %edx,%edx
  801a6c:	75 9c                	jne    801a0a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801a6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a78:	48                   	dec    %eax
  801a79:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a7c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a80:	74 3d                	je     801abf <ltostr+0xe2>
		start = 1 ;
  801a82:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a89:	eb 34                	jmp    801abf <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a91:	01 d0                	add    %edx,%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a9e:	01 c2                	add    %eax,%edx
  801aa0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801aa3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aa6:	01 c8                	add    %ecx,%eax
  801aa8:	8a 00                	mov    (%eax),%al
  801aaa:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801aac:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801aaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab2:	01 c2                	add    %eax,%edx
  801ab4:	8a 45 eb             	mov    -0x15(%ebp),%al
  801ab7:	88 02                	mov    %al,(%edx)
		start++ ;
  801ab9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801abc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ac2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ac5:	7c c4                	jl     801a8b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801ac7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801acd:	01 d0                	add    %edx,%eax
  801acf:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801ad2:	90                   	nop
  801ad3:	c9                   	leave  
  801ad4:	c3                   	ret    

00801ad5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801ad5:	55                   	push   %ebp
  801ad6:	89 e5                	mov    %esp,%ebp
  801ad8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801adb:	ff 75 08             	pushl  0x8(%ebp)
  801ade:	e8 54 fa ff ff       	call   801537 <strlen>
  801ae3:	83 c4 04             	add    $0x4,%esp
  801ae6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801ae9:	ff 75 0c             	pushl  0xc(%ebp)
  801aec:	e8 46 fa ff ff       	call   801537 <strlen>
  801af1:	83 c4 04             	add    $0x4,%esp
  801af4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801af7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801afe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b05:	eb 17                	jmp    801b1e <strcconcat+0x49>
		final[s] = str1[s] ;
  801b07:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b0a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0d:	01 c2                	add    %eax,%edx
  801b0f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b12:	8b 45 08             	mov    0x8(%ebp),%eax
  801b15:	01 c8                	add    %ecx,%eax
  801b17:	8a 00                	mov    (%eax),%al
  801b19:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b1b:	ff 45 fc             	incl   -0x4(%ebp)
  801b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b21:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b24:	7c e1                	jl     801b07 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b26:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b2d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b34:	eb 1f                	jmp    801b55 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b39:	8d 50 01             	lea    0x1(%eax),%edx
  801b3c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b3f:	89 c2                	mov    %eax,%edx
  801b41:	8b 45 10             	mov    0x10(%ebp),%eax
  801b44:	01 c2                	add    %eax,%edx
  801b46:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801b49:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b4c:	01 c8                	add    %ecx,%eax
  801b4e:	8a 00                	mov    (%eax),%al
  801b50:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801b52:	ff 45 f8             	incl   -0x8(%ebp)
  801b55:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b58:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b5b:	7c d9                	jl     801b36 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801b5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b60:	8b 45 10             	mov    0x10(%ebp),%eax
  801b63:	01 d0                	add    %edx,%eax
  801b65:	c6 00 00             	movb   $0x0,(%eax)
}
  801b68:	90                   	nop
  801b69:	c9                   	leave  
  801b6a:	c3                   	ret    

00801b6b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801b6b:	55                   	push   %ebp
  801b6c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801b6e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b71:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b77:	8b 45 14             	mov    0x14(%ebp),%eax
  801b7a:	8b 00                	mov    (%eax),%eax
  801b7c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b83:	8b 45 10             	mov    0x10(%ebp),%eax
  801b86:	01 d0                	add    %edx,%eax
  801b88:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b8e:	eb 0c                	jmp    801b9c <strsplit+0x31>
			*string++ = 0;
  801b90:	8b 45 08             	mov    0x8(%ebp),%eax
  801b93:	8d 50 01             	lea    0x1(%eax),%edx
  801b96:	89 55 08             	mov    %edx,0x8(%ebp)
  801b99:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1) 
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9f:	8a 00                	mov    (%eax),%al
  801ba1:	84 c0                	test   %al,%al
  801ba3:	74 18                	je     801bbd <strsplit+0x52>
  801ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba8:	8a 00                	mov    (%eax),%al
  801baa:	0f be c0             	movsbl %al,%eax
  801bad:	50                   	push   %eax
  801bae:	ff 75 0c             	pushl  0xc(%ebp)
  801bb1:	e8 13 fb ff ff       	call   8016c9 <strchr>
  801bb6:	83 c4 08             	add    $0x8,%esp
  801bb9:	85 c0                	test   %eax,%eax
  801bbb:	75 d3                	jne    801b90 <strsplit+0x25>
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
  801bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc0:	8a 00                	mov    (%eax),%al
  801bc2:	84 c0                	test   %al,%al
  801bc4:	74 5a                	je     801c20 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1) 
  801bc6:	8b 45 14             	mov    0x14(%ebp),%eax
  801bc9:	8b 00                	mov    (%eax),%eax
  801bcb:	83 f8 0f             	cmp    $0xf,%eax
  801bce:	75 07                	jne    801bd7 <strsplit+0x6c>
		{
			return 0;
  801bd0:	b8 00 00 00 00       	mov    $0x0,%eax
  801bd5:	eb 66                	jmp    801c3d <strsplit+0xd2>
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801bd7:	8b 45 14             	mov    0x14(%ebp),%eax
  801bda:	8b 00                	mov    (%eax),%eax
  801bdc:	8d 48 01             	lea    0x1(%eax),%ecx
  801bdf:	8b 55 14             	mov    0x14(%ebp),%edx
  801be2:	89 0a                	mov    %ecx,(%edx)
  801be4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801beb:	8b 45 10             	mov    0x10(%ebp),%eax
  801bee:	01 c2                	add    %eax,%edx
  801bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801bf5:	eb 03                	jmp    801bfa <strsplit+0x8f>
			string++;
  801bf7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}
		
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfd:	8a 00                	mov    (%eax),%al
  801bff:	84 c0                	test   %al,%al
  801c01:	74 8b                	je     801b8e <strsplit+0x23>
  801c03:	8b 45 08             	mov    0x8(%ebp),%eax
  801c06:	8a 00                	mov    (%eax),%al
  801c08:	0f be c0             	movsbl %al,%eax
  801c0b:	50                   	push   %eax
  801c0c:	ff 75 0c             	pushl  0xc(%ebp)
  801c0f:	e8 b5 fa ff ff       	call   8016c9 <strchr>
  801c14:	83 c4 08             	add    $0x8,%esp
  801c17:	85 c0                	test   %eax,%eax
  801c19:	74 dc                	je     801bf7 <strsplit+0x8c>
			string++;
	}
  801c1b:	e9 6e ff ff ff       	jmp    801b8e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;
		
		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c20:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c21:	8b 45 14             	mov    0x14(%ebp),%eax
  801c24:	8b 00                	mov    (%eax),%eax
  801c26:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801c30:	01 d0                	add    %edx,%eax
  801c32:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c38:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c3d:	c9                   	leave  
  801c3e:	c3                   	ret    

00801c3f <smalloc>:
//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c3f:	55                   	push   %ebp
  801c40:	89 e5                	mov    %esp,%ebp
  801c42:	83 ec 18             	sub    $0x18,%esp
  801c45:	8b 45 10             	mov    0x10(%ebp),%eax
  801c48:	88 45 f4             	mov    %al,-0xc(%ebp)
	// Write your code here, remove the panic and write your code
	panic("smalloc() is not required...!!");
  801c4b:	83 ec 04             	sub    $0x4,%esp
  801c4e:	68 f0 30 80 00       	push   $0x8030f0
  801c53:	6a 17                	push   $0x17
  801c55:	68 0f 31 80 00       	push   $0x80310f
  801c5a:	e8 a2 ef ff ff       	call   800c01 <_panic>

00801c5f <sget>:
	//change this "return" according to your answer
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
  801c62:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sget() is not required ...!!");
  801c65:	83 ec 04             	sub    $0x4,%esp
  801c68:	68 1b 31 80 00       	push   $0x80311b
  801c6d:	6a 2f                	push   $0x2f
  801c6f:	68 0f 31 80 00       	push   $0x80310f
  801c74:	e8 88 ef ff ff       	call   800c01 <_panic>

00801c79 <malloc>:
    int szInPages;       // size in pages
    int isReserved;      // 1 if allocated, 0 if free
} memAllocs[(USER_HEAP_MAX - USER_HEAP_START) / PAGE_SIZE];

// the size in bytes
void* malloc(uint32 sizeInBytes) {
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
  801c7c:	83 ec 28             	sub    $0x28,%esp
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
  801c7f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
  801c86:	8b 55 08             	mov    0x8(%ebp),%edx
  801c89:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c8c:	01 d0                	add    %edx,%eax
  801c8e:	48                   	dec    %eax
  801c8f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801c92:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c95:	ba 00 00 00 00       	mov    $0x0,%edx
  801c9a:	f7 75 ec             	divl   -0x14(%ebp)
  801c9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ca0:	29 d0                	sub    %edx,%eax
  801ca2:	89 45 08             	mov    %eax,0x8(%ebp)
    uint32 szInPages = sizeInBytes / PAGE_SIZE;
  801ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca8:	c1 e8 0c             	shr    $0xc,%eax
  801cab:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801cae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cb5:	e9 c8 00 00 00       	jmp    801d82 <malloc+0x109>
        int j;
        for (j = 0; j < szInPages; j++) {
  801cba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801cc1:	eb 27                	jmp    801cea <malloc+0x71>
            if (memAllocs[i + j].isReserved) {
  801cc3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801cc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cc9:	01 c2                	add    %eax,%edx
  801ccb:	89 d0                	mov    %edx,%eax
  801ccd:	01 c0                	add    %eax,%eax
  801ccf:	01 d0                	add    %edx,%eax
  801cd1:	c1 e0 02             	shl    $0x2,%eax
  801cd4:	05 48 40 80 00       	add    $0x804048,%eax
  801cd9:	8b 00                	mov    (%eax),%eax
  801cdb:	85 c0                	test   %eax,%eax
  801cdd:	74 08                	je     801ce7 <malloc+0x6e>
            	i += j;
  801cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ce2:	01 45 f4             	add    %eax,-0xc(%ebp)
            	break; // if we break, then j will not never = szInPages
  801ce5:	eb 0b                	jmp    801cf2 <malloc+0x79>
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
        int j;
        for (j = 0; j < szInPages; j++) {
  801ce7:	ff 45 f0             	incl   -0x10(%ebp)
  801cea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ced:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cf0:	72 d1                	jb     801cc3 <malloc+0x4a>
            	i += j;
            	break; // if we break, then j will not never = szInPages
            }
        }

        if (j == szInPages) { // found a nice block
  801cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cf5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801cf8:	0f 85 81 00 00 00    	jne    801d7f <malloc+0x106>
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;
  801cfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d01:	05 00 00 08 00       	add    $0x80000,%eax
  801d06:	c1 e0 0c             	shl    $0xc,%eax
  801d09:	89 45 e0             	mov    %eax,-0x20(%ebp)

            for (j = 0; j < szInPages; j++) {
  801d0c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d13:	eb 1f                	jmp    801d34 <malloc+0xbb>
                memAllocs[i + j].isReserved = 1;
  801d15:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1b:	01 c2                	add    %eax,%edx
  801d1d:	89 d0                	mov    %edx,%eax
  801d1f:	01 c0                	add    %eax,%eax
  801d21:	01 d0                	add    %edx,%eax
  801d23:	c1 e0 02             	shl    $0x2,%eax
  801d26:	05 48 40 80 00       	add    $0x804048,%eax
  801d2b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
        }

        if (j == szInPages) { // found a nice block
            uint32 startVA = USER_HEAP_START + i * PAGE_SIZE;

            for (j = 0; j < szInPages; j++) {
  801d31:	ff 45 f0             	incl   -0x10(%ebp)
  801d34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d37:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d3a:	72 d9                	jb     801d15 <malloc+0x9c>
                memAllocs[i + j].isReserved = 1;
            }

            memAllocs[i].StartAddress = startVA;
  801d3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d3f:	89 d0                	mov    %edx,%eax
  801d41:	01 c0                	add    %eax,%eax
  801d43:	01 d0                	add    %edx,%eax
  801d45:	c1 e0 02             	shl    $0x2,%eax
  801d48:	8d 90 40 40 80 00    	lea    0x804040(%eax),%edx
  801d4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d51:	89 02                	mov    %eax,(%edx)
            memAllocs[i].szInPages = szInPages;
  801d53:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801d56:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  801d59:	89 c8                	mov    %ecx,%eax
  801d5b:	01 c0                	add    %eax,%eax
  801d5d:	01 c8                	add    %ecx,%eax
  801d5f:	c1 e0 02             	shl    $0x2,%eax
  801d62:	05 44 40 80 00       	add    $0x804044,%eax
  801d67:	89 10                	mov    %edx,(%eax)

            sys_allocateMem(startVA, sizeInBytes);
  801d69:	83 ec 08             	sub    $0x8,%esp
  801d6c:	ff 75 08             	pushl  0x8(%ebp)
  801d6f:	ff 75 e0             	pushl  -0x20(%ebp)
  801d72:	e8 2b 03 00 00       	call   8020a2 <sys_allocateMem>
  801d77:	83 c4 10             	add    $0x10,%esp
            return (void*)startVA;
  801d7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d7d:	eb 19                	jmp    801d98 <malloc+0x11f>
void* malloc(uint32 sizeInBytes) {
    sizeInBytes = ROUNDUP(sizeInBytes, PAGE_SIZE);
    uint32 szInPages = sizeInBytes / PAGE_SIZE;

    // From LC guy PoV: this is a perfect sliding windows algorithm
    for (uint32 i = 0; i <= totalPages - szInPages; i++) {
  801d7f:	ff 45 f4             	incl   -0xc(%ebp)
  801d82:	a1 04 40 80 00       	mov    0x804004,%eax
  801d87:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  801d8a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801d8d:	0f 83 27 ff ff ff    	jae    801cba <malloc+0x41>
            sys_allocateMem(startVA, sizeInBytes);
            return (void*)startVA;
        }
    }

    return NULL; // No suitable range found
  801d93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
  801d9d:	83 ec 28             	sub    $0x28,%esp
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801da0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801da4:	0f 84 e5 00 00 00    	je     801e8f <free+0xf5>

	uint32 addr = (uint32)virtual_address;
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;
  801db0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801db3:	05 00 00 00 80       	add    $0x80000000,%eax
  801db8:	c1 e8 0c             	shr    $0xc,%eax
  801dbb:	89 45 ec             	mov    %eax,-0x14(%ebp)

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
  801dbe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801dc1:	89 d0                	mov    %edx,%eax
  801dc3:	01 c0                	add    %eax,%eax
  801dc5:	01 d0                	add    %edx,%eax
  801dc7:	c1 e0 02             	shl    $0x2,%eax
  801dca:	05 40 40 80 00       	add    $0x804040,%eax
  801dcf:	8b 00                	mov    (%eax),%eax
  801dd1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dd4:	0f 85 b8 00 00 00    	jne    801e92 <free+0xf8>
  801dda:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ddd:	89 d0                	mov    %edx,%eax
  801ddf:	01 c0                	add    %eax,%eax
  801de1:	01 d0                	add    %edx,%eax
  801de3:	c1 e0 02             	shl    $0x2,%eax
  801de6:	05 48 40 80 00       	add    $0x804048,%eax
  801deb:	8b 00                	mov    (%eax),%eax
  801ded:	85 c0                	test   %eax,%eax
  801def:	0f 84 9d 00 00 00    	je     801e92 <free+0xf8>
		return; // invalid
	}

	int num_pages = memAllocs[index].szInPages;
  801df5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801df8:	89 d0                	mov    %edx,%eax
  801dfa:	01 c0                	add    %eax,%eax
  801dfc:	01 d0                	add    %edx,%eax
  801dfe:	c1 e0 02             	shl    $0x2,%eax
  801e01:	05 44 40 80 00       	add    $0x804044,%eax
  801e06:	8b 00                	mov    (%eax),%eax
  801e08:	89 45 e8             	mov    %eax,-0x18(%ebp)

	uint32 size=num_pages*PAGE_SIZE;
  801e0b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e0e:	c1 e0 0c             	shl    $0xc,%eax
  801e11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	sys_freeMem(addr, size);
  801e14:	83 ec 08             	sub    $0x8,%esp
  801e17:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e1a:	ff 75 f0             	pushl  -0x10(%ebp)
  801e1d:	e8 64 02 00 00       	call   802086 <sys_freeMem>
  801e22:	83 c4 10             	add    $0x10,%esp

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801e25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801e2c:	eb 57                	jmp    801e85 <free+0xeb>
		memAllocs[index + i].isReserved = 0;
  801e2e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e34:	01 c2                	add    %eax,%edx
  801e36:	89 d0                	mov    %edx,%eax
  801e38:	01 c0                	add    %eax,%eax
  801e3a:	01 d0                	add    %edx,%eax
  801e3c:	c1 e0 02             	shl    $0x2,%eax
  801e3f:	05 48 40 80 00       	add    $0x804048,%eax
  801e44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].StartAddress = 0;
  801e4a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e50:	01 c2                	add    %eax,%edx
  801e52:	89 d0                	mov    %edx,%eax
  801e54:	01 c0                	add    %eax,%eax
  801e56:	01 d0                	add    %edx,%eax
  801e58:	c1 e0 02             	shl    $0x2,%eax
  801e5b:	05 40 40 80 00       	add    $0x804040,%eax
  801e60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		memAllocs[index + i].szInPages = 0;
  801e66:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e6c:	01 c2                	add    %eax,%edx
  801e6e:	89 d0                	mov    %edx,%eax
  801e70:	01 c0                	add    %eax,%eax
  801e72:	01 d0                	add    %edx,%eax
  801e74:	c1 e0 02             	shl    $0x2,%eax
  801e77:	05 44 40 80 00       	add    $0x804044,%eax
  801e7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	uint32 size=num_pages*PAGE_SIZE;
	sys_freeMem(addr, size);

	// free all pages
	for (int i = 0; i < num_pages; ++i) {
  801e82:	ff 45 f4             	incl   -0xc(%ebp)
  801e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e88:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e8b:	7c a1                	jl     801e2e <free+0x94>
  801e8d:	eb 04                	jmp    801e93 <free+0xf9>
    //TODO: [PROJECT 2025 - MS2 - [2] User Heap] free() [User Side]
    // Write your code here, remove the panic and write your code
    //you should get the size of the given allocation using its address
    //you need to call sys_freeMem()
    //refer to the project presentation and documentation for details
	if (virtual_address == NULL) return;
  801e8f:	90                   	nop
  801e90:	eb 01                	jmp    801e93 <free+0xf9>

	uint32 addr = (uint32)virtual_address;
	int index = (addr - USER_HEAP_START) / PAGE_SIZE;

	if (memAllocs[index].StartAddress != addr || memAllocs[index].isReserved == 0) {
		return; // invalid
  801e92:	90                   	nop
	for (int i = 0; i < num_pages; ++i) {
		memAllocs[index + i].isReserved = 0;
		memAllocs[index + i].StartAddress = 0;
		memAllocs[index + i].szInPages = 0;
	}
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <sfree>:
//	use sys_freeSharedObject(...); which switches to the kernel mode,
//	calls freeSharedObject(...) in "shared_memory_manager.c", then switch back to the user mode here
//	the freeSharedObject() function is empty, make sure to implement it.

void sfree(void* virtual_address)
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
  801e98:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("sfree() is not required ...!!");
  801e9b:	83 ec 04             	sub    $0x4,%esp
  801e9e:	68 38 31 80 00       	push   $0x803138
  801ea3:	68 ae 00 00 00       	push   $0xae
  801ea8:	68 0f 31 80 00       	push   $0x80310f
  801ead:	e8 4f ed ff ff       	call   800c01 <_panic>

00801eb2 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
  801eb5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("realloc() is not required yet...!!");
  801eb8:	83 ec 04             	sub    $0x4,%esp
  801ebb:	68 58 31 80 00       	push   $0x803158
  801ec0:	68 ca 00 00 00       	push   $0xca
  801ec5:	68 0f 31 80 00       	push   $0x80310f
  801eca:	e8 32 ed ff ff       	call   800c01 <_panic>

00801ecf <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
  801ed2:	57                   	push   %edi
  801ed3:	56                   	push   %esi
  801ed4:	53                   	push   %ebx
  801ed5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ede:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ee1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ee4:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ee7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801eea:	cd 30                	int    $0x30
  801eec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ef2:	83 c4 10             	add    $0x10,%esp
  801ef5:	5b                   	pop    %ebx
  801ef6:	5e                   	pop    %esi
  801ef7:	5f                   	pop    %edi
  801ef8:	5d                   	pop    %ebp
  801ef9:	c3                   	ret    

00801efa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801efa:	55                   	push   %ebp
  801efb:	89 e5                	mov    %esp,%ebp
  801efd:	83 ec 04             	sub    $0x4,%esp
  801f00:	8b 45 10             	mov    0x10(%ebp),%eax
  801f03:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f06:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	52                   	push   %edx
  801f12:	ff 75 0c             	pushl  0xc(%ebp)
  801f15:	50                   	push   %eax
  801f16:	6a 00                	push   $0x0
  801f18:	e8 b2 ff ff ff       	call   801ecf <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	90                   	nop
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <sys_cgetc>:

int
sys_cgetc(void)
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 01                	push   $0x1
  801f32:	e8 98 ff ff ff       	call   801ecf <syscall>
  801f37:	83 c4 18             	add    $0x18,%esp
}
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	50                   	push   %eax
  801f4b:	6a 05                	push   $0x5
  801f4d:	e8 7d ff ff ff       	call   801ecf <syscall>
  801f52:	83 c4 18             	add    $0x18,%esp
}
  801f55:	c9                   	leave  
  801f56:	c3                   	ret    

00801f57 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f57:	55                   	push   %ebp
  801f58:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 02                	push   $0x2
  801f66:	e8 64 ff ff ff       	call   801ecf <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
}
  801f6e:	c9                   	leave  
  801f6f:	c3                   	ret    

00801f70 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f70:	55                   	push   %ebp
  801f71:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 03                	push   $0x3
  801f7f:	e8 4b ff ff ff       	call   801ecf <syscall>
  801f84:	83 c4 18             	add    $0x18,%esp
}
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 04                	push   $0x4
  801f98:	e8 32 ff ff ff       	call   801ecf <syscall>
  801f9d:	83 c4 18             	add    $0x18,%esp
}
  801fa0:	c9                   	leave  
  801fa1:	c3                   	ret    

00801fa2 <sys_env_exit>:


void sys_env_exit(void)
{
  801fa2:	55                   	push   %ebp
  801fa3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801fa5:	6a 00                	push   $0x0
  801fa7:	6a 00                	push   $0x0
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	6a 06                	push   $0x6
  801fb1:	e8 19 ff ff ff       	call   801ecf <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
}
  801fb9:	90                   	nop
  801fba:	c9                   	leave  
  801fbb:	c3                   	ret    

00801fbc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801fbc:	55                   	push   %ebp
  801fbd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801fbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	52                   	push   %edx
  801fcc:	50                   	push   %eax
  801fcd:	6a 07                	push   $0x7
  801fcf:	e8 fb fe ff ff       	call   801ecf <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
}
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
  801fdc:	56                   	push   %esi
  801fdd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801fde:	8b 75 18             	mov    0x18(%ebp),%esi
  801fe1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fe4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fe7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fea:	8b 45 08             	mov    0x8(%ebp),%eax
  801fed:	56                   	push   %esi
  801fee:	53                   	push   %ebx
  801fef:	51                   	push   %ecx
  801ff0:	52                   	push   %edx
  801ff1:	50                   	push   %eax
  801ff2:	6a 08                	push   $0x8
  801ff4:	e8 d6 fe ff ff       	call   801ecf <syscall>
  801ff9:	83 c4 18             	add    $0x18,%esp
}
  801ffc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fff:	5b                   	pop    %ebx
  802000:	5e                   	pop    %esi
  802001:	5d                   	pop    %ebp
  802002:	c3                   	ret    

00802003 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802006:	8b 55 0c             	mov    0xc(%ebp),%edx
  802009:	8b 45 08             	mov    0x8(%ebp),%eax
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	52                   	push   %edx
  802013:	50                   	push   %eax
  802014:	6a 09                	push   $0x9
  802016:	e8 b4 fe ff ff       	call   801ecf <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	c9                   	leave  
  80201f:	c3                   	ret    

00802020 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802020:	55                   	push   %ebp
  802021:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	ff 75 0c             	pushl  0xc(%ebp)
  80202c:	ff 75 08             	pushl  0x8(%ebp)
  80202f:	6a 0a                	push   $0xa
  802031:	e8 99 fe ff ff       	call   801ecf <syscall>
  802036:	83 c4 18             	add    $0x18,%esp
}
  802039:	c9                   	leave  
  80203a:	c3                   	ret    

0080203b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80203b:	55                   	push   %ebp
  80203c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 0b                	push   $0xb
  80204a:	e8 80 fe ff ff       	call   801ecf <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 0c                	push   $0xc
  802063:	e8 67 fe ff ff       	call   801ecf <syscall>
  802068:	83 c4 18             	add    $0x18,%esp
}
  80206b:	c9                   	leave  
  80206c:	c3                   	ret    

0080206d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80206d:	55                   	push   %ebp
  80206e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 0d                	push   $0xd
  80207c:	e8 4e fe ff ff       	call   801ecf <syscall>
  802081:	83 c4 18             	add    $0x18,%esp
}
  802084:	c9                   	leave  
  802085:	c3                   	ret    

00802086 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	ff 75 0c             	pushl  0xc(%ebp)
  802092:	ff 75 08             	pushl  0x8(%ebp)
  802095:	6a 11                	push   $0x11
  802097:	e8 33 fe ff ff       	call   801ecf <syscall>
  80209c:	83 c4 18             	add    $0x18,%esp
	return;
  80209f:	90                   	nop
}
  8020a0:	c9                   	leave  
  8020a1:	c3                   	ret    

008020a2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	ff 75 0c             	pushl  0xc(%ebp)
  8020ae:	ff 75 08             	pushl  0x8(%ebp)
  8020b1:	6a 12                	push   $0x12
  8020b3:	e8 17 fe ff ff       	call   801ecf <syscall>
  8020b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bb:	90                   	nop
}
  8020bc:	c9                   	leave  
  8020bd:	c3                   	ret    

008020be <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8020be:	55                   	push   %ebp
  8020bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 0e                	push   $0xe
  8020cd:	e8 fd fd ff ff       	call   801ecf <syscall>
  8020d2:	83 c4 18             	add    $0x18,%esp
}
  8020d5:	c9                   	leave  
  8020d6:	c3                   	ret    

008020d7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8020d7:	55                   	push   %ebp
  8020d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	ff 75 08             	pushl  0x8(%ebp)
  8020e5:	6a 0f                	push   $0xf
  8020e7:	e8 e3 fd ff ff       	call   801ecf <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
}
  8020ef:	c9                   	leave  
  8020f0:	c3                   	ret    

008020f1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8020f1:	55                   	push   %ebp
  8020f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	6a 10                	push   $0x10
  802100:	e8 ca fd ff ff       	call   801ecf <syscall>
  802105:	83 c4 18             	add    $0x18,%esp
}
  802108:	90                   	nop
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 14                	push   $0x14
  80211a:	e8 b0 fd ff ff       	call   801ecf <syscall>
  80211f:	83 c4 18             	add    $0x18,%esp
}
  802122:	90                   	nop
  802123:	c9                   	leave  
  802124:	c3                   	ret    

00802125 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802125:	55                   	push   %ebp
  802126:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802128:	6a 00                	push   $0x0
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 15                	push   $0x15
  802134:	e8 96 fd ff ff       	call   801ecf <syscall>
  802139:	83 c4 18             	add    $0x18,%esp
}
  80213c:	90                   	nop
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <sys_cputc>:


void
sys_cputc(const char c)
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
  802142:	83 ec 04             	sub    $0x4,%esp
  802145:	8b 45 08             	mov    0x8(%ebp),%eax
  802148:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80214b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80214f:	6a 00                	push   $0x0
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	50                   	push   %eax
  802158:	6a 16                	push   $0x16
  80215a:	e8 70 fd ff ff       	call   801ecf <syscall>
  80215f:	83 c4 18             	add    $0x18,%esp
}
  802162:	90                   	nop
  802163:	c9                   	leave  
  802164:	c3                   	ret    

00802165 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802165:	55                   	push   %ebp
  802166:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 17                	push   $0x17
  802174:	e8 56 fd ff ff       	call   801ecf <syscall>
  802179:	83 c4 18             	add    $0x18,%esp
}
  80217c:	90                   	nop
  80217d:	c9                   	leave  
  80217e:	c3                   	ret    

0080217f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80217f:	55                   	push   %ebp
  802180:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802182:	8b 45 08             	mov    0x8(%ebp),%eax
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	ff 75 0c             	pushl  0xc(%ebp)
  80218e:	50                   	push   %eax
  80218f:	6a 18                	push   $0x18
  802191:	e8 39 fd ff ff       	call   801ecf <syscall>
  802196:	83 c4 18             	add    $0x18,%esp
}
  802199:	c9                   	leave  
  80219a:	c3                   	ret    

0080219b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80219b:	55                   	push   %ebp
  80219c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80219e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	52                   	push   %edx
  8021ab:	50                   	push   %eax
  8021ac:	6a 1b                	push   $0x1b
  8021ae:	e8 1c fd ff ff       	call   801ecf <syscall>
  8021b3:	83 c4 18             	add    $0x18,%esp
}
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021b8:	55                   	push   %ebp
  8021b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021be:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	52                   	push   %edx
  8021c8:	50                   	push   %eax
  8021c9:	6a 19                	push   $0x19
  8021cb:	e8 ff fc ff ff       	call   801ecf <syscall>
  8021d0:	83 c4 18             	add    $0x18,%esp
}
  8021d3:	90                   	nop
  8021d4:	c9                   	leave  
  8021d5:	c3                   	ret    

008021d6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8021d6:	55                   	push   %ebp
  8021d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8021d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	52                   	push   %edx
  8021e6:	50                   	push   %eax
  8021e7:	6a 1a                	push   $0x1a
  8021e9:	e8 e1 fc ff ff       	call   801ecf <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
}
  8021f1:	90                   	nop
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
  8021f7:	83 ec 04             	sub    $0x4,%esp
  8021fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8021fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802200:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802203:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802207:	8b 45 08             	mov    0x8(%ebp),%eax
  80220a:	6a 00                	push   $0x0
  80220c:	51                   	push   %ecx
  80220d:	52                   	push   %edx
  80220e:	ff 75 0c             	pushl  0xc(%ebp)
  802211:	50                   	push   %eax
  802212:	6a 1c                	push   $0x1c
  802214:	e8 b6 fc ff ff       	call   801ecf <syscall>
  802219:	83 c4 18             	add    $0x18,%esp
}
  80221c:	c9                   	leave  
  80221d:	c3                   	ret    

0080221e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80221e:	55                   	push   %ebp
  80221f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802221:	8b 55 0c             	mov    0xc(%ebp),%edx
  802224:	8b 45 08             	mov    0x8(%ebp),%eax
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	52                   	push   %edx
  80222e:	50                   	push   %eax
  80222f:	6a 1d                	push   $0x1d
  802231:	e8 99 fc ff ff       	call   801ecf <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
}
  802239:	c9                   	leave  
  80223a:	c3                   	ret    

0080223b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80223b:	55                   	push   %ebp
  80223c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80223e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802241:	8b 55 0c             	mov    0xc(%ebp),%edx
  802244:	8b 45 08             	mov    0x8(%ebp),%eax
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	51                   	push   %ecx
  80224c:	52                   	push   %edx
  80224d:	50                   	push   %eax
  80224e:	6a 1e                	push   $0x1e
  802250:	e8 7a fc ff ff       	call   801ecf <syscall>
  802255:	83 c4 18             	add    $0x18,%esp
}
  802258:	c9                   	leave  
  802259:	c3                   	ret    

0080225a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80225a:	55                   	push   %ebp
  80225b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80225d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802260:	8b 45 08             	mov    0x8(%ebp),%eax
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	52                   	push   %edx
  80226a:	50                   	push   %eax
  80226b:	6a 1f                	push   $0x1f
  80226d:	e8 5d fc ff ff       	call   801ecf <syscall>
  802272:	83 c4 18             	add    $0x18,%esp
}
  802275:	c9                   	leave  
  802276:	c3                   	ret    

00802277 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802277:	55                   	push   %ebp
  802278:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	6a 20                	push   $0x20
  802286:	e8 44 fc ff ff       	call   801ecf <syscall>
  80228b:	83 c4 18             	add    $0x18,%esp
}
  80228e:	c9                   	leave  
  80228f:	c3                   	ret    

00802290 <sys_create_env>:

int
sys_create_env(char* programName, unsigned int page_WS_size, unsigned int percent_WS_pages_to_remove)
{
  802290:	55                   	push   %ebp
  802291:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, page_WS_size, percent_WS_pages_to_remove, 0, 0);
  802293:	8b 45 08             	mov    0x8(%ebp),%eax
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	ff 75 10             	pushl  0x10(%ebp)
  80229d:	ff 75 0c             	pushl  0xc(%ebp)
  8022a0:	50                   	push   %eax
  8022a1:	6a 21                	push   $0x21
  8022a3:	e8 27 fc ff ff       	call   801ecf <syscall>
  8022a8:	83 c4 18             	add    $0x18,%esp
}
  8022ab:	c9                   	leave  
  8022ac:	c3                   	ret    

008022ad <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8022ad:	55                   	push   %ebp
  8022ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8022b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	50                   	push   %eax
  8022bc:	6a 22                	push   $0x22
  8022be:	e8 0c fc ff ff       	call   801ecf <syscall>
  8022c3:	83 c4 18             	add    $0x18,%esp
}
  8022c6:	90                   	nop
  8022c7:	c9                   	leave  
  8022c8:	c3                   	ret    

008022c9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8022c9:	55                   	push   %ebp
  8022ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8022cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	50                   	push   %eax
  8022d8:	6a 23                	push   $0x23
  8022da:	e8 f0 fb ff ff       	call   801ecf <syscall>
  8022df:	83 c4 18             	add    $0x18,%esp
}
  8022e2:	90                   	nop
  8022e3:	c9                   	leave  
  8022e4:	c3                   	ret    

008022e5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8022e5:	55                   	push   %ebp
  8022e6:	89 e5                	mov    %esp,%ebp
  8022e8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8022eb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022ee:	8d 50 04             	lea    0x4(%eax),%edx
  8022f1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	52                   	push   %edx
  8022fb:	50                   	push   %eax
  8022fc:	6a 24                	push   $0x24
  8022fe:	e8 cc fb ff ff       	call   801ecf <syscall>
  802303:	83 c4 18             	add    $0x18,%esp
	return result;
  802306:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802309:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80230c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80230f:	89 01                	mov    %eax,(%ecx)
  802311:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802314:	8b 45 08             	mov    0x8(%ebp),%eax
  802317:	c9                   	leave  
  802318:	c2 04 00             	ret    $0x4

0080231b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80231b:	55                   	push   %ebp
  80231c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	ff 75 10             	pushl  0x10(%ebp)
  802325:	ff 75 0c             	pushl  0xc(%ebp)
  802328:	ff 75 08             	pushl  0x8(%ebp)
  80232b:	6a 13                	push   $0x13
  80232d:	e8 9d fb ff ff       	call   801ecf <syscall>
  802332:	83 c4 18             	add    $0x18,%esp
	return ;
  802335:	90                   	nop
}
  802336:	c9                   	leave  
  802337:	c3                   	ret    

00802338 <sys_rcr2>:
uint32 sys_rcr2()
{
  802338:	55                   	push   %ebp
  802339:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80233b:	6a 00                	push   $0x0
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 25                	push   $0x25
  802347:	e8 83 fb ff ff       	call   801ecf <syscall>
  80234c:	83 c4 18             	add    $0x18,%esp
}
  80234f:	c9                   	leave  
  802350:	c3                   	ret    

00802351 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802351:	55                   	push   %ebp
  802352:	89 e5                	mov    %esp,%ebp
  802354:	83 ec 04             	sub    $0x4,%esp
  802357:	8b 45 08             	mov    0x8(%ebp),%eax
  80235a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80235d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	50                   	push   %eax
  80236a:	6a 26                	push   $0x26
  80236c:	e8 5e fb ff ff       	call   801ecf <syscall>
  802371:	83 c4 18             	add    $0x18,%esp
	return ;
  802374:	90                   	nop
}
  802375:	c9                   	leave  
  802376:	c3                   	ret    

00802377 <rsttst>:
void rsttst()
{
  802377:	55                   	push   %ebp
  802378:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 28                	push   $0x28
  802386:	e8 44 fb ff ff       	call   801ecf <syscall>
  80238b:	83 c4 18             	add    $0x18,%esp
	return ;
  80238e:	90                   	nop
}
  80238f:	c9                   	leave  
  802390:	c3                   	ret    

00802391 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802391:	55                   	push   %ebp
  802392:	89 e5                	mov    %esp,%ebp
  802394:	83 ec 04             	sub    $0x4,%esp
  802397:	8b 45 14             	mov    0x14(%ebp),%eax
  80239a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80239d:	8b 55 18             	mov    0x18(%ebp),%edx
  8023a0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023a4:	52                   	push   %edx
  8023a5:	50                   	push   %eax
  8023a6:	ff 75 10             	pushl  0x10(%ebp)
  8023a9:	ff 75 0c             	pushl  0xc(%ebp)
  8023ac:	ff 75 08             	pushl  0x8(%ebp)
  8023af:	6a 27                	push   $0x27
  8023b1:	e8 19 fb ff ff       	call   801ecf <syscall>
  8023b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b9:	90                   	nop
}
  8023ba:	c9                   	leave  
  8023bb:	c3                   	ret    

008023bc <chktst>:
void chktst(uint32 n)
{
  8023bc:	55                   	push   %ebp
  8023bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 00                	push   $0x0
  8023c5:	6a 00                	push   $0x0
  8023c7:	ff 75 08             	pushl  0x8(%ebp)
  8023ca:	6a 29                	push   $0x29
  8023cc:	e8 fe fa ff ff       	call   801ecf <syscall>
  8023d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d4:	90                   	nop
}
  8023d5:	c9                   	leave  
  8023d6:	c3                   	ret    

008023d7 <inctst>:

void inctst()
{
  8023d7:	55                   	push   %ebp
  8023d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8023da:	6a 00                	push   $0x0
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	6a 00                	push   $0x0
  8023e4:	6a 2a                	push   $0x2a
  8023e6:	e8 e4 fa ff ff       	call   801ecf <syscall>
  8023eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ee:	90                   	nop
}
  8023ef:	c9                   	leave  
  8023f0:	c3                   	ret    

008023f1 <gettst>:
uint32 gettst()
{
  8023f1:	55                   	push   %ebp
  8023f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8023f4:	6a 00                	push   $0x0
  8023f6:	6a 00                	push   $0x0
  8023f8:	6a 00                	push   $0x0
  8023fa:	6a 00                	push   $0x0
  8023fc:	6a 00                	push   $0x0
  8023fe:	6a 2b                	push   $0x2b
  802400:	e8 ca fa ff ff       	call   801ecf <syscall>
  802405:	83 c4 18             	add    $0x18,%esp
}
  802408:	c9                   	leave  
  802409:	c3                   	ret    

0080240a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80240a:	55                   	push   %ebp
  80240b:	89 e5                	mov    %esp,%ebp
  80240d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802410:	6a 00                	push   $0x0
  802412:	6a 00                	push   $0x0
  802414:	6a 00                	push   $0x0
  802416:	6a 00                	push   $0x0
  802418:	6a 00                	push   $0x0
  80241a:	6a 2c                	push   $0x2c
  80241c:	e8 ae fa ff ff       	call   801ecf <syscall>
  802421:	83 c4 18             	add    $0x18,%esp
  802424:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802427:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80242b:	75 07                	jne    802434 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80242d:	b8 01 00 00 00       	mov    $0x1,%eax
  802432:	eb 05                	jmp    802439 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802434:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802439:	c9                   	leave  
  80243a:	c3                   	ret    

0080243b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80243b:	55                   	push   %ebp
  80243c:	89 e5                	mov    %esp,%ebp
  80243e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802441:	6a 00                	push   $0x0
  802443:	6a 00                	push   $0x0
  802445:	6a 00                	push   $0x0
  802447:	6a 00                	push   $0x0
  802449:	6a 00                	push   $0x0
  80244b:	6a 2c                	push   $0x2c
  80244d:	e8 7d fa ff ff       	call   801ecf <syscall>
  802452:	83 c4 18             	add    $0x18,%esp
  802455:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802458:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80245c:	75 07                	jne    802465 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80245e:	b8 01 00 00 00       	mov    $0x1,%eax
  802463:	eb 05                	jmp    80246a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802465:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80246a:	c9                   	leave  
  80246b:	c3                   	ret    

0080246c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80246c:	55                   	push   %ebp
  80246d:	89 e5                	mov    %esp,%ebp
  80246f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802472:	6a 00                	push   $0x0
  802474:	6a 00                	push   $0x0
  802476:	6a 00                	push   $0x0
  802478:	6a 00                	push   $0x0
  80247a:	6a 00                	push   $0x0
  80247c:	6a 2c                	push   $0x2c
  80247e:	e8 4c fa ff ff       	call   801ecf <syscall>
  802483:	83 c4 18             	add    $0x18,%esp
  802486:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802489:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80248d:	75 07                	jne    802496 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80248f:	b8 01 00 00 00       	mov    $0x1,%eax
  802494:	eb 05                	jmp    80249b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802496:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80249b:	c9                   	leave  
  80249c:	c3                   	ret    

0080249d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80249d:	55                   	push   %ebp
  80249e:	89 e5                	mov    %esp,%ebp
  8024a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024a3:	6a 00                	push   $0x0
  8024a5:	6a 00                	push   $0x0
  8024a7:	6a 00                	push   $0x0
  8024a9:	6a 00                	push   $0x0
  8024ab:	6a 00                	push   $0x0
  8024ad:	6a 2c                	push   $0x2c
  8024af:	e8 1b fa ff ff       	call   801ecf <syscall>
  8024b4:	83 c4 18             	add    $0x18,%esp
  8024b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8024ba:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8024be:	75 07                	jne    8024c7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8024c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8024c5:	eb 05                	jmp    8024cc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8024c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024cc:	c9                   	leave  
  8024cd:	c3                   	ret    

008024ce <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8024ce:	55                   	push   %ebp
  8024cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8024d1:	6a 00                	push   $0x0
  8024d3:	6a 00                	push   $0x0
  8024d5:	6a 00                	push   $0x0
  8024d7:	6a 00                	push   $0x0
  8024d9:	ff 75 08             	pushl  0x8(%ebp)
  8024dc:	6a 2d                	push   $0x2d
  8024de:	e8 ec f9 ff ff       	call   801ecf <syscall>
  8024e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8024e6:	90                   	nop
}
  8024e7:	c9                   	leave  
  8024e8:	c3                   	ret    

008024e9 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8024e9:	55                   	push   %ebp
  8024ea:	89 e5                	mov    %esp,%ebp
  8024ec:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8024ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8024f2:	89 d0                	mov    %edx,%eax
  8024f4:	c1 e0 02             	shl    $0x2,%eax
  8024f7:	01 d0                	add    %edx,%eax
  8024f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802500:	01 d0                	add    %edx,%eax
  802502:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802509:	01 d0                	add    %edx,%eax
  80250b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802512:	01 d0                	add    %edx,%eax
  802514:	c1 e0 04             	shl    $0x4,%eax
  802517:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80251a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  802521:	8d 45 e8             	lea    -0x18(%ebp),%eax
  802524:	83 ec 0c             	sub    $0xc,%esp
  802527:	50                   	push   %eax
  802528:	e8 b8 fd ff ff       	call   8022e5 <sys_get_virtual_time>
  80252d:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  802530:	eb 41                	jmp    802573 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  802532:	8d 45 e0             	lea    -0x20(%ebp),%eax
  802535:	83 ec 0c             	sub    $0xc,%esp
  802538:	50                   	push   %eax
  802539:	e8 a7 fd ff ff       	call   8022e5 <sys_get_virtual_time>
  80253e:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  802541:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802544:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802547:	29 c2                	sub    %eax,%edx
  802549:	89 d0                	mov    %edx,%eax
  80254b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80254e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802551:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802554:	89 d1                	mov    %edx,%ecx
  802556:	29 c1                	sub    %eax,%ecx
  802558:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80255b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80255e:	39 c2                	cmp    %eax,%edx
  802560:	0f 97 c0             	seta   %al
  802563:	0f b6 c0             	movzbl %al,%eax
  802566:	29 c1                	sub    %eax,%ecx
  802568:	89 c8                	mov    %ecx,%eax
  80256a:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80256d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802570:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802573:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802576:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802579:	72 b7                	jb     802532 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80257b:	90                   	nop
  80257c:	c9                   	leave  
  80257d:	c3                   	ret    

0080257e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80257e:	55                   	push   %ebp
  80257f:	89 e5                	mov    %esp,%ebp
  802581:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802584:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80258b:	eb 03                	jmp    802590 <busy_wait+0x12>
  80258d:	ff 45 fc             	incl   -0x4(%ebp)
  802590:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802593:	3b 45 08             	cmp    0x8(%ebp),%eax
  802596:	72 f5                	jb     80258d <busy_wait+0xf>
	return i;
  802598:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80259b:	c9                   	leave  
  80259c:	c3                   	ret    
  80259d:	66 90                	xchg   %ax,%ax
  80259f:	90                   	nop

008025a0 <__udivdi3>:
  8025a0:	55                   	push   %ebp
  8025a1:	57                   	push   %edi
  8025a2:	56                   	push   %esi
  8025a3:	53                   	push   %ebx
  8025a4:	83 ec 1c             	sub    $0x1c,%esp
  8025a7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025ab:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025af:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025b7:	89 ca                	mov    %ecx,%edx
  8025b9:	89 f8                	mov    %edi,%eax
  8025bb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025bf:	85 f6                	test   %esi,%esi
  8025c1:	75 2d                	jne    8025f0 <__udivdi3+0x50>
  8025c3:	39 cf                	cmp    %ecx,%edi
  8025c5:	77 65                	ja     80262c <__udivdi3+0x8c>
  8025c7:	89 fd                	mov    %edi,%ebp
  8025c9:	85 ff                	test   %edi,%edi
  8025cb:	75 0b                	jne    8025d8 <__udivdi3+0x38>
  8025cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8025d2:	31 d2                	xor    %edx,%edx
  8025d4:	f7 f7                	div    %edi
  8025d6:	89 c5                	mov    %eax,%ebp
  8025d8:	31 d2                	xor    %edx,%edx
  8025da:	89 c8                	mov    %ecx,%eax
  8025dc:	f7 f5                	div    %ebp
  8025de:	89 c1                	mov    %eax,%ecx
  8025e0:	89 d8                	mov    %ebx,%eax
  8025e2:	f7 f5                	div    %ebp
  8025e4:	89 cf                	mov    %ecx,%edi
  8025e6:	89 fa                	mov    %edi,%edx
  8025e8:	83 c4 1c             	add    $0x1c,%esp
  8025eb:	5b                   	pop    %ebx
  8025ec:	5e                   	pop    %esi
  8025ed:	5f                   	pop    %edi
  8025ee:	5d                   	pop    %ebp
  8025ef:	c3                   	ret    
  8025f0:	39 ce                	cmp    %ecx,%esi
  8025f2:	77 28                	ja     80261c <__udivdi3+0x7c>
  8025f4:	0f bd fe             	bsr    %esi,%edi
  8025f7:	83 f7 1f             	xor    $0x1f,%edi
  8025fa:	75 40                	jne    80263c <__udivdi3+0x9c>
  8025fc:	39 ce                	cmp    %ecx,%esi
  8025fe:	72 0a                	jb     80260a <__udivdi3+0x6a>
  802600:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802604:	0f 87 9e 00 00 00    	ja     8026a8 <__udivdi3+0x108>
  80260a:	b8 01 00 00 00       	mov    $0x1,%eax
  80260f:	89 fa                	mov    %edi,%edx
  802611:	83 c4 1c             	add    $0x1c,%esp
  802614:	5b                   	pop    %ebx
  802615:	5e                   	pop    %esi
  802616:	5f                   	pop    %edi
  802617:	5d                   	pop    %ebp
  802618:	c3                   	ret    
  802619:	8d 76 00             	lea    0x0(%esi),%esi
  80261c:	31 ff                	xor    %edi,%edi
  80261e:	31 c0                	xor    %eax,%eax
  802620:	89 fa                	mov    %edi,%edx
  802622:	83 c4 1c             	add    $0x1c,%esp
  802625:	5b                   	pop    %ebx
  802626:	5e                   	pop    %esi
  802627:	5f                   	pop    %edi
  802628:	5d                   	pop    %ebp
  802629:	c3                   	ret    
  80262a:	66 90                	xchg   %ax,%ax
  80262c:	89 d8                	mov    %ebx,%eax
  80262e:	f7 f7                	div    %edi
  802630:	31 ff                	xor    %edi,%edi
  802632:	89 fa                	mov    %edi,%edx
  802634:	83 c4 1c             	add    $0x1c,%esp
  802637:	5b                   	pop    %ebx
  802638:	5e                   	pop    %esi
  802639:	5f                   	pop    %edi
  80263a:	5d                   	pop    %ebp
  80263b:	c3                   	ret    
  80263c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802641:	89 eb                	mov    %ebp,%ebx
  802643:	29 fb                	sub    %edi,%ebx
  802645:	89 f9                	mov    %edi,%ecx
  802647:	d3 e6                	shl    %cl,%esi
  802649:	89 c5                	mov    %eax,%ebp
  80264b:	88 d9                	mov    %bl,%cl
  80264d:	d3 ed                	shr    %cl,%ebp
  80264f:	89 e9                	mov    %ebp,%ecx
  802651:	09 f1                	or     %esi,%ecx
  802653:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802657:	89 f9                	mov    %edi,%ecx
  802659:	d3 e0                	shl    %cl,%eax
  80265b:	89 c5                	mov    %eax,%ebp
  80265d:	89 d6                	mov    %edx,%esi
  80265f:	88 d9                	mov    %bl,%cl
  802661:	d3 ee                	shr    %cl,%esi
  802663:	89 f9                	mov    %edi,%ecx
  802665:	d3 e2                	shl    %cl,%edx
  802667:	8b 44 24 08          	mov    0x8(%esp),%eax
  80266b:	88 d9                	mov    %bl,%cl
  80266d:	d3 e8                	shr    %cl,%eax
  80266f:	09 c2                	or     %eax,%edx
  802671:	89 d0                	mov    %edx,%eax
  802673:	89 f2                	mov    %esi,%edx
  802675:	f7 74 24 0c          	divl   0xc(%esp)
  802679:	89 d6                	mov    %edx,%esi
  80267b:	89 c3                	mov    %eax,%ebx
  80267d:	f7 e5                	mul    %ebp
  80267f:	39 d6                	cmp    %edx,%esi
  802681:	72 19                	jb     80269c <__udivdi3+0xfc>
  802683:	74 0b                	je     802690 <__udivdi3+0xf0>
  802685:	89 d8                	mov    %ebx,%eax
  802687:	31 ff                	xor    %edi,%edi
  802689:	e9 58 ff ff ff       	jmp    8025e6 <__udivdi3+0x46>
  80268e:	66 90                	xchg   %ax,%ax
  802690:	8b 54 24 08          	mov    0x8(%esp),%edx
  802694:	89 f9                	mov    %edi,%ecx
  802696:	d3 e2                	shl    %cl,%edx
  802698:	39 c2                	cmp    %eax,%edx
  80269a:	73 e9                	jae    802685 <__udivdi3+0xe5>
  80269c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80269f:	31 ff                	xor    %edi,%edi
  8026a1:	e9 40 ff ff ff       	jmp    8025e6 <__udivdi3+0x46>
  8026a6:	66 90                	xchg   %ax,%ax
  8026a8:	31 c0                	xor    %eax,%eax
  8026aa:	e9 37 ff ff ff       	jmp    8025e6 <__udivdi3+0x46>
  8026af:	90                   	nop

008026b0 <__umoddi3>:
  8026b0:	55                   	push   %ebp
  8026b1:	57                   	push   %edi
  8026b2:	56                   	push   %esi
  8026b3:	53                   	push   %ebx
  8026b4:	83 ec 1c             	sub    $0x1c,%esp
  8026b7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026bb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026bf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026c3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026c7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026cb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026cf:	89 f3                	mov    %esi,%ebx
  8026d1:	89 fa                	mov    %edi,%edx
  8026d3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026d7:	89 34 24             	mov    %esi,(%esp)
  8026da:	85 c0                	test   %eax,%eax
  8026dc:	75 1a                	jne    8026f8 <__umoddi3+0x48>
  8026de:	39 f7                	cmp    %esi,%edi
  8026e0:	0f 86 a2 00 00 00    	jbe    802788 <__umoddi3+0xd8>
  8026e6:	89 c8                	mov    %ecx,%eax
  8026e8:	89 f2                	mov    %esi,%edx
  8026ea:	f7 f7                	div    %edi
  8026ec:	89 d0                	mov    %edx,%eax
  8026ee:	31 d2                	xor    %edx,%edx
  8026f0:	83 c4 1c             	add    $0x1c,%esp
  8026f3:	5b                   	pop    %ebx
  8026f4:	5e                   	pop    %esi
  8026f5:	5f                   	pop    %edi
  8026f6:	5d                   	pop    %ebp
  8026f7:	c3                   	ret    
  8026f8:	39 f0                	cmp    %esi,%eax
  8026fa:	0f 87 ac 00 00 00    	ja     8027ac <__umoddi3+0xfc>
  802700:	0f bd e8             	bsr    %eax,%ebp
  802703:	83 f5 1f             	xor    $0x1f,%ebp
  802706:	0f 84 ac 00 00 00    	je     8027b8 <__umoddi3+0x108>
  80270c:	bf 20 00 00 00       	mov    $0x20,%edi
  802711:	29 ef                	sub    %ebp,%edi
  802713:	89 fe                	mov    %edi,%esi
  802715:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802719:	89 e9                	mov    %ebp,%ecx
  80271b:	d3 e0                	shl    %cl,%eax
  80271d:	89 d7                	mov    %edx,%edi
  80271f:	89 f1                	mov    %esi,%ecx
  802721:	d3 ef                	shr    %cl,%edi
  802723:	09 c7                	or     %eax,%edi
  802725:	89 e9                	mov    %ebp,%ecx
  802727:	d3 e2                	shl    %cl,%edx
  802729:	89 14 24             	mov    %edx,(%esp)
  80272c:	89 d8                	mov    %ebx,%eax
  80272e:	d3 e0                	shl    %cl,%eax
  802730:	89 c2                	mov    %eax,%edx
  802732:	8b 44 24 08          	mov    0x8(%esp),%eax
  802736:	d3 e0                	shl    %cl,%eax
  802738:	89 44 24 04          	mov    %eax,0x4(%esp)
  80273c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802740:	89 f1                	mov    %esi,%ecx
  802742:	d3 e8                	shr    %cl,%eax
  802744:	09 d0                	or     %edx,%eax
  802746:	d3 eb                	shr    %cl,%ebx
  802748:	89 da                	mov    %ebx,%edx
  80274a:	f7 f7                	div    %edi
  80274c:	89 d3                	mov    %edx,%ebx
  80274e:	f7 24 24             	mull   (%esp)
  802751:	89 c6                	mov    %eax,%esi
  802753:	89 d1                	mov    %edx,%ecx
  802755:	39 d3                	cmp    %edx,%ebx
  802757:	0f 82 87 00 00 00    	jb     8027e4 <__umoddi3+0x134>
  80275d:	0f 84 91 00 00 00    	je     8027f4 <__umoddi3+0x144>
  802763:	8b 54 24 04          	mov    0x4(%esp),%edx
  802767:	29 f2                	sub    %esi,%edx
  802769:	19 cb                	sbb    %ecx,%ebx
  80276b:	89 d8                	mov    %ebx,%eax
  80276d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802771:	d3 e0                	shl    %cl,%eax
  802773:	89 e9                	mov    %ebp,%ecx
  802775:	d3 ea                	shr    %cl,%edx
  802777:	09 d0                	or     %edx,%eax
  802779:	89 e9                	mov    %ebp,%ecx
  80277b:	d3 eb                	shr    %cl,%ebx
  80277d:	89 da                	mov    %ebx,%edx
  80277f:	83 c4 1c             	add    $0x1c,%esp
  802782:	5b                   	pop    %ebx
  802783:	5e                   	pop    %esi
  802784:	5f                   	pop    %edi
  802785:	5d                   	pop    %ebp
  802786:	c3                   	ret    
  802787:	90                   	nop
  802788:	89 fd                	mov    %edi,%ebp
  80278a:	85 ff                	test   %edi,%edi
  80278c:	75 0b                	jne    802799 <__umoddi3+0xe9>
  80278e:	b8 01 00 00 00       	mov    $0x1,%eax
  802793:	31 d2                	xor    %edx,%edx
  802795:	f7 f7                	div    %edi
  802797:	89 c5                	mov    %eax,%ebp
  802799:	89 f0                	mov    %esi,%eax
  80279b:	31 d2                	xor    %edx,%edx
  80279d:	f7 f5                	div    %ebp
  80279f:	89 c8                	mov    %ecx,%eax
  8027a1:	f7 f5                	div    %ebp
  8027a3:	89 d0                	mov    %edx,%eax
  8027a5:	e9 44 ff ff ff       	jmp    8026ee <__umoddi3+0x3e>
  8027aa:	66 90                	xchg   %ax,%ax
  8027ac:	89 c8                	mov    %ecx,%eax
  8027ae:	89 f2                	mov    %esi,%edx
  8027b0:	83 c4 1c             	add    $0x1c,%esp
  8027b3:	5b                   	pop    %ebx
  8027b4:	5e                   	pop    %esi
  8027b5:	5f                   	pop    %edi
  8027b6:	5d                   	pop    %ebp
  8027b7:	c3                   	ret    
  8027b8:	3b 04 24             	cmp    (%esp),%eax
  8027bb:	72 06                	jb     8027c3 <__umoddi3+0x113>
  8027bd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027c1:	77 0f                	ja     8027d2 <__umoddi3+0x122>
  8027c3:	89 f2                	mov    %esi,%edx
  8027c5:	29 f9                	sub    %edi,%ecx
  8027c7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027cb:	89 14 24             	mov    %edx,(%esp)
  8027ce:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027d2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027d6:	8b 14 24             	mov    (%esp),%edx
  8027d9:	83 c4 1c             	add    $0x1c,%esp
  8027dc:	5b                   	pop    %ebx
  8027dd:	5e                   	pop    %esi
  8027de:	5f                   	pop    %edi
  8027df:	5d                   	pop    %ebp
  8027e0:	c3                   	ret    
  8027e1:	8d 76 00             	lea    0x0(%esi),%esi
  8027e4:	2b 04 24             	sub    (%esp),%eax
  8027e7:	19 fa                	sbb    %edi,%edx
  8027e9:	89 d1                	mov    %edx,%ecx
  8027eb:	89 c6                	mov    %eax,%esi
  8027ed:	e9 71 ff ff ff       	jmp    802763 <__umoddi3+0xb3>
  8027f2:	66 90                	xchg   %ax,%ax
  8027f4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8027f8:	72 ea                	jb     8027e4 <__umoddi3+0x134>
  8027fa:	89 d9                	mov    %ebx,%ecx
  8027fc:	e9 62 ff ff ff       	jmp    802763 <__umoddi3+0xb3>
