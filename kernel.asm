
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <main>:
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  100000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  100004:	83 e4 f0             	and    $0xfffffff0,%esp
  100007:	ff 71 fc             	pushl  -0x4(%ecx)
  10000a:	55                   	push   %ebp
  10000b:	89 e5                	mov    %esp,%ebp
  10000d:	53                   	push   %ebx
  10000e:	51                   	push   %ecx
  mpinit(); // collect info about this machine
  10000f:	e8 5c 2a 00 00       	call   102a70 <mpinit>
  lapicinit(mpbcpu());
  100014:	e8 37 2a 00 00       	call   102a50 <mpbcpu>
  100019:	83 ec 0c             	sub    $0xc,%esp
  10001c:	50                   	push   %eax
  10001d:	e8 2e 26 00 00       	call   102650 <lapicinit>
  ksegment();
  100022:	e8 19 32 00 00       	call   103240 <ksegment>
  picinit();       // interrupt controller
  100027:	e8 84 2c 00 00       	call   102cb0 <picinit>
  ioapicinit();    // another interrupt controller
  10002c:	e8 2f 22 00 00       	call   102260 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
  100031:	e8 8a 09 00 00       	call   1009c0 <consoleinit>
  uartinit();      // serial port
  100036:	e8 e5 53 00 00       	call   105420 <uartinit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu());
  10003b:	e8 00 27 00 00       	call   102740 <cpu>
  100040:	59                   	pop    %ecx
  100041:	5b                   	pop    %ebx
  100042:	50                   	push   %eax
  100043:	68 2e 64 10 00       	push   $0x10642e
  100048:	e8 53 06 00 00       	call   1006a0 <cprintf>

  kinit();         // physical memory allocator
  10004d:	e8 fe 23 00 00       	call   102450 <kinit>
  pinit();         // process table
  100052:	e8 c9 31 00 00       	call   103220 <pinit>
  tvinit();        // trap vectors
  100057:	e8 74 50 00 00       	call   1050d0 <tvinit>
  binit();         // buffer cache
  10005c:	e8 ef 00 00 00       	call   100150 <binit>
  fileinit();      // file table
  100061:	e8 0a 0e 00 00       	call   100e70 <fileinit>
  iinit();         // inode cache
  100066:	e8 45 14 00 00       	call   1014b0 <iinit>
  ideinit();       // disk
  10006b:	e8 b0 1f 00 00       	call   102020 <ideinit>

  //ethinit();       // ethernet
  if(!ismp)
  100070:	a1 e4 ca 10 00       	mov    0x10cae4,%eax
  100075:	83 c4 10             	add    $0x10,%esp
  100078:	85 c0                	test   %eax,%eax
  10007a:	0f 84 b8 00 00 00    	je     100138 <main+0x138>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  100080:	e8 db 35 00 00       	call   103660 <userinit>
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  100085:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
  100088:	bb 00 cb 10 00       	mov    $0x10cb00,%ebx
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  10008d:	68 6a 00 00 00       	push   $0x6a
  100092:	68 54 97 10 00       	push   $0x109754
  100097:	68 00 70 00 00       	push   $0x7000
  10009c:	e8 4f 3f 00 00       	call   103ff0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  1000a1:	69 05 e0 d0 10 00 bc 	imul   $0xbc,0x10d0e0,%eax
  1000a8:	00 00 00 
  1000ab:	83 c4 10             	add    $0x10,%esp
  1000ae:	05 00 cb 10 00       	add    $0x10cb00,%eax
  1000b3:	39 d8                	cmp    %ebx,%eax
  1000b5:	76 7c                	jbe    100133 <main+0x133>
  1000b7:	89 f6                	mov    %esi,%esi
  1000b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == cpus+cpu())  // We've started already.
  1000c0:	e8 7b 26 00 00       	call   102740 <cpu>
  1000c5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  1000cb:	05 00 cb 10 00       	add    $0x10cb00,%eax
  1000d0:	39 c3                	cmp    %eax,%ebx
  1000d2:	74 46                	je     10011a <main+0x11a>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
  1000d4:	83 ec 0c             	sub    $0xc,%esp
  1000d7:	68 00 10 00 00       	push   $0x1000
  1000dc:	e8 af 23 00 00       	call   102490 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
  1000e1:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpmain;
  1000e6:	c7 05 f8 6f 00 00 80 	movl   $0x102980,0x6ff8
  1000ed:	29 10 00 
    if(c == cpus+cpu())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
    *(void**)(code-4) = stack + KSTACKSIZE;
  1000f0:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapicstartap(c->apicid, (uint)code);
  1000f5:	58                   	pop    %eax
  1000f6:	5a                   	pop    %edx
  1000f7:	68 00 70 00 00       	push   $0x7000
  1000fc:	0f b6 03             	movzbl (%ebx),%eax
  1000ff:	50                   	push   %eax
  100100:	e8 1b 27 00 00       	call   102820 <lapicstartap>
  100105:	83 c4 10             	add    $0x10,%esp
  100108:	90                   	nop
  100109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
  100110:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
  100116:	85 c0                	test   %eax,%eax
  100118:	74 f6                	je     100110 <main+0x110>

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  10011a:	69 05 e0 d0 10 00 bc 	imul   $0xbc,0x10d0e0,%eax
  100121:	00 00 00 
  100124:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
  10012a:	05 00 cb 10 00       	add    $0x10cb00,%eax
  10012f:	39 c3                	cmp    %eax,%ebx
  100131:	72 8d                	jb     1000c0 <main+0xc0>
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  100133:	e8 48 28 00 00       	call   102980 <mpmain>
  iinit();         // inode cache
  ideinit();       // disk

  //ethinit();       // ethernet
  if(!ismp)
    timerinit();   // uniprocessor timer
  100138:	e8 33 4f 00 00       	call   105070 <timerinit>
  10013d:	e9 3e ff ff ff       	jmp    100080 <main+0x80>
  100142:	66 90                	xchg   %ax,%ax
  100144:	66 90                	xchg   %ax,%ax
  100146:	66 90                	xchg   %ax,%ax
  100148:	66 90                	xchg   %ax,%ax
  10014a:	66 90                	xchg   %ax,%ax
  10014c:	66 90                	xchg   %ax,%ax
  10014e:	66 90                	xchg   %ax,%ax

00100150 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
  100150:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
  100153:	68 a0 5f 10 00       	push   $0x105fa0
  100158:	68 a0 98 10 00       	push   $0x1098a0
  10015d:	e8 be 3b 00 00       	call   103d20 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  100162:	c7 05 d0 ad 10 00 c4 	movl   $0x10adc4,0x10add0
  100169:	ad 10 00 
  bcache.head.next = &bcache.head;
  10016c:	c7 05 d4 ad 10 00 c4 	movl   $0x10adc4,0x10add4
  100173:	ad 10 00 
  100176:	83 c4 10             	add    $0x10,%esp
  100179:	b9 c4 ad 10 00       	mov    $0x10adc4,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  10017e:	b8 d4 98 10 00       	mov    $0x1098d4,%eax
  100183:	eb 05                	jmp    10018a <binit+0x3a>
  100185:	8d 76 00             	lea    0x0(%esi),%esi
  100188:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
  10018a:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
  10018d:	c7 40 0c c4 ad 10 00 	movl   $0x10adc4,0xc(%eax)
  100194:	89 c1                	mov    %eax,%ecx
    b->dev = -1;
    bcache.head.next->prev = b;
  100196:	8b 15 d4 ad 10 00    	mov    0x10add4,%edx
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
  10019c:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
  1001a3:	89 42 0c             	mov    %eax,0xc(%edx)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001a6:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  1001ac:	a3 d4 ad 10 00       	mov    %eax,0x10add4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
  1001b1:	81 fa c4 ad 10 00    	cmp    $0x10adc4,%edx
  1001b7:	75 cf                	jne    100188 <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
  1001b9:	83 c4 0c             	add    $0xc,%esp
  1001bc:	c3                   	ret    
  1001bd:	8d 76 00             	lea    0x0(%esi),%esi

001001c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1001c0:	57                   	push   %edi
  1001c1:	56                   	push   %esi
  1001c2:	53                   	push   %ebx
  1001c3:	8b 74 24 10          	mov    0x10(%esp),%esi
  1001c7:	8b 7c 24 14          	mov    0x14(%esp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&bcache.lock);
  1001cb:	83 ec 0c             	sub    $0xc,%esp
  1001ce:	68 a0 98 10 00       	push   $0x1098a0
  1001d3:	e8 68 3b 00 00       	call   103d40 <acquire>
  1001d8:	83 c4 10             	add    $0x10,%esp

 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
  1001db:	8b 1d d4 ad 10 00    	mov    0x10add4,%ebx
  1001e1:	81 fb c4 ad 10 00    	cmp    $0x10adc4,%ebx
  1001e7:	75 12                	jne    1001fb <bread+0x3b>
  1001e9:	eb 35                	jmp    100220 <bread+0x60>
  1001eb:	90                   	nop
  1001ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1001f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1001f3:	81 fb c4 ad 10 00    	cmp    $0x10adc4,%ebx
  1001f9:	74 25                	je     100220 <bread+0x60>
    if(b->dev == dev && b->sector == sector){
  1001fb:	3b 73 04             	cmp    0x4(%ebx),%esi
  1001fe:	75 f0                	jne    1001f0 <bread+0x30>
  100200:	3b 7b 08             	cmp    0x8(%ebx),%edi
  100203:	75 eb                	jne    1001f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
  100205:	8b 03                	mov    (%ebx),%eax
  100207:	a8 01                	test   $0x1,%al
  100209:	74 68                	je     100273 <bread+0xb3>
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
  10020b:	83 ec 08             	sub    $0x8,%esp
  10020e:	68 a0 98 10 00       	push   $0x1098a0
  100213:	53                   	push   %ebx
  100214:	e8 87 36 00 00       	call   1038a0 <sleep>
  100219:	83 c4 10             	add    $0x10,%esp
  10021c:	eb bd                	jmp    1001db <bread+0x1b>
  10021e:	66 90                	xchg   %ax,%ax
      goto loop;
    }
  }

  // Allocate fresh block.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
  100220:	8b 1d d0 ad 10 00    	mov    0x10add0,%ebx
  100226:	81 fb c4 ad 10 00    	cmp    $0x10adc4,%ebx
  10022c:	75 0d                	jne    10023b <bread+0x7b>
  10022e:	eb 5a                	jmp    10028a <bread+0xca>
  100230:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  100233:	81 fb c4 ad 10 00    	cmp    $0x10adc4,%ebx
  100239:	74 4f                	je     10028a <bread+0xca>
    if((b->flags & B_BUSY) == 0){
  10023b:	f6 03 01             	testb  $0x1,(%ebx)
  10023e:	75 f0                	jne    100230 <bread+0x70>
      b->dev = dev;
      b->sector = sector;
      b->flags = B_BUSY;
      release(&bcache.lock);
  100240:	83 ec 0c             	sub    $0xc,%esp
  }

  // Allocate fresh block.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    if((b->flags & B_BUSY) == 0){
      b->dev = dev;
  100243:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  100246:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
  100249:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
  10024f:	68 a0 98 10 00       	push   $0x1098a0
  100254:	e8 c7 3c 00 00       	call   103f20 <release>
  100259:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  10025c:	f6 03 02             	testb  $0x2,(%ebx)
  10025f:	75 0c                	jne    10026d <bread+0xad>
    iderw(b);
  100261:	83 ec 0c             	sub    $0xc,%esp
  100264:	53                   	push   %ebx
  100265:	e8 06 1f 00 00       	call   102170 <iderw>
  10026a:	83 c4 10             	add    $0x10,%esp
  return b;
}
  10026d:	89 d8                	mov    %ebx,%eax
  10026f:	5b                   	pop    %ebx
  100270:	5e                   	pop    %esi
  100271:	5f                   	pop    %edi
  100272:	c3                   	ret    
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->sector == sector){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
        release(&bcache.lock);
  100273:	83 ec 0c             	sub    $0xc,%esp
 loop:
  // Try for cached block.
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->sector == sector){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
  100276:	83 c8 01             	or     $0x1,%eax
  100279:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
  10027b:	68 a0 98 10 00       	push   $0x1098a0
  100280:	e8 9b 3c 00 00       	call   103f20 <release>
  100285:	83 c4 10             	add    $0x10,%esp
  100288:	eb d2                	jmp    10025c <bread+0x9c>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
  10028a:	83 ec 0c             	sub    $0xc,%esp
  10028d:	68 a7 5f 10 00       	push   $0x105fa7
  100292:	e8 89 07 00 00       	call   100a20 <panic>
  100297:	89 f6                	mov    %esi,%esi
  100299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001002a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  1002a0:	83 ec 0c             	sub    $0xc,%esp
  1002a3:	8b 54 24 10          	mov    0x10(%esp),%edx
  if((b->flags & B_BUSY) == 0)
  1002a7:	8b 02                	mov    (%edx),%eax
  1002a9:	a8 01                	test   $0x1,%al
  1002ab:	74 11                	je     1002be <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
  1002ad:	83 c8 04             	or     $0x4,%eax
  1002b0:	89 02                	mov    %eax,(%edx)
  iderw(b);
  1002b2:	89 54 24 10          	mov    %edx,0x10(%esp)
}
  1002b6:	83 c4 0c             	add    $0xc,%esp
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
  1002b9:	e9 b2 1e 00 00       	jmp    102170 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  1002be:	83 ec 0c             	sub    $0xc,%esp
  1002c1:	68 b8 5f 10 00       	push   $0x105fb8
  1002c6:	e8 55 07 00 00       	call   100a20 <panic>
  1002cb:	90                   	nop
  1002cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001002d0 <brelse>:
}

// Release the buffer b.
void
brelse(struct buf *b)
{
  1002d0:	53                   	push   %ebx
  1002d1:	83 ec 08             	sub    $0x8,%esp
  1002d4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if((b->flags & B_BUSY) == 0)
  1002d8:	f6 03 01             	testb  $0x1,(%ebx)
  1002db:	74 55                	je     100332 <brelse+0x62>
    panic("brelse");

  acquire(&bcache.lock);
  1002dd:	83 ec 0c             	sub    $0xc,%esp
  1002e0:	68 a0 98 10 00       	push   $0x1098a0
  1002e5:	e8 56 3a 00 00       	call   103d40 <acquire>

  b->next->prev = b->prev;
  1002ea:	8b 43 10             	mov    0x10(%ebx),%eax
  1002ed:	8b 53 0c             	mov    0xc(%ebx),%edx
  1002f0:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  1002f3:	8b 53 0c             	mov    0xc(%ebx),%edx
  1002f6:	89 42 10             	mov    %eax,0x10(%edx)
  b->next = bcache.head.next;
  1002f9:	a1 d4 ad 10 00       	mov    0x10add4,%eax
  b->prev = &bcache.head;
  1002fe:	c7 43 0c c4 ad 10 00 	movl   $0x10adc4,0xc(%ebx)

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
  100305:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
  100308:	a1 d4 ad 10 00       	mov    0x10add4,%eax
  10030d:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
  100310:	89 1d d4 ad 10 00    	mov    %ebx,0x10add4

  b->flags &= ~B_BUSY;
  100316:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
  100319:	89 1c 24             	mov    %ebx,(%esp)
  10031c:	e8 2f 36 00 00       	call   103950 <wakeup>

  release(&bcache.lock);
  100321:	c7 44 24 20 a0 98 10 	movl   $0x1098a0,0x20(%esp)
  100328:	00 
}
  100329:	83 c4 18             	add    $0x18,%esp
  10032c:	5b                   	pop    %ebx
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
  10032d:	e9 ee 3b 00 00       	jmp    103f20 <release>
// Release the buffer b.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100332:	83 ec 0c             	sub    $0xc,%esp
  100335:	68 bf 5f 10 00       	push   $0x105fbf
  10033a:	e8 e1 06 00 00       	call   100a20 <panic>
  10033f:	90                   	nop

00100340 <consoleread>:
  release(&input.lock);
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  100340:	55                   	push   %ebp
  100341:	57                   	push   %edi
  100342:	56                   	push   %esi
  100343:	53                   	push   %ebx
  100344:	83 ec 28             	sub    $0x28,%esp
  100347:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
  10034b:	8b 7c 24 40          	mov    0x40(%esp),%edi
  uint target;
  int c;

  iunlock(ip);
  10034f:	55                   	push   %ebp
  100350:	e8 bb 12 00 00       	call   101610 <iunlock>
  target = n;
  acquire(&input.lock);
  100355:	c7 04 24 e0 af 10 00 	movl   $0x10afe0,(%esp)
  10035c:	e8 df 39 00 00       	call   103d40 <acquire>
  while(n > 0){
  100361:	83 c4 10             	add    $0x10,%esp
  100364:	8b 74 24 38          	mov    0x38(%esp),%esi
  100368:	31 c0                	xor    %eax,%eax
  10036a:	85 f6                	test   %esi,%esi
  10036c:	7e 7e                	jle    1003ec <consoleread+0xac>
    while(input.r == input.w){
  10036e:	a1 94 b0 10 00       	mov    0x10b094,%eax
  100373:	3b 05 98 b0 10 00    	cmp    0x10b098,%eax
  100379:	75 41                	jne    1003bc <consoleread+0x7c>
      if(cp->killed){
  10037b:	c7 c3 f8 ff ff ff    	mov    $0xfffffff8,%ebx
  100381:	65 8b 03             	mov    %gs:(%ebx),%eax
  100384:	8b 40 24             	mov    0x24(%eax),%eax
  100387:	85 c0                	test   %eax,%eax
  100389:	74 0f                	je     10039a <consoleread+0x5a>
  10038b:	e9 80 00 00 00       	jmp    100410 <consoleread+0xd0>
  100390:	65 8b 03             	mov    %gs:(%ebx),%eax
  100393:	8b 50 24             	mov    0x24(%eax),%edx
  100396:	85 d2                	test   %edx,%edx
  100398:	75 76                	jne    100410 <consoleread+0xd0>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  10039a:	83 ec 08             	sub    $0x8,%esp
  10039d:	68 e0 af 10 00       	push   $0x10afe0
  1003a2:	68 94 b0 10 00       	push   $0x10b094
  1003a7:	e8 f4 34 00 00       	call   1038a0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  1003ac:	a1 94 b0 10 00       	mov    0x10b094,%eax
  1003b1:	83 c4 10             	add    $0x10,%esp
  1003b4:	3b 05 98 b0 10 00    	cmp    0x10b098,%eax
  1003ba:	74 d4                	je     100390 <consoleread+0x50>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  1003bc:	8d 50 01             	lea    0x1(%eax),%edx
  1003bf:	89 15 94 b0 10 00    	mov    %edx,0x10b094
  1003c5:	89 c2                	mov    %eax,%edx
  1003c7:	83 e2 7f             	and    $0x7f,%edx
  1003ca:	0f be 92 14 b0 10 00 	movsbl 0x10b014(%edx),%edx
    if(c == C('D')){  // EOF
  1003d1:	83 fa 04             	cmp    $0x4,%edx
  1003d4:	74 5f                	je     100435 <consoleread+0xf5>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1003d6:	83 c7 01             	add    $0x1,%edi
    --n;
  1003d9:	83 ee 01             	sub    $0x1,%esi
    if(c == '\n')
  1003dc:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1003df:	88 57 ff             	mov    %dl,-0x1(%edi)
    --n;
    if(c == '\n')
  1003e2:	74 5c                	je     100440 <consoleread+0x100>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  1003e4:	85 f6                	test   %esi,%esi
  1003e6:	75 86                	jne    10036e <consoleread+0x2e>
  1003e8:	8b 44 24 38          	mov    0x38(%esp),%eax
  1003ec:	89 44 24 0c          	mov    %eax,0xc(%esp)
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  1003f0:	83 ec 0c             	sub    $0xc,%esp
  1003f3:	68 e0 af 10 00       	push   $0x10afe0
  1003f8:	e8 23 3b 00 00       	call   103f20 <release>
  ilock(ip);
  1003fd:	89 2c 24             	mov    %ebp,(%esp)
  100400:	e8 fb 10 00 00       	call   101500 <ilock>

  return target - n;
  100405:	83 c4 10             	add    $0x10,%esp
  100408:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10040c:	eb 1f                	jmp    10042d <consoleread+0xed>
  10040e:	66 90                	xchg   %ax,%ax
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100410:	83 ec 0c             	sub    $0xc,%esp
  100413:	68 e0 af 10 00       	push   $0x10afe0
  100418:	e8 03 3b 00 00       	call   103f20 <release>
        ilock(ip);
  10041d:	89 2c 24             	mov    %ebp,(%esp)
  100420:	e8 db 10 00 00       	call   101500 <ilock>
        return -1;
  100425:	83 c4 10             	add    $0x10,%esp
  100428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  10042d:	83 c4 1c             	add    $0x1c,%esp
  100430:	5b                   	pop    %ebx
  100431:	5e                   	pop    %esi
  100432:	5f                   	pop    %edi
  100433:	5d                   	pop    %ebp
  100434:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  100435:	39 74 24 38          	cmp    %esi,0x38(%esp)
  100439:	76 05                	jbe    100440 <consoleread+0x100>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  10043b:	a3 94 b0 10 00       	mov    %eax,0x10b094
  100440:	8b 44 24 38          	mov    0x38(%esp),%eax
  100444:	29 f0                	sub    %esi,%eax
  100446:	eb a4                	jmp    1003ec <consoleread+0xac>
  100448:	90                   	nop
  100449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100450 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  100450:	55                   	push   %ebp
  100451:	57                   	push   %edi
  100452:	56                   	push   %esi
  100453:	53                   	push   %ebx
  100454:	83 ec 0c             	sub    $0xc,%esp
  if(panicked){
  100457:	8b 0d c0 97 10 00    	mov    0x1097c0,%ecx
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
  10045d:	8b 74 24 20          	mov    0x20(%esp),%esi
  if(panicked){
  100461:	85 c9                	test   %ecx,%ecx
  100463:	74 03                	je     100468 <consputc+0x18>
}

static inline void
cli(void)
{
  asm volatile("cli");
  100465:	fa                   	cli    
  100466:	eb fe                	jmp    100466 <consputc+0x16>
    cli();
    for(;;)
      ;
  }

  uartputc(c);
  100468:	83 ec 0c             	sub    $0xc,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  10046b:	bf d4 03 00 00       	mov    $0x3d4,%edi
  100470:	56                   	push   %esi
  100471:	e8 6a 50 00 00       	call   1054e0 <uartputc>
  100476:	b8 0e 00 00 00       	mov    $0xe,%eax
  10047b:	89 fa                	mov    %edi,%edx
  10047d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10047e:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100483:	89 da                	mov    %ebx,%edx
  100485:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  100486:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100489:	89 fa                	mov    %edi,%edx
  10048b:	c1 e0 08             	shl    $0x8,%eax
  10048e:	89 c1                	mov    %eax,%ecx
  100490:	b8 0f 00 00 00       	mov    $0xf,%eax
  100495:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100496:	89 da                	mov    %ebx,%edx
  100498:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  100499:	0f b6 c0             	movzbl %al,%eax

  if(c == '\n')
  10049c:	83 c4 10             	add    $0x10,%esp
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  10049f:	09 c8                	or     %ecx,%eax

  if(c == '\n')
  1004a1:	83 fe 0a             	cmp    $0xa,%esi
  1004a4:	74 6b                	je     100511 <consputc+0xc1>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  1004a6:	81 fe 00 01 00 00    	cmp    $0x100,%esi
  1004ac:	0f 84 bf 00 00 00    	je     100571 <consputc+0x121>
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  1004b2:	89 f1                	mov    %esi,%ecx
  1004b4:	8d 58 01             	lea    0x1(%eax),%ebx
  1004b7:	0f b6 d1             	movzbl %cl,%edx
  1004ba:	80 ce 07             	or     $0x7,%dh
  1004bd:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%eax,%eax,1)
  1004c4:	00 
  
  if((pos/80) >= 24){  // Scroll up.
  1004c5:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  1004cb:	7f 5b                	jg     100528 <consputc+0xd8>
  1004cd:	89 d8                	mov    %ebx,%eax
  1004cf:	8d 8c 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%ecx
  1004d6:	89 dd                	mov    %ebx,%ebp
  1004d8:	c1 e8 08             	shr    $0x8,%eax
  1004db:	89 c7                	mov    %eax,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1004dd:	be d4 03 00 00       	mov    $0x3d4,%esi
  1004e2:	b8 0e 00 00 00       	mov    $0xe,%eax
  1004e7:	89 f2                	mov    %esi,%edx
  1004e9:	ee                   	out    %al,(%dx)
  1004ea:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1004ef:	89 f8                	mov    %edi,%eax
  1004f1:	89 da                	mov    %ebx,%edx
  1004f3:	ee                   	out    %al,(%dx)
  1004f4:	b8 0f 00 00 00       	mov    $0xf,%eax
  1004f9:	89 f2                	mov    %esi,%edx
  1004fb:	ee                   	out    %al,(%dx)
  1004fc:	89 e8                	mov    %ebp,%eax
  1004fe:	89 da                	mov    %ebx,%edx
  100500:	ee                   	out    %al,(%dx)
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  100501:	b8 20 07 00 00       	mov    $0x720,%eax
  100506:	66 89 01             	mov    %ax,(%ecx)
      ;
  }

  uartputc(c);
  cgaputc(c);
}
  100509:	83 c4 0c             	add    $0xc,%esp
  10050c:	5b                   	pop    %ebx
  10050d:	5e                   	pop    %esi
  10050e:	5f                   	pop    %edi
  10050f:	5d                   	pop    %ebp
  100510:	c3                   	ret    
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  100511:	ba 67 66 66 66       	mov    $0x66666667,%edx
  100516:	f7 ea                	imul   %edx
  100518:	89 d0                	mov    %edx,%eax
  10051a:	c1 e8 05             	shr    $0x5,%eax
  10051d:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100520:	c1 e0 04             	shl    $0x4,%eax
  100523:	8d 58 50             	lea    0x50(%eax),%ebx
  100526:	eb 9d                	jmp    1004c5 <consputc+0x75>
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  100528:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
  10052b:	83 eb 50             	sub    $0x50,%ebx
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10052e:	68 60 0e 00 00       	push   $0xe60
  100533:	68 a0 80 0b 00       	push   $0xb80a0
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100538:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10053f:	68 00 80 0b 00       	push   $0xb8000
  100544:	89 dd                	mov    %ebx,%ebp
  100546:	e8 a5 3a 00 00       	call   103ff0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  10054b:	b8 80 07 00 00       	mov    $0x780,%eax
  100550:	83 c4 0c             	add    $0xc,%esp
  100553:	29 d8                	sub    %ebx,%eax
  100555:	01 c0                	add    %eax,%eax
  100557:	50                   	push   %eax
  100558:	6a 00                	push   $0x0
  10055a:	56                   	push   %esi
  10055b:	e8 10 3a 00 00       	call   103f70 <memset>
  100560:	89 d8                	mov    %ebx,%eax
  100562:	83 c4 10             	add    $0x10,%esp
  100565:	89 f1                	mov    %esi,%ecx
  100567:	c1 e8 08             	shr    $0x8,%eax
  10056a:	89 c7                	mov    %eax,%edi
  10056c:	e9 6c ff ff ff       	jmp    1004dd <consputc+0x8d>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  100571:	85 c0                	test   %eax,%eax
  100573:	74 15                	je     10058a <consputc+0x13a>
      crt[--pos] = ' ' | 0x0700;
  100575:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100578:	ba 20 07 00 00       	mov    $0x720,%edx
  10057d:	66 89 94 1b 00 80 0b 	mov    %dx,0xb8000(%ebx,%ebx,1)
  100584:	00 
  100585:	e9 3b ff ff ff       	jmp    1004c5 <consputc+0x75>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  10058a:	b9 00 80 0b 00       	mov    $0xb8000,%ecx
  10058f:	31 ed                	xor    %ebp,%ebp
  100591:	31 ff                	xor    %edi,%edi
  100593:	e9 45 ff ff ff       	jmp    1004dd <consputc+0x8d>
  100598:	90                   	nop
  100599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001005a0 <consolewrite>:
    release(&cons.lock);
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  1005a0:	55                   	push   %ebp
  1005a1:	57                   	push   %edi
  1005a2:	56                   	push   %esi
  1005a3:	53                   	push   %ebx
  1005a4:	83 ec 18             	sub    $0x18,%esp
  1005a7:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
  1005ab:	8b 7c 24 34          	mov    0x34(%esp),%edi
  int i;

  iunlock(ip);
  1005af:	55                   	push   %ebp
  1005b0:	e8 5b 10 00 00       	call   101610 <iunlock>
  acquire(&cons.lock);
  1005b5:	c7 04 24 e0 97 10 00 	movl   $0x1097e0,(%esp)
  1005bc:	e8 7f 37 00 00       	call   103d40 <acquire>
  for(i = 0; i < n; i++)
  1005c1:	83 c4 10             	add    $0x10,%esp
  1005c4:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  1005c8:	85 ff                	test   %edi,%edi
  1005ca:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  1005cd:	7e 17                	jle    1005e6 <consolewrite+0x46>
  1005cf:	90                   	nop
    consputc(buf[i] & 0xff);
  1005d0:	0f b6 03             	movzbl (%ebx),%eax
  1005d3:	83 ec 0c             	sub    $0xc,%esp
  1005d6:	83 c3 01             	add    $0x1,%ebx
  1005d9:	50                   	push   %eax
  1005da:	e8 71 fe ff ff       	call   100450 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
  1005df:	83 c4 10             	add    $0x10,%esp
  1005e2:	39 f3                	cmp    %esi,%ebx
  1005e4:	75 ea                	jne    1005d0 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
  1005e6:	83 ec 0c             	sub    $0xc,%esp
  1005e9:	68 e0 97 10 00       	push   $0x1097e0
  1005ee:	e8 2d 39 00 00       	call   103f20 <release>
  ilock(ip);
  1005f3:	89 2c 24             	mov    %ebp,(%esp)
  1005f6:	e8 05 0f 00 00       	call   101500 <ilock>

  return n;
}
  1005fb:	83 c4 1c             	add    $0x1c,%esp
  1005fe:	89 f8                	mov    %edi,%eax
  100600:	5b                   	pop    %ebx
  100601:	5e                   	pop    %esi
  100602:	5f                   	pop    %edi
  100603:	5d                   	pop    %ebp
  100604:	c3                   	ret    
  100605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100610 <printint>:
  cgaputc(c);
}

void
printint(int xx, int base, int sgn)
{
  100610:	55                   	push   %ebp
  100611:	57                   	push   %edi
  100612:	56                   	push   %esi
  100613:	53                   	push   %ebx
  100614:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100617:	8b 54 24 38          	mov    0x38(%esp),%edx
  cgaputc(c);
}

void
printint(int xx, int base, int sgn)
{
  10061b:	8b 44 24 30          	mov    0x30(%esp),%eax
  10061f:	8b 74 24 34          	mov    0x34(%esp),%esi
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100623:	85 d2                	test   %edx,%edx
  100625:	74 69                	je     100690 <printint+0x80>
  100627:	89 c2                	mov    %eax,%edx
  100629:	c1 ea 1f             	shr    $0x1f,%edx
  10062c:	84 d2                	test   %dl,%dl
  10062e:	74 60                	je     100690 <printint+0x80>
    neg = 1;
    x = 0 - xx;
  100630:	f7 d8                	neg    %eax
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
  100632:	bd 01 00 00 00       	mov    $0x1,%ebp
void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  100637:	31 ff                	xor    %edi,%edi
  100639:	8d 5c 24 ff          	lea    -0x1(%esp),%ebx
  10063d:	eb 03                	jmp    100642 <printint+0x32>
  10063f:	90                   	nop
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  100640:	89 cf                	mov    %ecx,%edi
  100642:	31 d2                	xor    %edx,%edx
  100644:	8d 4f 01             	lea    0x1(%edi),%ecx
  100647:	f7 f6                	div    %esi
  100649:	0f b6 92 f0 5f 10 00 	movzbl 0x105ff0(%edx),%edx
  }while((x /= base) != 0);
  100650:	85 c0                	test   %eax,%eax
  } else {
    x = xx;
  }

  do{
    buf[i++] = digits[x % base];
  100652:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
  100655:	75 e9                	jne    100640 <printint+0x30>
  if(neg)
  100657:	85 ed                	test   %ebp,%ebp
  100659:	74 07                	je     100662 <printint+0x52>
    buf[i++] = '-';
  10065b:	c6 04 0c 2d          	movb   $0x2d,(%esp,%ecx,1)
  10065f:	8d 4f 02             	lea    0x2(%edi),%ecx
  100662:	8d 74 0c ff          	lea    -0x1(%esp,%ecx,1),%esi
  100666:	8d 76 00             	lea    0x0(%esi),%esi
  100669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  while(--i >= 0)
    consputc(buf[i]);
  100670:	0f be 06             	movsbl (%esi),%eax
  100673:	83 ec 0c             	sub    $0xc,%esp
  100676:	83 ee 01             	sub    $0x1,%esi
  100679:	50                   	push   %eax
  10067a:	e8 d1 fd ff ff       	call   100450 <consputc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  10067f:	83 c4 10             	add    $0x10,%esp
  100682:	39 de                	cmp    %ebx,%esi
  100684:	75 ea                	jne    100670 <printint+0x60>
    consputc(buf[i]);
}
  100686:	83 c4 1c             	add    $0x1c,%esp
  100689:	5b                   	pop    %ebx
  10068a:	5e                   	pop    %esi
  10068b:	5f                   	pop    %edi
  10068c:	5d                   	pop    %ebp
  10068d:	c3                   	ret    
  10068e:	66 90                	xchg   %ax,%ax
void
printint(int xx, int base, int sgn)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i = 0, neg = 0;
  100690:	31 ed                	xor    %ebp,%ebp
  100692:	eb a3                	jmp    100637 <printint+0x27>
  100694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10069a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001006a0 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  1006a0:	55                   	push   %ebp
  1006a1:	57                   	push   %edi
  1006a2:	56                   	push   %esi
  1006a3:	53                   	push   %ebx
  1006a4:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  1006a7:	a1 14 98 10 00       	mov    0x109814,%eax
  if(locking)
  1006ac:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  1006ae:	89 44 24 08          	mov    %eax,0x8(%esp)
  if(locking)
  1006b2:	0f 85 68 01 00 00    	jne    100820 <cprintf+0x180>
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1006b8:	8b 74 24 30          	mov    0x30(%esp),%esi
  1006bc:	0f b6 06             	movzbl (%esi),%eax
  1006bf:	84 c0                	test   %al,%al
  1006c1:	74 7e                	je     100741 <cprintf+0xa1>
    c = fmt[i] & 0xff;
  1006c3:	8d 6c 24 34          	lea    0x34(%esp),%ebp
  1006c7:	31 db                	xor    %ebx,%ebx
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
  1006c9:	bf c6 5f 10 00       	mov    $0x105fc6,%edi
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  1006ce:	83 f8 25             	cmp    $0x25,%eax
  1006d1:	75 4f                	jne    100722 <cprintf+0x82>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1006d3:	0f b6 44 1e 01       	movzbl 0x1(%esi,%ebx,1),%eax
  1006d8:	84 c0                	test   %al,%al
  1006da:	74 5d                	je     100739 <cprintf+0x99>
      else
        consputc(c);
      break;
    
    case '%':
      switch(c){
  1006dc:	83 f8 70             	cmp    $0x70,%eax
  1006df:	0f 84 cb 00 00 00    	je     1007b0 <cprintf+0x110>
  1006e5:	7f 69                	jg     100750 <cprintf+0xb0>
  1006e7:	83 f8 25             	cmp    $0x25,%eax
  1006ea:	0f 84 d8 00 00 00    	je     1007c8 <cprintf+0x128>
  1006f0:	83 f8 64             	cmp    $0x64,%eax
  1006f3:	75 65                	jne    10075a <cprintf+0xba>
      case 'd':
        printint(*argp++, 10, 1);
  1006f5:	8d 45 04             	lea    0x4(%ebp),%eax
  1006f8:	83 ec 04             	sub    $0x4,%esp
  1006fb:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006ff:	6a 01                	push   $0x1
  100701:	6a 0a                	push   $0xa
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100703:	ff 75 00             	pushl  0x0(%ebp)
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100706:	83 c3 02             	add    $0x2,%ebx
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100709:	e8 02 ff ff ff       	call   100610 <printint>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  10070e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  100712:	83 c4 10             	add    $0x10,%esp
  100715:	84 c0                	test   %al,%al
  100717:	74 20                	je     100739 <cprintf+0x99>
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  100719:	83 f8 25             	cmp    $0x25,%eax
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
  10071c:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  100720:	74 b1                	je     1006d3 <cprintf+0x33>
        state = '%';
      else
        consputc(c);
  100722:	83 ec 0c             	sub    $0xc,%esp
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100725:	83 c3 01             	add    $0x1,%ebx
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
      else
        consputc(c);
  100728:	50                   	push   %eax
  100729:	e8 22 fd ff ff       	call   100450 <consputc>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  10072e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  100732:	83 c4 10             	add    $0x10,%esp
  100735:	84 c0                	test   %al,%al
  100737:	75 95                	jne    1006ce <cprintf+0x2e>
      state = 0;
      break;
    }
  }

  if(locking)
  100739:	8b 44 24 08          	mov    0x8(%esp),%eax
  10073d:	85 c0                	test   %eax,%eax
  10073f:	75 4d                	jne    10078e <cprintf+0xee>
    release(&cons.lock);
}
  100741:	83 c4 1c             	add    $0x1c,%esp
  100744:	5b                   	pop    %ebx
  100745:	5e                   	pop    %esi
  100746:	5f                   	pop    %edi
  100747:	5d                   	pop    %ebp
  100748:	c3                   	ret    
  100749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      else
        consputc(c);
      break;
    
    case '%':
      switch(c){
  100750:	83 f8 73             	cmp    $0x73,%eax
  100753:	74 7b                	je     1007d0 <cprintf+0x130>
  100755:	83 f8 78             	cmp    $0x78,%eax
  100758:	74 56                	je     1007b0 <cprintf+0x110>
  10075a:	89 44 24 0c          	mov    %eax,0xc(%esp)
      case '%':
        consputc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        consputc('%');
  10075e:	83 ec 0c             	sub    $0xc,%esp
  100761:	6a 25                	push   $0x25
  100763:	e8 e8 fc ff ff       	call   100450 <consputc>
        consputc(c);
  100768:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10076c:	89 04 24             	mov    %eax,(%esp)
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  10076f:	83 c3 02             	add    $0x2,%ebx
        consputc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        consputc('%');
        consputc(c);
  100772:	e8 d9 fc ff ff       	call   100450 <consputc>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100777:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  10077b:	83 c4 10             	add    $0x10,%esp
  10077e:	84 c0                	test   %al,%al
  100780:	0f 85 48 ff ff ff    	jne    1006ce <cprintf+0x2e>
      state = 0;
      break;
    }
  }

  if(locking)
  100786:	8b 44 24 08          	mov    0x8(%esp),%eax
  10078a:	85 c0                	test   %eax,%eax
  10078c:	74 b3                	je     100741 <cprintf+0xa1>
    release(&cons.lock);
  10078e:	83 ec 0c             	sub    $0xc,%esp
  100791:	68 e0 97 10 00       	push   $0x1097e0
  100796:	e8 85 37 00 00       	call   103f20 <release>
  10079b:	83 c4 10             	add    $0x10,%esp
}
  10079e:	83 c4 1c             	add    $0x1c,%esp
  1007a1:	5b                   	pop    %ebx
  1007a2:	5e                   	pop    %esi
  1007a3:	5f                   	pop    %edi
  1007a4:	5d                   	pop    %ebp
  1007a5:	c3                   	ret    
  1007a6:	8d 76 00             	lea    0x0(%esi),%esi
  1007a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  1007b0:	8d 45 04             	lea    0x4(%ebp),%eax
  1007b3:	83 ec 04             	sub    $0x4,%esp
  1007b6:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007ba:	6a 00                	push   $0x0
  1007bc:	6a 10                	push   $0x10
  1007be:	e9 40 ff ff ff       	jmp    100703 <cprintf+0x63>
  1007c3:	90                   	nop
  1007c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
        for(; *s; s++)
          consputc(*s);
        break;
      case '%':
        consputc('%');
  1007c8:	83 ec 0c             	sub    $0xc,%esp
  1007cb:	6a 25                	push   $0x25
  1007cd:	eb a0                	jmp    10076f <cprintf+0xcf>
  1007cf:	90                   	nop
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
  1007d0:	8d 45 04             	lea    0x4(%ebp),%eax
  1007d3:	8b 6d 00             	mov    0x0(%ebp),%ebp
  1007d6:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
  1007da:	85 ed                	test   %ebp,%ebp
  1007dc:	0f 44 ef             	cmove  %edi,%ebp
        for(; *s; s++)
  1007df:	0f be 45 00          	movsbl 0x0(%ebp),%eax
  1007e3:	84 c0                	test   %al,%al
  1007e5:	74 20                	je     100807 <cprintf+0x167>
  1007e7:	89 f6                	mov    %esi,%esi
  1007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
          consputc(*s);
  1007f0:	83 ec 0c             	sub    $0xc,%esp
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1007f3:	83 c5 01             	add    $0x1,%ebp
          consputc(*s);
  1007f6:	50                   	push   %eax
  1007f7:	e8 54 fc ff ff       	call   100450 <consputc>
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1007fc:	0f be 45 00          	movsbl 0x0(%ebp),%eax
  100800:	83 c4 10             	add    $0x10,%esp
  100803:	84 c0                	test   %al,%al
  100805:	75 e9                	jne    1007f0 <cprintf+0x150>
  if(locking)
    acquire(&cons.lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100807:	83 c3 02             	add    $0x2,%ebx
  10080a:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
  10080e:	84 c0                	test   %al,%al
  100810:	0f 85 03 ff ff ff    	jne    100719 <cprintf+0x79>
  100816:	e9 1e ff ff ff       	jmp    100739 <cprintf+0x99>
  10081b:	90                   	nop
  10081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
  100820:	83 ec 0c             	sub    $0xc,%esp
  100823:	68 e0 97 10 00       	push   $0x1097e0
  100828:	e8 13 35 00 00       	call   103d40 <acquire>

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  10082d:	8b 74 24 40          	mov    0x40(%esp),%esi
  100831:	83 c4 10             	add    $0x10,%esp
  100834:	0f b6 06             	movzbl (%esi),%eax
  100837:	84 c0                	test   %al,%al
  100839:	0f 85 84 fe ff ff    	jne    1006c3 <cprintf+0x23>
  10083f:	e9 4a ff ff ff       	jmp    10078e <cprintf+0xee>
  100844:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10084a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100850 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
  100850:	53                   	push   %ebx
  100851:	83 ec 24             	sub    $0x24,%esp
  100854:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  int c;

  acquire(&input.lock);
  100858:	68 e0 af 10 00       	push   $0x10afe0
  10085d:	e8 de 34 00 00       	call   103d40 <acquire>
  while((c = getc()) >= 0){
  100862:	83 c4 10             	add    $0x10,%esp
  100865:	8d 76 00             	lea    0x0(%esi),%esi
  100868:	ff d3                	call   *%ebx
  10086a:	85 c0                	test   %eax,%eax
  10086c:	0f 88 9d 00 00 00    	js     10090f <consoleintr+0xbf>
    switch(c){
  100872:	83 f8 10             	cmp    $0x10,%eax
  100875:	0f 84 a5 00 00 00    	je     100920 <consoleintr+0xd0>
  10087b:	83 f8 15             	cmp    $0x15,%eax
  10087e:	0f 84 dc 00 00 00    	je     100960 <consoleintr+0x110>
  100884:	83 f8 08             	cmp    $0x8,%eax
  100887:	0f 84 a3 00 00 00    	je     100930 <consoleintr+0xe0>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
  10088d:	85 c0                	test   %eax,%eax
  10088f:	74 d7                	je     100868 <consoleintr+0x18>
  100891:	8b 15 9c b0 10 00    	mov    0x10b09c,%edx
  100897:	89 d1                	mov    %edx,%ecx
  100899:	2b 0d 94 b0 10 00    	sub    0x10b094,%ecx
  10089f:	83 f9 7f             	cmp    $0x7f,%ecx
  1008a2:	77 c4                	ja     100868 <consoleintr+0x18>
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
  1008a4:	83 ec 0c             	sub    $0xc,%esp
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  1008a7:	8d 4a 01             	lea    0x1(%edx),%ecx
  1008aa:	83 e2 7f             	and    $0x7f,%edx
        consputc(c);
  1008ad:	50                   	push   %eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  1008ae:	88 82 14 b0 10 00    	mov    %al,0x10b014(%edx)
  1008b4:	89 0d 9c b0 10 00    	mov    %ecx,0x10b09c
        consputc(c);
  1008ba:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  1008be:	e8 8d fb ff ff       	call   100450 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  1008c3:	83 c4 10             	add    $0x10,%esp
  1008c6:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1008ca:	83 f8 0a             	cmp    $0xa,%eax
  1008cd:	0f 84 e1 00 00 00    	je     1009b4 <consoleintr+0x164>
  1008d3:	83 f8 04             	cmp    $0x4,%eax
  1008d6:	0f 84 d8 00 00 00    	je     1009b4 <consoleintr+0x164>
  1008dc:	a1 94 b0 10 00       	mov    0x10b094,%eax
  1008e1:	83 e8 80             	sub    $0xffffff80,%eax
  1008e4:	39 05 9c b0 10 00    	cmp    %eax,0x10b09c
  1008ea:	0f 85 78 ff ff ff    	jne    100868 <consoleintr+0x18>
          input.w = input.e;
          wakeup(&input.r);
  1008f0:	83 ec 0c             	sub    $0xc,%esp
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
  1008f3:	a3 98 b0 10 00       	mov    %eax,0x10b098
          wakeup(&input.r);
  1008f8:	68 94 b0 10 00       	push   $0x10b094
  1008fd:	e8 4e 30 00 00       	call   103950 <wakeup>
  100902:	83 c4 10             	add    $0x10,%esp
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  100905:	ff d3                	call   *%ebx
  100907:	85 c0                	test   %eax,%eax
  100909:	0f 89 63 ff ff ff    	jns    100872 <consoleintr+0x22>
        }
      }
      break;
    }
  }
  release(&input.lock);
  10090f:	c7 44 24 20 e0 af 10 	movl   $0x10afe0,0x20(%esp)
  100916:	00 
}
  100917:	83 c4 18             	add    $0x18,%esp
  10091a:	5b                   	pop    %ebx
        }
      }
      break;
    }
  }
  release(&input.lock);
  10091b:	e9 00 36 00 00       	jmp    103f20 <release>

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  100920:	e8 2b 33 00 00       	call   103c50 <procdump>
      break;
  100925:	e9 3e ff ff ff       	jmp    100868 <consoleintr+0x18>
  10092a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e != input.w){
  100930:	a1 9c b0 10 00       	mov    0x10b09c,%eax
  100935:	3b 05 98 b0 10 00    	cmp    0x10b098,%eax
  10093b:	0f 84 27 ff ff ff    	je     100868 <consoleintr+0x18>
        input.e--;
        consputc(BACKSPACE);
  100941:	83 ec 0c             	sub    $0xc,%esp
        consputc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e != input.w){
        input.e--;
  100944:	83 e8 01             	sub    $0x1,%eax
        consputc(BACKSPACE);
  100947:	68 00 01 00 00       	push   $0x100
        consputc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e != input.w){
        input.e--;
  10094c:	a3 9c b0 10 00       	mov    %eax,0x10b09c
        consputc(BACKSPACE);
  100951:	e8 fa fa ff ff       	call   100450 <consputc>
  100956:	83 c4 10             	add    $0x10,%esp
  100959:	e9 0a ff ff ff       	jmp    100868 <consoleintr+0x18>
  10095e:	66 90                	xchg   %ax,%ax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  100960:	a1 9c b0 10 00       	mov    0x10b09c,%eax
  100965:	39 05 98 b0 10 00    	cmp    %eax,0x10b098
  10096b:	75 31                	jne    10099e <consoleintr+0x14e>
  10096d:	e9 f6 fe ff ff       	jmp    100868 <consoleintr+0x18>
  100972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
  100978:	83 ec 0c             	sub    $0xc,%esp
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  10097b:	a3 9c b0 10 00       	mov    %eax,0x10b09c
        consputc(BACKSPACE);
  100980:	68 00 01 00 00       	push   $0x100
  100985:	e8 c6 fa ff ff       	call   100450 <consputc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  10098a:	a1 9c b0 10 00       	mov    0x10b09c,%eax
  10098f:	83 c4 10             	add    $0x10,%esp
  100992:	3b 05 98 b0 10 00    	cmp    0x10b098,%eax
  100998:	0f 84 ca fe ff ff    	je     100868 <consoleintr+0x18>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  10099e:	83 e8 01             	sub    $0x1,%eax
  1009a1:	89 c2                	mov    %eax,%edx
  1009a3:	83 e2 7f             	and    $0x7f,%edx
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
  1009a6:	80 ba 14 b0 10 00 0a 	cmpb   $0xa,0x10b014(%edx)
  1009ad:	75 c9                	jne    100978 <consoleintr+0x128>
  1009af:	e9 b4 fe ff ff       	jmp    100868 <consoleintr+0x18>
  1009b4:	a1 9c b0 10 00       	mov    0x10b09c,%eax
  1009b9:	e9 32 ff ff ff       	jmp    1008f0 <consoleintr+0xa0>
  1009be:	66 90                	xchg   %ax,%ax

001009c0 <consoleinit>:
  return target - n;
}

void
consoleinit(void)
{
  1009c0:	83 ec 14             	sub    $0x14,%esp
  initlock(&cons.lock, "console");
  1009c3:	68 cd 5f 10 00       	push   $0x105fcd
  1009c8:	68 e0 97 10 00       	push   $0x1097e0
  1009cd:	e8 4e 33 00 00       	call   103d20 <initlock>
  initlock(&input.lock, "input");
  1009d2:	58                   	pop    %eax
  1009d3:	5a                   	pop    %edx
  1009d4:	68 d5 5f 10 00       	push   $0x105fd5
  1009d9:	68 e0 af 10 00       	push   $0x10afe0
  1009de:	e8 3d 33 00 00       	call   103d20 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
  1009e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
  1009ea:	c7 05 50 ba 10 00 a0 	movl   $0x1005a0,0x10ba50
  1009f1:	05 10 00 
  devsw[CONSOLE].read = consoleread;
  1009f4:	c7 05 4c ba 10 00 40 	movl   $0x100340,0x10ba4c
  1009fb:	03 10 00 
  cons.locking = 1;
  1009fe:	c7 05 14 98 10 00 01 	movl   $0x1,0x109814
  100a05:	00 00 00 

  picenable(IRQ_KBD);
  100a08:	e8 73 22 00 00       	call   102c80 <picenable>
  ioapicenable(IRQ_KBD, 0);
  100a0d:	59                   	pop    %ecx
  100a0e:	58                   	pop    %eax
  100a0f:	6a 00                	push   $0x0
  100a11:	6a 01                	push   $0x1
  100a13:	e8 f8 18 00 00       	call   102310 <ioapicenable>
}
  100a18:	83 c4 1c             	add    $0x1c,%esp
  100a1b:	c3                   	ret    
  100a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100a20 <panic>:

void
panic(char *s)
{
  100a20:	56                   	push   %esi
  100a21:	53                   	push   %ebx
  100a22:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
  100a25:	fa                   	cli    
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
  100a26:	c7 05 14 98 10 00 00 	movl   $0x0,0x109814
  100a2d:	00 00 00 
  cprintf("cpu%d: panic: ", cpu());
  100a30:	e8 0b 1d 00 00       	call   102740 <cpu>
  100a35:	83 ec 08             	sub    $0x8,%esp
  100a38:	50                   	push   %eax
  100a39:	68 db 5f 10 00       	push   $0x105fdb
  100a3e:	e8 5d fc ff ff       	call   1006a0 <cprintf>
  cprintf(s);
  100a43:	58                   	pop    %eax
  100a44:	ff 74 24 4c          	pushl  0x4c(%esp)
  100a48:	e8 53 fc ff ff       	call   1006a0 <cprintf>
  cprintf("\n");
  100a4d:	c7 04 24 43 64 10 00 	movl   $0x106443,(%esp)
  100a54:	e8 47 fc ff ff       	call   1006a0 <cprintf>
  getcallerpcs(&s, pcs);
  100a59:	5a                   	pop    %edx
  100a5a:	59                   	pop    %ecx
  100a5b:	8d 5c 24 10          	lea    0x10(%esp),%ebx
  100a5f:	53                   	push   %ebx
  100a60:	8d 44 24 4c          	lea    0x4c(%esp),%eax
  100a64:	50                   	push   %eax
  100a65:	e8 b6 33 00 00       	call   103e20 <getcallerpcs>
  100a6a:	8d 74 24 40          	lea    0x40(%esp),%esi
  100a6e:	83 c4 10             	add    $0x10,%esp
  100a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100a78:	83 ec 08             	sub    $0x8,%esp
  100a7b:	ff 33                	pushl  (%ebx)
  100a7d:	83 c3 04             	add    $0x4,%ebx
  100a80:	68 ea 5f 10 00       	push   $0x105fea
  100a85:	e8 16 fc ff ff       	call   1006a0 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  100a8a:	83 c4 10             	add    $0x10,%esp
  100a8d:	39 f3                	cmp    %esi,%ebx
  100a8f:	75 e7                	jne    100a78 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  100a91:	c7 05 c0 97 10 00 01 	movl   $0x1,0x1097c0
  100a98:	00 00 00 
  100a9b:	eb fe                	jmp    100a9b <panic+0x7b>
  100a9d:	66 90                	xchg   %ax,%ax
  100a9f:	90                   	nop

00100aa0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  100aa0:	55                   	push   %ebp
  100aa1:	57                   	push   %edi
  100aa2:	56                   	push   %esi
  100aa3:	53                   	push   %ebx
  100aa4:	81 ec 98 00 00 00    	sub    $0x98,%esp
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  100aaa:	ff b4 24 ac 00 00 00 	pushl  0xac(%esp)
  100ab1:	e8 6a 14 00 00       	call   101f20 <namei>
  100ab6:	83 c4 10             	add    $0x10,%esp
  100ab9:	85 c0                	test   %eax,%eax
  100abb:	0f 84 a2 03 00 00    	je     100e63 <exec+0x3c3>
    return -1;
  ilock(ip);
  100ac1:	83 ec 0c             	sub    $0xc,%esp
  100ac4:	89 c3                	mov    %eax,%ebx
  100ac6:	50                   	push   %eax
  100ac7:	e8 34 0a 00 00       	call   101500 <ilock>
  // Compute memory size of new process.
  mem = 0;
  sz = 0;

  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  100acc:	6a 34                	push   $0x34
  100ace:	6a 00                	push   $0x0
  100ad0:	8d 44 24 64          	lea    0x64(%esp),%eax
  100ad4:	50                   	push   %eax
  100ad5:	53                   	push   %ebx
  100ad6:	e8 75 0e 00 00       	call   101950 <readi>
  100adb:	83 c4 20             	add    $0x20,%esp
  100ade:	83 f8 33             	cmp    $0x33,%eax
  100ae1:	0f 86 2c 03 00 00    	jbe    100e13 <exec+0x373>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  100ae7:	81 7c 24 4c 7f 45 4c 	cmpl   $0x464c457f,0x4c(%esp)
  100aee:	46 
  100aef:	0f 85 1e 03 00 00    	jne    100e13 <exec+0x373>
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100af5:	66 83 7c 24 78 00    	cmpw   $0x0,0x78(%esp)
  100afb:	8b 6c 24 68          	mov    0x68(%esp),%ebp
  100aff:	0f 84 54 03 00 00    	je     100e59 <exec+0x3b9>
  100b05:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100b0c:	00 
  100b0d:	31 ff                	xor    %edi,%edi
  100b0f:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  100b13:	eb 12                	jmp    100b27 <exec+0x87>
  100b15:	8d 76 00             	lea    0x0(%esi),%esi
  100b18:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100b1d:	83 c7 01             	add    $0x1,%edi
  100b20:	83 c5 20             	add    $0x20,%ebp
  100b23:	39 f8                	cmp    %edi,%eax
  100b25:	7e 3e                	jle    100b65 <exec+0xc5>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100b27:	6a 20                	push   $0x20
  100b29:	55                   	push   %ebp
  100b2a:	56                   	push   %esi
  100b2b:	53                   	push   %ebx
  100b2c:	e8 1f 0e 00 00       	call   101950 <readi>
  100b31:	83 c4 10             	add    $0x10,%esp
  100b34:	83 f8 20             	cmp    $0x20,%eax
  100b37:	0f 85 d6 02 00 00    	jne    100e13 <exec+0x373>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100b3d:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
  100b42:	75 d4                	jne    100b18 <exec+0x78>
      continue;
    if(ph.memsz < ph.filesz)
  100b44:	8b 44 24 40          	mov    0x40(%esp),%eax
  100b48:	3b 44 24 3c          	cmp    0x3c(%esp),%eax
  100b4c:	0f 82 c1 02 00 00    	jb     100e13 <exec+0x373>
      goto bad;
    sz += ph.memsz;
  100b52:	01 44 24 08          	add    %eax,0x8(%esp)
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100b56:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100b5b:	83 c7 01             	add    $0x1,%edi
  100b5e:	83 c5 20             	add    $0x20,%ebp
  100b61:	39 f8                	cmp    %edi,%eax
  100b63:	7f c2                	jg     100b27 <exec+0x87>
  100b65:	8b 74 24 08          	mov    0x8(%esp),%esi
  100b69:	81 c6 ff 1f 00 00    	add    $0x1fff,%esi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100b6f:	8b 84 24 a4 00 00 00 	mov    0xa4(%esp),%eax
  100b76:	8b 00                	mov    (%eax),%eax
  100b78:	85 c0                	test   %eax,%eax
  100b7a:	0f 84 af 02 00 00    	je     100e2f <exec+0x38f>
  100b80:	89 74 24 08          	mov    %esi,0x8(%esp)
  100b84:	31 ff                	xor    %edi,%edi
  100b86:	31 ed                	xor    %ebp,%ebp
  100b88:	8b b4 24 a4 00 00 00 	mov    0xa4(%esp),%esi
  100b8f:	eb 09                	jmp    100b9a <exec+0xfa>
  100b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  100b98:	89 d5                	mov    %edx,%ebp
    arglen += strlen(argv[argc]) + 1;
  100b9a:	83 ec 0c             	sub    $0xc,%esp
  100b9d:	50                   	push   %eax
  100b9e:	e8 bd 35 00 00       	call   104160 <strlen>
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ba3:	8d 55 01             	lea    0x1(%ebp),%edx
    arglen += strlen(argv[argc]) + 1;
  100ba6:	8d 7c 38 01          	lea    0x1(%eax,%edi,1),%edi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100baa:	83 c4 10             	add    $0x10,%esp
  100bad:	8b 04 96             	mov    (%esi,%edx,4),%eax
  100bb0:	85 c0                	test   %eax,%eax
  100bb2:	75 e4                	jne    100b98 <exec+0xf8>
  100bb4:	83 c7 03             	add    $0x3,%edi
  100bb7:	8d 0c ad 08 00 00 00 	lea    0x8(,%ebp,4),%ecx
  100bbe:	8b 74 24 08          	mov    0x8(%esp),%esi
  100bc2:	83 e7 fc             	and    $0xfffffffc,%edi
  100bc5:	89 54 24 10          	mov    %edx,0x10(%esp)
  100bc9:	89 54 24 14          	mov    %edx,0x14(%esp)
  100bcd:	89 f8                	mov    %edi,%eax
  100bcf:	89 7c 24 18          	mov    %edi,0x18(%esp)
  100bd3:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  100bd7:	01 c8                	add    %ecx,%eax

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100bd9:	01 c6                	add    %eax,%esi
  mem = kalloc(sz);
  100bdb:	83 ec 0c             	sub    $0xc,%esp

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100bde:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  100be4:	89 74 24 18          	mov    %esi,0x18(%esp)
  mem = kalloc(sz);
  100be8:	56                   	push   %esi
  100be9:	e8 a2 18 00 00       	call   102490 <kalloc>
  100bee:	89 44 24 18          	mov    %eax,0x18(%esp)
  if(mem == 0)
  100bf2:	83 c4 10             	add    $0x10,%esp
  100bf5:	85 c0                	test   %eax,%eax
  100bf7:	0f 84 16 02 00 00    	je     100e13 <exec+0x373>
    goto bad;
  memset(mem, 0, sz);
  100bfd:	83 ec 04             	sub    $0x4,%esp
  100c00:	56                   	push   %esi
  100c01:	6a 00                	push   $0x0
  100c03:	50                   	push   %eax
  100c04:	e8 67 33 00 00       	call   103f70 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100c09:	8b 7c 24 78          	mov    0x78(%esp),%edi
  100c0d:	83 c4 10             	add    $0x10,%esp
  100c10:	66 83 7c 24 78 00    	cmpw   $0x0,0x78(%esp)
  100c16:	0f 84 b1 00 00 00    	je     100ccd <exec+0x22d>
  100c1c:	31 ed                	xor    %ebp,%ebp
  100c1e:	8d 74 24 2c          	lea    0x2c(%esp),%esi
  100c22:	eb 17                	jmp    100c3b <exec+0x19b>
  100c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100c28:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100c2d:	83 c5 01             	add    $0x1,%ebp
  100c30:	83 c7 20             	add    $0x20,%edi
  100c33:	39 e8                	cmp    %ebp,%eax
  100c35:	0f 8e 92 00 00 00    	jle    100ccd <exec+0x22d>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100c3b:	6a 20                	push   $0x20
  100c3d:	57                   	push   %edi
  100c3e:	56                   	push   %esi
  100c3f:	53                   	push   %ebx
  100c40:	e8 0b 0d 00 00       	call   101950 <readi>
  100c45:	83 c4 10             	add    $0x10,%esp
  100c48:	83 f8 20             	cmp    $0x20,%eax
  100c4b:	0f 85 af 01 00 00    	jne    100e00 <exec+0x360>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100c51:	83 7c 24 2c 01       	cmpl   $0x1,0x2c(%esp)
  100c56:	75 d0                	jne    100c28 <exec+0x188>
      continue;
    if(ph.va + ph.memsz < ph.va || ph.va + ph.memsz > sz || ph.memsz < ph.filesz)
  100c58:	8b 44 24 34          	mov    0x34(%esp),%eax
  100c5c:	8b 54 24 40          	mov    0x40(%esp),%edx
  100c60:	89 c1                	mov    %eax,%ecx
  100c62:	01 d1                	add    %edx,%ecx
  100c64:	0f 82 96 01 00 00    	jb     100e00 <exec+0x360>
  100c6a:	39 4c 24 0c          	cmp    %ecx,0xc(%esp)
  100c6e:	0f 82 8c 01 00 00    	jb     100e00 <exec+0x360>
  100c74:	8b 4c 24 3c          	mov    0x3c(%esp),%ecx
  100c78:	39 ca                	cmp    %ecx,%edx
  100c7a:	0f 82 80 01 00 00    	jb     100e00 <exec+0x360>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  100c80:	51                   	push   %ecx
  100c81:	ff 74 24 34          	pushl  0x34(%esp)
  100c85:	03 44 24 10          	add    0x10(%esp),%eax
  100c89:	50                   	push   %eax
  100c8a:	53                   	push   %ebx
  100c8b:	e8 c0 0c 00 00       	call   101950 <readi>
  100c90:	83 c4 10             	add    $0x10,%esp
  100c93:	3b 44 24 3c          	cmp    0x3c(%esp),%eax
  100c97:	0f 85 63 01 00 00    	jne    100e00 <exec+0x360>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100c9d:	83 ec 04             	sub    $0x4,%esp
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100ca0:	83 c5 01             	add    $0x1,%ebp
  100ca3:	83 c7 20             	add    $0x20,%edi
      continue;
    if(ph.va + ph.memsz < ph.va || ph.va + ph.memsz > sz || ph.memsz < ph.filesz)
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100ca6:	8b 4c 24 44          	mov    0x44(%esp),%ecx
  100caa:	29 c1                	sub    %eax,%ecx
  100cac:	51                   	push   %ecx
  100cad:	6a 00                	push   $0x0
  100caf:	03 44 24 40          	add    0x40(%esp),%eax
  100cb3:	03 44 24 14          	add    0x14(%esp),%eax
  100cb7:	50                   	push   %eax
  100cb8:	e8 b3 32 00 00       	call   103f70 <memset>
  100cbd:	83 c4 10             	add    $0x10,%esp
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100cc0:	0f b7 44 24 78       	movzwl 0x78(%esp),%eax
  100cc5:	39 e8                	cmp    %ebp,%eax
  100cc7:	0f 8f 6e ff ff ff    	jg     100c3b <exec+0x19b>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  }
  iunlockput(ip);
  100ccd:	83 ec 0c             	sub    $0xc,%esp
  100cd0:	53                   	push   %ebx
  100cd1:	e8 2a 0c 00 00       	call   101900 <iunlockput>
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100cd6:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100cda:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  100cde:	8b 54 24 18          	mov    0x18(%esp),%edx
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100ce2:	89 df                	mov    %ebx,%edi
  100ce4:	2b 7c 24 28          	sub    0x28(%esp),%edi

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100ce8:	8d 69 ff             	lea    -0x1(%ecx),%ebp
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100ceb:	2b 7c 24 2c          	sub    0x2c(%esp),%edi

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100cef:	8d 04 8a             	lea    (%edx,%ecx,4),%eax
  for(i=argc-1; i>=0; i--){
  100cf2:	83 c4 10             	add    $0x10,%esp
  100cf5:	83 fd ff             	cmp    $0xffffffff,%ebp
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100cf8:	c7 04 38 00 00 00 00 	movl   $0x0,(%eax,%edi,1)
  100cff:	8d 34 3a             	lea    (%edx,%edi,1),%esi
  for(i=argc-1; i>=0; i--){
  100d02:	74 4a                	je     100d4e <exec+0x2ae>
  100d04:	89 7c 24 14          	mov    %edi,0x14(%esp)
  100d08:	8b bc 24 a4 00 00 00 	mov    0xa4(%esp),%edi
  100d0f:	89 f0                	mov    %esi,%eax
  100d11:	89 ee                	mov    %ebp,%esi
  100d13:	89 c5                	mov    %eax,%ebp
  100d15:	8d 76 00             	lea    0x0(%esi),%esi
    len = strlen(argv[i]) + 1;
  100d18:	83 ec 0c             	sub    $0xc,%esp
  100d1b:	ff 34 b7             	pushl  (%edi,%esi,4)
  100d1e:	e8 3d 34 00 00       	call   104160 <strlen>
    sp -= len;
    memmove(mem+sp, argv[i], len);
  100d23:	83 c4 0c             	add    $0xc,%esp

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
    len = strlen(argv[i]) + 1;
    sp -= len;
  100d26:	83 c0 01             	add    $0x1,%eax
    memmove(mem+sp, argv[i], len);
  100d29:	50                   	push   %eax

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
    len = strlen(argv[i]) + 1;
    sp -= len;
  100d2a:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp, argv[i], len);
  100d2c:	ff 34 b7             	pushl  (%edi,%esi,4)
  100d2f:	8b 44 24 14          	mov    0x14(%esp),%eax
  100d33:	01 d8                	add    %ebx,%eax
  100d35:	50                   	push   %eax
  100d36:	e8 b5 32 00 00       	call   103ff0 <memmove>
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  100d3b:	89 5c b5 00          	mov    %ebx,0x0(%ebp,%esi,4)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100d3f:	83 ee 01             	sub    $0x1,%esi
  100d42:	83 c4 10             	add    $0x10,%esp
  100d45:	83 fe ff             	cmp    $0xffffffff,%esi
  100d48:	75 ce                	jne    100d18 <exec+0x278>
  100d4a:	8b 7c 24 14          	mov    0x14(%esp),%edi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100d4e:	8b 44 24 08          	mov    0x8(%esp),%eax
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100d52:	8b 54 24 10          	mov    0x10(%esp),%edx
  sp -= 4;
  100d56:	8d 5f f4             	lea    -0xc(%edi),%ebx
  100d59:	8b 8c 24 a0 00 00 00 	mov    0xa0(%esp),%ecx
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100d60:	89 7c 38 fc          	mov    %edi,-0x4(%eax,%edi,1)
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100d64:	89 54 38 f8          	mov    %edx,-0x8(%eax,%edi,1)
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  100d68:	c7 44 38 f4 ff ff ff 	movl   $0xffffffff,-0xc(%eax,%edi,1)
  100d6f:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100d70:	8b 84 24 a0 00 00 00 	mov    0xa0(%esp),%eax
  100d77:	0f b6 10             	movzbl (%eax),%edx
  100d7a:	83 c0 01             	add    $0x1,%eax
  100d7d:	84 d2                	test   %dl,%dl
  100d7f:	74 1e                	je     100d9f <exec+0x2ff>
  100d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(*s == '/')
      last = s+1;
  100d88:	80 fa 2f             	cmp    $0x2f,%dl
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100d8b:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
  100d8e:	0f 44 c8             	cmove  %eax,%ecx
  100d91:	83 c0 01             	add    $0x1,%eax
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100d94:	84 d2                	test   %dl,%dl
  100d96:	75 f0                	jne    100d88 <exec+0x2e8>
  100d98:	89 8c 24 a0 00 00 00 	mov    %ecx,0xa0(%esp)
    if(*s == '/')
      last = s+1;
  safestrcpy(cp->name, last, sizeof(cp->name));
  100d9f:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  100da5:	83 ec 04             	sub    $0x4,%esp
  100da8:	6a 10                	push   $0x10
  100daa:	ff b4 24 a8 00 00 00 	pushl  0xa8(%esp)
  100db1:	65 8b 06             	mov    %gs:(%esi),%eax
  100db4:	83 c0 6c             	add    $0x6c,%eax
  100db7:	50                   	push   %eax
  100db8:	e8 63 33 00 00       	call   104120 <safestrcpy>

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  100dbd:	65 8b 06             	mov    %gs:(%esi),%eax
  100dc0:	5a                   	pop    %edx
  100dc1:	59                   	pop    %ecx
  100dc2:	ff 70 04             	pushl  0x4(%eax)
  100dc5:	ff 30                	pushl  (%eax)
  100dc7:	e8 74 15 00 00       	call   102340 <kfree>
  cp->mem = mem;
  100dcc:	65 8b 06             	mov    %gs:(%esi),%eax
  100dcf:	8b 54 24 18          	mov    0x18(%esp),%edx
  100dd3:	89 10                	mov    %edx,(%eax)
  cp->sz = sz;
  100dd5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  100dd9:	89 50 04             	mov    %edx,0x4(%eax)
  cp->tf->eip = elf.entry;  // main
  100ddc:	8b 40 18             	mov    0x18(%eax),%eax
  100ddf:	8b 54 24 74          	mov    0x74(%esp),%edx
  cp->tf->esp = sp;
  100de3:	89 58 44             	mov    %ebx,0x44(%eax)

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  cp->mem = mem;
  cp->sz = sz;
  cp->tf->eip = elf.entry;  // main
  100de6:	89 50 38             	mov    %edx,0x38(%eax)
  cp->tf->esp = sp;
  usegment();
  100de9:	e8 92 25 00 00       	call   103380 <usegment>
  return 0;
  100dee:	83 c4 10             	add    $0x10,%esp
  100df1:	31 c0                	xor    %eax,%eax
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  100df3:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  100df9:	5b                   	pop    %ebx
  100dfa:	5e                   	pop    %esi
  100dfb:	5f                   	pop    %edi
  100dfc:	5d                   	pop    %ebp
  100dfd:	c3                   	ret    
  100dfe:	66 90                	xchg   %ax,%ax
  usegment();
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  100e00:	83 ec 08             	sub    $0x8,%esp
  100e03:	ff 74 24 14          	pushl  0x14(%esp)
  100e07:	ff 74 24 14          	pushl  0x14(%esp)
  100e0b:	e8 30 15 00 00       	call   102340 <kfree>
  100e10:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
  100e13:	83 ec 0c             	sub    $0xc,%esp
  100e16:	53                   	push   %ebx
  100e17:	e8 e4 0a 00 00       	call   101900 <iunlockput>
  return -1;
  100e1c:	83 c4 10             	add    $0x10,%esp
  100e1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  100e24:	81 c4 8c 00 00 00    	add    $0x8c,%esp
  100e2a:	5b                   	pop    %ebx
  100e2b:	5e                   	pop    %esi
  100e2c:	5f                   	pop    %edi
  100e2d:	5d                   	pop    %ebp
  100e2e:	c3                   	ret    
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100e2f:	b8 04 00 00 00       	mov    $0x4,%eax
  100e34:	c7 44 24 1c 04 00 00 	movl   $0x4,0x1c(%esp)
  100e3b:	00 
  100e3c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  100e43:	00 
  100e44:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100e4b:	00 
  100e4c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100e53:	00 
  100e54:	e9 80 fd ff ff       	jmp    100bd9 <exec+0x139>
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100e59:	be ff 1f 00 00       	mov    $0x1fff,%esi
  100e5e:	e9 0c fd ff ff       	jmp    100b6f <exec+0xcf>
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
    return -1;
  100e63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e68:	eb ba                	jmp    100e24 <exec+0x384>
  100e6a:	66 90                	xchg   %ax,%ax
  100e6c:	66 90                	xchg   %ax,%ax
  100e6e:	66 90                	xchg   %ax,%ax

00100e70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  100e70:	83 ec 14             	sub    $0x14,%esp
  initlock(&ftable.lock, "ftable");
  100e73:	68 01 60 10 00       	push   $0x106001
  100e78:	68 a0 b0 10 00       	push   $0x10b0a0
  100e7d:	e8 9e 2e 00 00       	call   103d20 <initlock>
}
  100e82:	83 c4 1c             	add    $0x1c,%esp
  100e85:	c3                   	ret    
  100e86:	8d 76 00             	lea    0x0(%esi),%esi
  100e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e90:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100e91:	bb d4 b0 10 00       	mov    $0x10b0d4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100e96:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
  100e99:	68 a0 b0 10 00       	push   $0x10b0a0
  100e9e:	e8 9d 2e 00 00       	call   103d40 <acquire>
  100ea3:	83 c4 10             	add    $0x10,%esp
  100ea6:	eb 13                	jmp    100ebb <filealloc+0x2b>
  100ea8:	90                   	nop
  100ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
  100eb0:	83 c3 18             	add    $0x18,%ebx
  100eb3:	81 fb 34 ba 10 00    	cmp    $0x10ba34,%ebx
  100eb9:	74 25                	je     100ee0 <filealloc+0x50>
    if(f->ref == 0){
  100ebb:	8b 43 04             	mov    0x4(%ebx),%eax
  100ebe:	85 c0                	test   %eax,%eax
  100ec0:	75 ee                	jne    100eb0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
  100ec2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
  100ec5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
  100ecc:	68 a0 b0 10 00       	push   $0x10b0a0
  100ed1:	e8 4a 30 00 00       	call   103f20 <release>
      return f;
  100ed6:	83 c4 10             	add    $0x10,%esp
  100ed9:	89 d8                	mov    %ebx,%eax
    }
  }
  release(&ftable.lock);
  return 0;
}
  100edb:	83 c4 08             	add    $0x8,%esp
  100ede:	5b                   	pop    %ebx
  100edf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  100ee0:	83 ec 0c             	sub    $0xc,%esp
  100ee3:	68 a0 b0 10 00       	push   $0x10b0a0
  100ee8:	e8 33 30 00 00       	call   103f20 <release>
  return 0;
  100eed:	83 c4 10             	add    $0x10,%esp
  100ef0:	31 c0                	xor    %eax,%eax
}
  100ef2:	83 c4 08             	add    $0x8,%esp
  100ef5:	5b                   	pop    %ebx
  100ef6:	c3                   	ret    
  100ef7:	89 f6                	mov    %esi,%esi
  100ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f00 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100f00:	53                   	push   %ebx
  100f01:	83 ec 14             	sub    $0x14,%esp
  100f04:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&ftable.lock);
  100f08:	68 a0 b0 10 00       	push   $0x10b0a0
  100f0d:	e8 2e 2e 00 00       	call   103d40 <acquire>
  if(f->ref < 1)
  100f12:	8b 43 04             	mov    0x4(%ebx),%eax
  100f15:	83 c4 10             	add    $0x10,%esp
  100f18:	85 c0                	test   %eax,%eax
  100f1a:	7e 1a                	jle    100f36 <filedup+0x36>
    panic("filedup");
  f->ref++;
  100f1c:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
  100f1f:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
  100f22:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
  100f25:	68 a0 b0 10 00       	push   $0x10b0a0
  100f2a:	e8 f1 2f 00 00       	call   103f20 <release>
  return f;
}
  100f2f:	83 c4 18             	add    $0x18,%esp
  100f32:	89 d8                	mov    %ebx,%eax
  100f34:	5b                   	pop    %ebx
  100f35:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  100f36:	83 ec 0c             	sub    $0xc,%esp
  100f39:	68 08 60 10 00       	push   $0x106008
  100f3e:	e8 dd fa ff ff       	call   100a20 <panic>
  100f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f50 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  100f50:	55                   	push   %ebp
  100f51:	57                   	push   %edi
  100f52:	56                   	push   %esi
  100f53:	53                   	push   %ebx
  100f54:	83 ec 28             	sub    $0x28,%esp
  100f57:	8b 5c 24 3c          	mov    0x3c(%esp),%ebx
  struct file ff;

  acquire(&ftable.lock);
  100f5b:	68 a0 b0 10 00       	push   $0x10b0a0
  100f60:	e8 db 2d 00 00       	call   103d40 <acquire>
  if(f->ref < 1)
  100f65:	8b 43 04             	mov    0x4(%ebx),%eax
  100f68:	83 c4 10             	add    $0x10,%esp
  100f6b:	85 c0                	test   %eax,%eax
  100f6d:	0f 8e 85 00 00 00    	jle    100ff8 <fileclose+0xa8>
    panic("fileclose");
  if(--f->ref > 0){
  100f73:	83 e8 01             	sub    $0x1,%eax
  100f76:	85 c0                	test   %eax,%eax
  100f78:	89 43 04             	mov    %eax,0x4(%ebx)
  100f7b:	74 1b                	je     100f98 <fileclose+0x48>
    release(&ftable.lock);
  100f7d:	c7 44 24 30 a0 b0 10 	movl   $0x10b0a0,0x30(%esp)
  100f84:	00 
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
}
  100f85:	83 c4 1c             	add    $0x1c,%esp
  100f88:	5b                   	pop    %ebx
  100f89:	5e                   	pop    %esi
  100f8a:	5f                   	pop    %edi
  100f8b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
  100f8c:	e9 8f 2f 00 00       	jmp    103f20 <release>
  100f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
  100f98:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  100f9c:	8b 33                	mov    (%ebx),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  100f9e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
  100fa1:	8b 7b 0c             	mov    0xc(%ebx),%edi
  100fa4:	8b 6b 10             	mov    0x10(%ebx),%ebp
  f->ref = 0;
  f->type = FD_NONE;
  100fa7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
  100fad:	88 44 24 1b          	mov    %al,0x1b(%esp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  100fb1:	68 a0 b0 10 00       	push   $0x10b0a0
  100fb6:	e8 65 2f 00 00       	call   103f20 <release>
  
  if(ff.type == FD_PIPE)
  100fbb:	83 c4 10             	add    $0x10,%esp
  100fbe:	83 fe 01             	cmp    $0x1,%esi
  100fc1:	74 0d                	je     100fd0 <fileclose+0x80>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  100fc3:	83 fe 02             	cmp    $0x2,%esi
  100fc6:	74 20                	je     100fe8 <fileclose+0x98>
    iput(ff.ip);
}
  100fc8:	83 c4 1c             	add    $0x1c,%esp
  100fcb:	5b                   	pop    %ebx
  100fcc:	5e                   	pop    %esi
  100fcd:	5f                   	pop    %edi
  100fce:	5d                   	pop    %ebp
  100fcf:	c3                   	ret    
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  100fd0:	83 ec 08             	sub    $0x8,%esp
  100fd3:	0f be 74 24 17       	movsbl 0x17(%esp),%esi
  100fd8:	56                   	push   %esi
  100fd9:	57                   	push   %edi
  100fda:	e8 61 1e 00 00       	call   102e40 <pipeclose>
  100fdf:	83 c4 10             	add    $0x10,%esp
  100fe2:	eb e4                	jmp    100fc8 <fileclose+0x78>
  100fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100fe8:	89 6c 24 30          	mov    %ebp,0x30(%esp)
}
  100fec:	83 c4 1c             	add    $0x1c,%esp
  100fef:	5b                   	pop    %ebx
  100ff0:	5e                   	pop    %esi
  100ff1:	5f                   	pop    %edi
  100ff2:	5d                   	pop    %ebp
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  100ff3:	e9 a8 07 00 00       	jmp    1017a0 <iput>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  100ff8:	83 ec 0c             	sub    $0xc,%esp
  100ffb:	68 10 60 10 00       	push   $0x106010
  101000:	e8 1b fa ff ff       	call   100a20 <panic>
  101005:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101010 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct statv6 *st)
{
  101010:	53                   	push   %ebx
  101011:	83 ec 08             	sub    $0x8,%esp
  101014:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(f->type == FD_INODE){
  101018:	83 3b 02             	cmpl   $0x2,(%ebx)
  10101b:	75 33                	jne    101050 <filestat+0x40>
    ilock(f->ip);
  10101d:	83 ec 0c             	sub    $0xc,%esp
  101020:	ff 73 10             	pushl  0x10(%ebx)
  101023:	e8 d8 04 00 00       	call   101500 <ilock>
    stati(f->ip, st);
  101028:	58                   	pop    %eax
  101029:	5a                   	pop    %edx
  10102a:	ff 74 24 1c          	pushl  0x1c(%esp)
  10102e:	ff 73 10             	pushl  0x10(%ebx)
  101031:	e8 ea 08 00 00       	call   101920 <stati>
    iunlock(f->ip);
  101036:	59                   	pop    %ecx
  101037:	ff 73 10             	pushl  0x10(%ebx)
  10103a:	e8 d1 05 00 00       	call   101610 <iunlock>
    return 0;
  10103f:	83 c4 10             	add    $0x10,%esp
  101042:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
  101044:	83 c4 08             	add    $0x8,%esp
  101047:	5b                   	pop    %ebx
  101048:	c3                   	ret    
  101049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101050:	83 c4 08             	add    $0x8,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
  101053:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101058:	5b                   	pop    %ebx
  101059:	c3                   	ret    
  10105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101060 <fileread>:

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  101060:	57                   	push   %edi
  101061:	56                   	push   %esi
  101062:	53                   	push   %ebx
  101063:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  101067:	8b 74 24 14          	mov    0x14(%esp),%esi
  10106b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->readable == 0)
  10106f:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  101073:	74 5b                	je     1010d0 <fileread+0x70>
    return -1;
  if(f->type == FD_PIPE)
  101075:	8b 03                	mov    (%ebx),%eax
  101077:	83 f8 01             	cmp    $0x1,%eax
  10107a:	74 44                	je     1010c0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  10107c:	83 f8 02             	cmp    $0x2,%eax
  10107f:	75 56                	jne    1010d7 <fileread+0x77>
    ilock(f->ip);
  101081:	83 ec 0c             	sub    $0xc,%esp
  101084:	ff 73 10             	pushl  0x10(%ebx)
  101087:	e8 74 04 00 00       	call   101500 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  10108c:	57                   	push   %edi
  10108d:	ff 73 14             	pushl  0x14(%ebx)
  101090:	56                   	push   %esi
  101091:	ff 73 10             	pushl  0x10(%ebx)
  101094:	e8 b7 08 00 00       	call   101950 <readi>
  101099:	83 c4 20             	add    $0x20,%esp
  10109c:	85 c0                	test   %eax,%eax
  10109e:	89 c6                	mov    %eax,%esi
  1010a0:	7e 03                	jle    1010a5 <fileread+0x45>
      f->off += r;
  1010a2:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  1010a5:	83 ec 0c             	sub    $0xc,%esp
  1010a8:	ff 73 10             	pushl  0x10(%ebx)
  1010ab:	e8 60 05 00 00       	call   101610 <iunlock>
    return r;
  1010b0:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  1010b3:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  1010b5:	5b                   	pop    %ebx
  1010b6:	5e                   	pop    %esi
  1010b7:	5f                   	pop    %edi
  1010b8:	c3                   	ret    
  1010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  1010c0:	8b 43 0c             	mov    0xc(%ebx),%eax
  1010c3:	89 44 24 10          	mov    %eax,0x10(%esp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  1010c7:	5b                   	pop    %ebx
  1010c8:	5e                   	pop    %esi
  1010c9:	5f                   	pop    %edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  1010ca:	e9 41 1f 00 00       	jmp    103010 <piperead>
  1010cf:	90                   	nop
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
  1010d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1010d5:	eb de                	jmp    1010b5 <fileread+0x55>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  1010d7:	83 ec 0c             	sub    $0xc,%esp
  1010da:	68 1a 60 10 00       	push   $0x10601a
  1010df:	e8 3c f9 ff ff       	call   100a20 <panic>
  1010e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1010ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001010f0 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  1010f0:	57                   	push   %edi
  1010f1:	56                   	push   %esi
  1010f2:	53                   	push   %ebx
  1010f3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1010f7:	8b 74 24 14          	mov    0x14(%esp),%esi
  1010fb:	8b 7c 24 18          	mov    0x18(%esp),%edi
  int r;

  if(f->writable == 0)
  1010ff:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  101103:	74 5b                	je     101160 <filewrite+0x70>
    return -1;
  if(f->type == FD_PIPE)
  101105:	8b 03                	mov    (%ebx),%eax
  101107:	83 f8 01             	cmp    $0x1,%eax
  10110a:	74 44                	je     101150 <filewrite+0x60>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  10110c:	83 f8 02             	cmp    $0x2,%eax
  10110f:	75 56                	jne    101167 <filewrite+0x77>
    ilock(f->ip);
  101111:	83 ec 0c             	sub    $0xc,%esp
  101114:	ff 73 10             	pushl  0x10(%ebx)
  101117:	e8 e4 03 00 00       	call   101500 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  10111c:	57                   	push   %edi
  10111d:	ff 73 14             	pushl  0x14(%ebx)
  101120:	56                   	push   %esi
  101121:	ff 73 10             	pushl  0x10(%ebx)
  101124:	e8 37 09 00 00       	call   101a60 <writei>
  101129:	83 c4 20             	add    $0x20,%esp
  10112c:	85 c0                	test   %eax,%eax
  10112e:	89 c6                	mov    %eax,%esi
  101130:	7e 03                	jle    101135 <filewrite+0x45>
      f->off += r;
  101132:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  101135:	83 ec 0c             	sub    $0xc,%esp
  101138:	ff 73 10             	pushl  0x10(%ebx)
  10113b:	e8 d0 04 00 00       	call   101610 <iunlock>
    return r;
  101140:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  101143:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  101145:	5b                   	pop    %ebx
  101146:	5e                   	pop    %esi
  101147:	5f                   	pop    %edi
  101148:	c3                   	ret    
  101149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  101150:	8b 43 0c             	mov    0xc(%ebx),%eax
  101153:	89 44 24 10          	mov    %eax,0x10(%esp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  101157:	5b                   	pop    %ebx
  101158:	5e                   	pop    %esi
  101159:	5f                   	pop    %edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  10115a:	e9 71 1d 00 00       	jmp    102ed0 <pipewrite>
  10115f:	90                   	nop
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
  101160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101165:	eb de                	jmp    101145 <filewrite+0x55>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  101167:	83 ec 0c             	sub    $0xc,%esp
  10116a:	68 23 60 10 00       	push   $0x106023
  10116f:	e8 ac f8 ff ff       	call   100a20 <panic>
  101174:	66 90                	xchg   %ax,%ax
  101176:	66 90                	xchg   %ax,%ax
  101178:	66 90                	xchg   %ax,%ax
  10117a:	66 90                	xchg   %ax,%ax
  10117c:	66 90                	xchg   %ax,%ax
  10117e:	66 90                	xchg   %ax,%ax

00101180 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  101180:	55                   	push   %ebp
  101181:	57                   	push   %edi
  101182:	89 d5                	mov    %edx,%ebp
  101184:	56                   	push   %esi
  101185:	53                   	push   %ebx
  101186:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  101188:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10118a:	bb f4 ba 10 00       	mov    $0x10baf4,%ebx

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  10118f:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
  101192:	68 c0 ba 10 00       	push   $0x10bac0
  101197:	e8 a4 2b 00 00       	call   103d40 <acquire>
  10119c:	83 c4 10             	add    $0x10,%esp
  10119f:	eb 16                	jmp    1011b7 <iget+0x37>
  1011a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  1011a8:	85 f6                	test   %esi,%esi
  1011aa:	74 44                	je     1011f0 <iget+0x70>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  1011ac:	83 c3 50             	add    $0x50,%ebx
  1011af:	81 fb 94 ca 10 00    	cmp    $0x10ca94,%ebx
  1011b5:	74 49                	je     101200 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  1011b7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  1011ba:	85 c9                	test   %ecx,%ecx
  1011bc:	7e ea                	jle    1011a8 <iget+0x28>
  1011be:	39 3b                	cmp    %edi,(%ebx)
  1011c0:	75 e6                	jne    1011a8 <iget+0x28>
  1011c2:	39 6b 04             	cmp    %ebp,0x4(%ebx)
  1011c5:	75 e1                	jne    1011a8 <iget+0x28>
      ip->ref++;
      release(&icache.lock);
  1011c7:	83 ec 0c             	sub    $0xc,%esp

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
  1011ca:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
  1011cd:	89 de                	mov    %ebx,%esi
  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
  1011cf:	68 c0 ba 10 00       	push   $0x10bac0

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
  1011d4:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
  1011d7:	e8 44 2d 00 00       	call   103f20 <release>
      return ip;
  1011dc:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  1011df:	89 f0                	mov    %esi,%eax
  1011e1:	83 c4 0c             	add    $0xc,%esp
  1011e4:	5b                   	pop    %ebx
  1011e5:	5e                   	pop    %esi
  1011e6:	5f                   	pop    %edi
  1011e7:	5d                   	pop    %ebp
  1011e8:	c3                   	ret    
  1011e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  1011f0:	85 c9                	test   %ecx,%ecx
  1011f2:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  1011f5:	83 c3 50             	add    $0x50,%ebx
  1011f8:	81 fb 94 ca 10 00    	cmp    $0x10ca94,%ebx
  1011fe:	75 b7                	jne    1011b7 <iget+0x37>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101200:	85 f6                	test   %esi,%esi
  101202:	74 2d                	je     101231 <iget+0xb1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  101204:	83 ec 0c             	sub    $0xc,%esp
  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  101207:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
  101209:	89 6e 04             	mov    %ebp,0x4(%esi)
  ip->ref = 1;
  10120c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  101213:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  10121a:	68 c0 ba 10 00       	push   $0x10bac0
  10121f:	e8 fc 2c 00 00       	call   103f20 <release>

  return ip;
  101224:	83 c4 10             	add    $0x10,%esp
}
  101227:	89 f0                	mov    %esi,%eax
  101229:	83 c4 0c             	add    $0xc,%esp
  10122c:	5b                   	pop    %ebx
  10122d:	5e                   	pop    %esi
  10122e:	5f                   	pop    %edi
  10122f:	5d                   	pop    %ebp
  101230:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  101231:	83 ec 0c             	sub    $0xc,%esp
  101234:	68 2d 60 10 00       	push   $0x10602d
  101239:	e8 e2 f7 ff ff       	call   100a20 <panic>
  10123e:	66 90                	xchg   %ax,%ax

00101240 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  101240:	56                   	push   %esi
  101241:	53                   	push   %ebx
  101242:	89 d6                	mov    %edx,%esi
  101244:	83 ec 0c             	sub    $0xc,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  101247:	6a 01                	push   $0x1
  101249:	50                   	push   %eax
  10124a:	e8 71 ef ff ff       	call   1001c0 <bread>
  10124f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  101251:	8d 40 18             	lea    0x18(%eax),%eax
  101254:	83 c4 0c             	add    $0xc,%esp
  101257:	6a 0c                	push   $0xc
  101259:	50                   	push   %eax
  10125a:	56                   	push   %esi
  10125b:	e8 90 2d 00 00       	call   103ff0 <memmove>
  brelse(bp);
  101260:	89 1c 24             	mov    %ebx,(%esp)
  101263:	e8 68 f0 ff ff       	call   1002d0 <brelse>
}
  101268:	83 c4 14             	add    $0x14,%esp
  10126b:	5b                   	pop    %ebx
  10126c:	5e                   	pop    %esi
  10126d:	c3                   	ret    
  10126e:	66 90                	xchg   %ax,%ax

00101270 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  101270:	55                   	push   %ebp
  101271:	57                   	push   %edi
  101272:	56                   	push   %esi
  101273:	53                   	push   %ebx
  101274:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  101277:	8d 54 24 14          	lea    0x14(%esp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  10127b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  10127f:	e8 bc ff ff ff       	call   101240 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  101284:	8b 44 24 14          	mov    0x14(%esp),%eax
  101288:	85 c0                	test   %eax,%eax
  10128a:	0f 84 a2 00 00 00    	je     101332 <balloc+0xc2>
  101290:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101297:	00 
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101298:	be 01 00 00 00       	mov    $0x1,%esi
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  10129d:	83 ec 08             	sub    $0x8,%esp
    for(bi = 0; bi < BPB; bi++){
  1012a0:	31 db                	xor    %ebx,%ebx
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1012a2:	8b 44 24 24          	mov    0x24(%esp),%eax
  1012a6:	8b 54 24 10          	mov    0x10(%esp),%edx
  1012aa:	c1 e8 03             	shr    $0x3,%eax
  1012ad:	c1 fa 0c             	sar    $0xc,%edx
  1012b0:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1012b4:	50                   	push   %eax
  1012b5:	ff 74 24 18          	pushl  0x18(%esp)
  1012b9:	e8 02 ef ff ff       	call   1001c0 <bread>
  1012be:	83 c4 10             	add    $0x10,%esp
  1012c1:	89 c7                	mov    %eax,%edi
  1012c3:	eb 0e                	jmp    1012d3 <balloc+0x63>
  1012c5:	8d 76 00             	lea    0x0(%esi),%esi
    for(bi = 0; bi < BPB; bi++){
  1012c8:	83 c3 01             	add    $0x1,%ebx
  1012cb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  1012d1:	74 3d                	je     101310 <balloc+0xa0>
      m = 1 << (bi % 8);
  1012d3:	89 d9                	mov    %ebx,%ecx
  1012d5:	89 f2                	mov    %esi,%edx
  1012d7:	83 e1 07             	and    $0x7,%ecx
  1012da:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  1012dc:	89 d9                	mov    %ebx,%ecx
  1012de:	c1 f9 03             	sar    $0x3,%ecx
  1012e1:	0f b6 6c 0f 18       	movzbl 0x18(%edi,%ecx,1),%ebp
  1012e6:	85 d5                	test   %edx,%ebp
  1012e8:	75 de                	jne    1012c8 <balloc+0x58>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
  1012ea:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  1012ed:	09 ea                	or     %ebp,%edx
  1012ef:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
        bwrite(bp);
  1012f3:	57                   	push   %edi
  1012f4:	e8 a7 ef ff ff       	call   1002a0 <bwrite>
        brelse(bp);
  1012f9:	89 3c 24             	mov    %edi,(%esp)
  1012fc:	e8 cf ef ff ff       	call   1002d0 <brelse>
        return b + bi;
  101301:	8b 44 24 18          	mov    0x18(%esp),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101305:	83 c4 3c             	add    $0x3c,%esp
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
        return b + bi;
  101308:	01 d8                	add    %ebx,%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  10130a:	5b                   	pop    %ebx
  10130b:	5e                   	pop    %esi
  10130c:	5f                   	pop    %edi
  10130d:	5d                   	pop    %ebp
  10130e:	c3                   	ret    
  10130f:	90                   	nop
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  101310:	83 ec 0c             	sub    $0xc,%esp
  101313:	57                   	push   %edi
  101314:	e8 b7 ef ff ff       	call   1002d0 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101319:	81 44 24 18 00 10 00 	addl   $0x1000,0x18(%esp)
  101320:	00 
  101321:	8b 44 24 18          	mov    0x18(%esp),%eax
  101325:	83 c4 10             	add    $0x10,%esp
  101328:	39 44 24 14          	cmp    %eax,0x14(%esp)
  10132c:	0f 87 6b ff ff ff    	ja     10129d <balloc+0x2d>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  101332:	83 ec 0c             	sub    $0xc,%esp
  101335:	68 3d 60 10 00       	push   $0x10603d
  10133a:	e8 e1 f6 ff ff       	call   100a20 <panic>
  10133f:	90                   	nop

00101340 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  101340:	57                   	push   %edi
  101341:	56                   	push   %esi
  101342:	89 c6                	mov    %eax,%esi
  101344:	53                   	push   %ebx
  101345:	89 d3                	mov    %edx,%ebx
  101347:	83 ec 18             	sub    $0x18,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  10134a:	52                   	push   %edx
  10134b:	50                   	push   %eax
  10134c:	e8 6f ee ff ff       	call   1001c0 <bread>
  memset(bp->data, 0, BSIZE);
  101351:	83 c4 0c             	add    $0xc,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  101354:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  101356:	83 c0 18             	add    $0x18,%eax
  101359:	68 00 02 00 00       	push   $0x200
  10135e:	6a 00                	push   $0x0
  101360:	50                   	push   %eax
  101361:	e8 0a 2c 00 00       	call   103f70 <memset>
  bwrite(bp);
  101366:	89 3c 24             	mov    %edi,(%esp)
  101369:	e8 32 ef ff ff       	call   1002a0 <bwrite>
  brelse(bp);
  10136e:	89 3c 24             	mov    %edi,(%esp)
  101371:	e8 5a ef ff ff       	call   1002d0 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  101376:	8d 54 24 14          	lea    0x14(%esp),%edx
  10137a:	89 f0                	mov    %esi,%eax
  10137c:	e8 bf fe ff ff       	call   101240 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101381:	58                   	pop    %eax
  101382:	5a                   	pop    %edx
  101383:	8b 44 24 14          	mov    0x14(%esp),%eax
  101387:	89 da                	mov    %ebx,%edx
  101389:	c1 ea 0c             	shr    $0xc,%edx
  10138c:	c1 e8 03             	shr    $0x3,%eax
  10138f:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101393:	50                   	push   %eax
  101394:	56                   	push   %esi
  101395:	e8 26 ee ff ff       	call   1001c0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
  10139a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
  10139c:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  1013a2:	ba 01 00 00 00       	mov    $0x1,%edx
  1013a7:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  1013aa:	c1 fb 03             	sar    $0x3,%ebx
  1013ad:	83 c4 10             	add    $0x10,%esp
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  1013b0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
  1013b2:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
  1013b7:	85 d1                	test   %edx,%ecx
  1013b9:	74 22                	je     1013dd <bfree+0x9d>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  1013bb:	f7 d2                	not    %edx
  1013bd:	89 c6                	mov    %eax,%esi
  bwrite(bp);
  1013bf:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  1013c2:	21 ca                	and    %ecx,%edx
  1013c4:	88 54 1e 18          	mov    %dl,0x18(%esi,%ebx,1)
  bwrite(bp);
  1013c8:	56                   	push   %esi
  1013c9:	e8 d2 ee ff ff       	call   1002a0 <bwrite>
  brelse(bp);
  1013ce:	89 34 24             	mov    %esi,(%esp)
  1013d1:	e8 fa ee ff ff       	call   1002d0 <brelse>
}
  1013d6:	83 c4 20             	add    $0x20,%esp
  1013d9:	5b                   	pop    %ebx
  1013da:	5e                   	pop    %esi
  1013db:	5f                   	pop    %edi
  1013dc:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  1013dd:	83 ec 0c             	sub    $0xc,%esp
  1013e0:	68 53 60 10 00       	push   $0x106053
  1013e5:	e8 36 f6 ff ff       	call   100a20 <panic>
  1013ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001013f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
  1013f0:	55                   	push   %ebp
  1013f1:	57                   	push   %edi
  1013f2:	56                   	push   %esi
  1013f3:	53                   	push   %ebx
  1013f4:	89 c6                	mov    %eax,%esi
  1013f6:	83 ec 0c             	sub    $0xc,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  1013f9:	83 fa 0b             	cmp    $0xb,%edx
  1013fc:	77 12                	ja     101410 <bmap+0x20>
  1013fe:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
  101401:	8b 43 1c             	mov    0x1c(%ebx),%eax
  101404:	85 c0                	test   %eax,%eax
  101406:	74 68                	je     101470 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  101408:	83 c4 0c             	add    $0xc,%esp
  10140b:	5b                   	pop    %ebx
  10140c:	5e                   	pop    %esi
  10140d:	5f                   	pop    %edi
  10140e:	5d                   	pop    %ebp
  10140f:	c3                   	ret    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
  101410:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
  101413:	83 fb 7f             	cmp    $0x7f,%ebx
  101416:	77 7c                	ja     101494 <bmap+0xa4>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
  101418:	8b 40 4c             	mov    0x4c(%eax),%eax
  10141b:	85 c0                	test   %eax,%eax
  10141d:	74 69                	je     101488 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  10141f:	83 ec 08             	sub    $0x8,%esp
  101422:	50                   	push   %eax
  101423:	ff 36                	pushl  (%esi)
  101425:	e8 96 ed ff ff       	call   1001c0 <bread>
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  10142a:	8d 6c 98 18          	lea    0x18(%eax,%ebx,4),%ebp
  10142e:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
  101431:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101433:	8b 5d 00             	mov    0x0(%ebp),%ebx
  101436:	85 db                	test   %ebx,%ebx
  101438:	75 18                	jne    101452 <bmap+0x62>
      a[bn] = addr = balloc(ip->dev);
  10143a:	8b 06                	mov    (%esi),%eax
  10143c:	e8 2f fe ff ff       	call   101270 <balloc>
      bwrite(bp);
  101441:	83 ec 0c             	sub    $0xc,%esp
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
  101444:	89 45 00             	mov    %eax,0x0(%ebp)
  101447:	89 c3                	mov    %eax,%ebx
      bwrite(bp);
  101449:	57                   	push   %edi
  10144a:	e8 51 ee ff ff       	call   1002a0 <bwrite>
  10144f:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  101452:	83 ec 0c             	sub    $0xc,%esp
  101455:	57                   	push   %edi
  101456:	e8 75 ee ff ff       	call   1002d0 <brelse>
  10145b:	83 c4 10             	add    $0x10,%esp
  10145e:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
  101460:	83 c4 0c             	add    $0xc,%esp
  101463:	5b                   	pop    %ebx
  101464:	5e                   	pop    %esi
  101465:	5f                   	pop    %edi
  101466:	5d                   	pop    %ebp
  101467:	c3                   	ret    
  101468:	90                   	nop
  101469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
  101470:	8b 06                	mov    (%esi),%eax
  101472:	e8 f9 fd ff ff       	call   101270 <balloc>
  101477:	89 43 1c             	mov    %eax,0x1c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  10147a:	83 c4 0c             	add    $0xc,%esp
  10147d:	5b                   	pop    %ebx
  10147e:	5e                   	pop    %esi
  10147f:	5f                   	pop    %edi
  101480:	5d                   	pop    %ebp
  101481:	c3                   	ret    
  101482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
  101488:	8b 06                	mov    (%esi),%eax
  10148a:	e8 e1 fd ff ff       	call   101270 <balloc>
  10148f:	89 46 4c             	mov    %eax,0x4c(%esi)
  101492:	eb 8b                	jmp    10141f <bmap+0x2f>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  101494:	83 ec 0c             	sub    $0xc,%esp
  101497:	68 66 60 10 00       	push   $0x106066
  10149c:	e8 7f f5 ff ff       	call   100a20 <panic>
  1014a1:	eb 0d                	jmp    1014b0 <iinit>
  1014a3:	90                   	nop
  1014a4:	90                   	nop
  1014a5:	90                   	nop
  1014a6:	90                   	nop
  1014a7:	90                   	nop
  1014a8:	90                   	nop
  1014a9:	90                   	nop
  1014aa:	90                   	nop
  1014ab:	90                   	nop
  1014ac:	90                   	nop
  1014ad:	90                   	nop
  1014ae:	90                   	nop
  1014af:	90                   	nop

001014b0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  1014b0:	83 ec 14             	sub    $0x14,%esp
  initlock(&icache.lock, "icache");
  1014b3:	68 79 60 10 00       	push   $0x106079
  1014b8:	68 c0 ba 10 00       	push   $0x10bac0
  1014bd:	e8 5e 28 00 00       	call   103d20 <initlock>
}
  1014c2:	83 c4 1c             	add    $0x1c,%esp
  1014c5:	c3                   	ret    
  1014c6:	8d 76 00             	lea    0x0(%esi),%esi
  1014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001014d0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  1014d0:	53                   	push   %ebx
  1014d1:	83 ec 14             	sub    $0x14,%esp
  1014d4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&icache.lock);
  1014d8:	68 c0 ba 10 00       	push   $0x10bac0
  1014dd:	e8 5e 28 00 00       	call   103d40 <acquire>
  ip->ref++;
  1014e2:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  1014e6:	c7 04 24 c0 ba 10 00 	movl   $0x10bac0,(%esp)
  1014ed:	e8 2e 2a 00 00       	call   103f20 <release>
  return ip;
}
  1014f2:	83 c4 18             	add    $0x18,%esp
  1014f5:	89 d8                	mov    %ebx,%eax
  1014f7:	5b                   	pop    %ebx
  1014f8:	c3                   	ret    
  1014f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101500 <ilock>:

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101500:	56                   	push   %esi
  101501:	53                   	push   %ebx
  101502:	83 ec 04             	sub    $0x4,%esp
  101505:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101509:	85 db                	test   %ebx,%ebx
  10150b:	0f 84 e7 00 00 00    	je     1015f8 <ilock+0xf8>
  101511:	8b 43 08             	mov    0x8(%ebx),%eax
  101514:	85 c0                	test   %eax,%eax
  101516:	0f 8e dc 00 00 00    	jle    1015f8 <ilock+0xf8>
    panic("ilock");

  acquire(&icache.lock);
  10151c:	83 ec 0c             	sub    $0xc,%esp
  10151f:	68 c0 ba 10 00       	push   $0x10bac0
  101524:	e8 17 28 00 00       	call   103d40 <acquire>
  while(ip->flags & I_BUSY)
  101529:	8b 43 0c             	mov    0xc(%ebx),%eax
  10152c:	83 c4 10             	add    $0x10,%esp
  10152f:	a8 01                	test   $0x1,%al
  101531:	74 1d                	je     101550 <ilock+0x50>
  101533:	90                   	nop
  101534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101538:	83 ec 08             	sub    $0x8,%esp
  10153b:	68 c0 ba 10 00       	push   $0x10bac0
  101540:	53                   	push   %ebx
  101541:	e8 5a 23 00 00       	call   1038a0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101546:	8b 43 0c             	mov    0xc(%ebx),%eax
  101549:	83 c4 10             	add    $0x10,%esp
  10154c:	a8 01                	test   $0x1,%al
  10154e:	75 e8                	jne    101538 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);
  101550:	83 ec 0c             	sub    $0xc,%esp
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101553:	83 c8 01             	or     $0x1,%eax
  101556:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  101559:	68 c0 ba 10 00       	push   $0x10bac0
  10155e:	e8 bd 29 00 00       	call   103f20 <release>

  if(!(ip->flags & I_VALID)){
  101563:	83 c4 10             	add    $0x10,%esp
  101566:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  10156a:	74 0c                	je     101578 <ilock+0x78>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  10156c:	83 c4 04             	add    $0x4,%esp
  10156f:	5b                   	pop    %ebx
  101570:	5e                   	pop    %esi
  101571:	c3                   	ret    
  101572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101578:	8b 43 04             	mov    0x4(%ebx),%eax
  10157b:	83 ec 08             	sub    $0x8,%esp
  10157e:	c1 e8 03             	shr    $0x3,%eax
  101581:	83 c0 02             	add    $0x2,%eax
  101584:	50                   	push   %eax
  101585:	ff 33                	pushl  (%ebx)
  101587:	e8 34 ec ff ff       	call   1001c0 <bread>
  10158c:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  10158e:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101591:	83 c4 0c             	add    $0xc,%esp
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101594:	83 e0 07             	and    $0x7,%eax
  101597:	c1 e0 06             	shl    $0x6,%eax
  10159a:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  10159e:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1015a1:	83 c0 0c             	add    $0xc,%eax
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
  1015a4:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  1015a8:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
  1015ac:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  1015b0:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
  1015b4:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  1015b8:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
  1015bc:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  1015c0:	8b 50 fc             	mov    -0x4(%eax),%edx
  1015c3:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  1015c6:	6a 34                	push   $0x34
  1015c8:	50                   	push   %eax
  1015c9:	8d 43 1c             	lea    0x1c(%ebx),%eax
  1015cc:	50                   	push   %eax
  1015cd:	e8 1e 2a 00 00       	call   103ff0 <memmove>
    brelse(bp);
  1015d2:	89 34 24             	mov    %esi,(%esp)
  1015d5:	e8 f6 ec ff ff       	call   1002d0 <brelse>
    ip->flags |= I_VALID;
  1015da:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  1015de:	83 c4 10             	add    $0x10,%esp
  1015e1:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  1015e6:	75 84                	jne    10156c <ilock+0x6c>
      panic("ilock: no type");
  1015e8:	83 ec 0c             	sub    $0xc,%esp
  1015eb:	68 86 60 10 00       	push   $0x106086
  1015f0:	e8 2b f4 ff ff       	call   100a20 <panic>
  1015f5:	8d 76 00             	lea    0x0(%esi),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  1015f8:	83 ec 0c             	sub    $0xc,%esp
  1015fb:	68 80 60 10 00       	push   $0x106080
  101600:	e8 1b f4 ff ff       	call   100a20 <panic>
  101605:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101610 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  101610:	53                   	push   %ebx
  101611:	83 ec 08             	sub    $0x8,%esp
  101614:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  101618:	85 db                	test   %ebx,%ebx
  10161a:	74 37                	je     101653 <iunlock+0x43>
  10161c:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101620:	74 31                	je     101653 <iunlock+0x43>
  101622:	8b 43 08             	mov    0x8(%ebx),%eax
  101625:	85 c0                	test   %eax,%eax
  101627:	7e 2a                	jle    101653 <iunlock+0x43>
    panic("iunlock");

  acquire(&icache.lock);
  101629:	83 ec 0c             	sub    $0xc,%esp
  10162c:	68 c0 ba 10 00       	push   $0x10bac0
  101631:	e8 0a 27 00 00       	call   103d40 <acquire>
  ip->flags &= ~I_BUSY;
  101636:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  10163a:	89 1c 24             	mov    %ebx,(%esp)
  10163d:	e8 0e 23 00 00       	call   103950 <wakeup>
  release(&icache.lock);
  101642:	c7 44 24 20 c0 ba 10 	movl   $0x10bac0,0x20(%esp)
  101649:	00 
}
  10164a:	83 c4 18             	add    $0x18,%esp
  10164d:	5b                   	pop    %ebx
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  10164e:	e9 cd 28 00 00       	jmp    103f20 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101653:	83 ec 0c             	sub    $0xc,%esp
  101656:	68 95 60 10 00       	push   $0x106095
  10165b:	e8 c0 f3 ff ff       	call   100a20 <panic>

00101660 <ialloc>:

//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101660:	55                   	push   %ebp
  101661:	57                   	push   %edi
  101662:	56                   	push   %esi
  101663:	53                   	push   %ebx
  101664:	83 ec 2c             	sub    $0x2c,%esp
  101667:	8b 74 24 40          	mov    0x40(%esp),%esi
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  10166b:	8d 54 24 14          	lea    0x14(%esp),%edx

//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  10166f:	8b 7c 24 44          	mov    0x44(%esp),%edi
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101673:	89 f0                	mov    %esi,%eax
  101675:	e8 c6 fb ff ff       	call   101240 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10167a:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
  10167f:	0f 86 82 00 00 00    	jbe    101707 <ialloc+0xa7>
  101685:	bb 01 00 00 00       	mov    $0x1,%ebx
  10168a:	eb 19                	jmp    1016a5 <ialloc+0x45>
  10168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101690:	83 ec 0c             	sub    $0xc,%esp
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  101693:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  101696:	55                   	push   %ebp
  101697:	e8 34 ec ff ff       	call   1002d0 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10169c:	83 c4 10             	add    $0x10,%esp
  10169f:	39 5c 24 1c          	cmp    %ebx,0x1c(%esp)
  1016a3:	76 62                	jbe    101707 <ialloc+0xa7>
    bp = bread(dev, IBLOCK(inum));
  1016a5:	89 d8                	mov    %ebx,%eax
  1016a7:	83 ec 08             	sub    $0x8,%esp
  1016aa:	c1 e8 03             	shr    $0x3,%eax
  1016ad:	83 c0 02             	add    $0x2,%eax
  1016b0:	50                   	push   %eax
  1016b1:	56                   	push   %esi
  1016b2:	e8 09 eb ff ff       	call   1001c0 <bread>
  1016b7:	89 c5                	mov    %eax,%ebp
    dip = (struct dinode*)bp->data + inum%IPB;
  1016b9:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
  1016bb:	83 c4 10             	add    $0x10,%esp
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
    bp = bread(dev, IBLOCK(inum));
    dip = (struct dinode*)bp->data + inum%IPB;
  1016be:	83 e0 07             	and    $0x7,%eax
  1016c1:	c1 e0 06             	shl    $0x6,%eax
  1016c4:	8d 54 05 18          	lea    0x18(%ebp,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  1016c8:	66 83 3a 00          	cmpw   $0x0,(%edx)
  1016cc:	75 c2                	jne    101690 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
  1016ce:	83 ec 04             	sub    $0x4,%esp
  1016d1:	6a 40                	push   $0x40
  1016d3:	6a 00                	push   $0x0
  1016d5:	52                   	push   %edx
  1016d6:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  1016da:	e8 91 28 00 00       	call   103f70 <memset>
      dip->type = type;
  1016df:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  1016e3:	66 89 3a             	mov    %di,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  1016e6:	89 2c 24             	mov    %ebp,(%esp)
  1016e9:	e8 b2 eb ff ff       	call   1002a0 <bwrite>
      brelse(bp);
  1016ee:	89 2c 24             	mov    %ebp,(%esp)
  1016f1:	e8 da eb ff ff       	call   1002d0 <brelse>
      return iget(dev, inum);
  1016f6:	89 da                	mov    %ebx,%edx
  1016f8:	89 f0                	mov    %esi,%eax
  1016fa:	e8 81 fa ff ff       	call   101180 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  1016ff:	83 c4 3c             	add    $0x3c,%esp
  101702:	5b                   	pop    %ebx
  101703:	5e                   	pop    %esi
  101704:	5f                   	pop    %edi
  101705:	5d                   	pop    %ebp
  101706:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  101707:	83 ec 0c             	sub    $0xc,%esp
  10170a:	68 9d 60 10 00       	push   $0x10609d
  10170f:	e8 0c f3 ff ff       	call   100a20 <panic>
  101714:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10171a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101720 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101720:	56                   	push   %esi
  101721:	53                   	push   %ebx
  101722:	83 ec 0c             	sub    $0xc,%esp
  101725:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  101729:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  10172c:	83 c3 1c             	add    $0x1c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10172f:	c1 e8 03             	shr    $0x3,%eax
  101732:	83 c0 02             	add    $0x2,%eax
  101735:	50                   	push   %eax
  101736:	ff 73 e4             	pushl  -0x1c(%ebx)
  101739:	e8 82 ea ff ff       	call   1001c0 <bread>
  10173e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101740:	8b 43 e8             	mov    -0x18(%ebx),%eax
  dip->type = ip->type;
  101743:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101747:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  10174a:	83 e0 07             	and    $0x7,%eax
  10174d:	c1 e0 06             	shl    $0x6,%eax
  101750:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  101754:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  101757:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  10175b:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  10175e:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
  101762:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
  101766:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
  10176a:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
  10176e:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
  101772:	8b 53 fc             	mov    -0x4(%ebx),%edx
  101775:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  101778:	6a 34                	push   $0x34
  10177a:	53                   	push   %ebx
  10177b:	50                   	push   %eax
  10177c:	e8 6f 28 00 00       	call   103ff0 <memmove>
  bwrite(bp);
  101781:	89 34 24             	mov    %esi,(%esp)
  101784:	e8 17 eb ff ff       	call   1002a0 <bwrite>
  brelse(bp);
  101789:	89 74 24 20          	mov    %esi,0x20(%esp)
}
  10178d:	83 c4 14             	add    $0x14,%esp
  101790:	5b                   	pop    %ebx
  101791:	5e                   	pop    %esi
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  101792:	e9 39 eb ff ff       	jmp    1002d0 <brelse>
  101797:	89 f6                	mov    %esi,%esi
  101799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001017a0 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  1017a0:	55                   	push   %ebp
  1017a1:	57                   	push   %edi
  1017a2:	56                   	push   %esi
  1017a3:	53                   	push   %ebx
  1017a4:	83 ec 18             	sub    $0x18,%esp
  1017a7:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  acquire(&icache.lock);
  1017ab:	68 c0 ba 10 00       	push   $0x10bac0
  1017b0:	e8 8b 25 00 00       	call   103d40 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  1017b5:	8b 46 08             	mov    0x8(%esi),%eax
  1017b8:	83 c4 10             	add    $0x10,%esp
  1017bb:	83 f8 01             	cmp    $0x1,%eax
  1017be:	0f 85 ac 00 00 00    	jne    101870 <iput+0xd0>
  1017c4:	8b 56 0c             	mov    0xc(%esi),%edx
  1017c7:	f6 c2 02             	test   $0x2,%dl
  1017ca:	0f 84 a0 00 00 00    	je     101870 <iput+0xd0>
  1017d0:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  1017d5:	0f 85 95 00 00 00    	jne    101870 <iput+0xd0>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  1017db:	f6 c2 01             	test   $0x1,%dl
  1017de:	0f 85 04 01 00 00    	jne    1018e8 <iput+0x148>
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
  1017e4:	83 ec 0c             	sub    $0xc,%esp
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  1017e7:	83 ca 01             	or     $0x1,%edx
  1017ea:	8d 5e 1c             	lea    0x1c(%esi),%ebx
  1017ed:	89 56 0c             	mov    %edx,0xc(%esi)
    release(&icache.lock);
  1017f0:	68 c0 ba 10 00       	push   $0x10bac0
  1017f5:	8d 7e 4c             	lea    0x4c(%esi),%edi
  1017f8:	e8 23 27 00 00       	call   103f20 <release>
  1017fd:	83 c4 10             	add    $0x10,%esp
  101800:	eb 0d                	jmp    10180f <iput+0x6f>
  101802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101808:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  10180b:	39 fb                	cmp    %edi,%ebx
  10180d:	74 1b                	je     10182a <iput+0x8a>
    if(ip->addrs[i]){
  10180f:	8b 13                	mov    (%ebx),%edx
  101811:	85 d2                	test   %edx,%edx
  101813:	74 f3                	je     101808 <iput+0x68>
      bfree(ip->dev, ip->addrs[i]);
  101815:	8b 06                	mov    (%esi),%eax
  101817:	83 c3 04             	add    $0x4,%ebx
  10181a:	e8 21 fb ff ff       	call   101340 <bfree>
      ip->addrs[i] = 0;
  10181f:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101826:	39 fb                	cmp    %edi,%ebx
  101828:	75 e5                	jne    10180f <iput+0x6f>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
  10182a:	8b 46 4c             	mov    0x4c(%esi),%eax
  10182d:	85 c0                	test   %eax,%eax
  10182f:	75 5f                	jne    101890 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
  101831:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  101834:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  10183b:	56                   	push   %esi
  10183c:	e8 df fe ff ff       	call   101720 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101841:	31 c0                	xor    %eax,%eax
  101843:	66 89 46 10          	mov    %ax,0x10(%esi)
    iupdate(ip);
  101847:	89 34 24             	mov    %esi,(%esp)
  10184a:	e8 d1 fe ff ff       	call   101720 <iupdate>
    acquire(&icache.lock);
  10184f:	c7 04 24 c0 ba 10 00 	movl   $0x10bac0,(%esp)
  101856:	e8 e5 24 00 00       	call   103d40 <acquire>
    ip->flags = 0;
  10185b:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
  101862:	89 34 24             	mov    %esi,(%esp)
  101865:	e8 e6 20 00 00       	call   103950 <wakeup>
  10186a:	8b 46 08             	mov    0x8(%esi),%eax
  10186d:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
  101870:	83 e8 01             	sub    $0x1,%eax
  101873:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  101876:	c7 44 24 20 c0 ba 10 	movl   $0x10bac0,0x20(%esp)
  10187d:	00 
}
  10187e:	83 c4 0c             	add    $0xc,%esp
  101881:	5b                   	pop    %ebx
  101882:	5e                   	pop    %esi
  101883:	5f                   	pop    %edi
  101884:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101885:	e9 96 26 00 00       	jmp    103f20 <release>
  10188a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
  101890:	83 ec 08             	sub    $0x8,%esp
  101893:	50                   	push   %eax
  101894:	ff 36                	pushl  (%esi)
  101896:	e8 25 e9 ff ff       	call   1001c0 <bread>
  10189b:	83 c4 10             	add    $0x10,%esp
  10189e:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
  1018a0:	8d 58 18             	lea    0x18(%eax),%ebx
  1018a3:	8d a8 18 02 00 00    	lea    0x218(%eax),%ebp
  1018a9:	eb 0c                	jmp    1018b7 <iput+0x117>
  1018ab:	90                   	nop
  1018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1018b0:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
  1018b3:	39 dd                	cmp    %ebx,%ebp
  1018b5:	74 0f                	je     1018c6 <iput+0x126>
      if(a[j])
  1018b7:	8b 13                	mov    (%ebx),%edx
  1018b9:	85 d2                	test   %edx,%edx
  1018bb:	74 f3                	je     1018b0 <iput+0x110>
        bfree(ip->dev, a[j]);
  1018bd:	8b 06                	mov    (%esi),%eax
  1018bf:	e8 7c fa ff ff       	call   101340 <bfree>
  1018c4:	eb ea                	jmp    1018b0 <iput+0x110>
    }
    brelse(bp);
  1018c6:	83 ec 0c             	sub    $0xc,%esp
  1018c9:	57                   	push   %edi
  1018ca:	e8 01 ea ff ff       	call   1002d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
  1018cf:	8b 56 4c             	mov    0x4c(%esi),%edx
  1018d2:	8b 06                	mov    (%esi),%eax
  1018d4:	e8 67 fa ff ff       	call   101340 <bfree>
    ip->addrs[NDIRECT] = 0;
  1018d9:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  1018e0:	83 c4 10             	add    $0x10,%esp
  1018e3:	e9 49 ff ff ff       	jmp    101831 <iput+0x91>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  1018e8:	83 ec 0c             	sub    $0xc,%esp
  1018eb:	68 af 60 10 00       	push   $0x1060af
  1018f0:	e8 2b f1 ff ff       	call   100a20 <panic>
  1018f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1018f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101900 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101900:	53                   	push   %ebx
  101901:	83 ec 14             	sub    $0x14,%esp
  101904:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  iunlock(ip);
  101908:	53                   	push   %ebx
  101909:	e8 02 fd ff ff       	call   101610 <iunlock>
  iput(ip);
  10190e:	89 5c 24 20          	mov    %ebx,0x20(%esp)
}
  101912:	83 c4 18             	add    $0x18,%esp
  101915:	5b                   	pop    %ebx
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101916:	e9 85 fe ff ff       	jmp    1017a0 <iput>
  10191b:	90                   	nop
  10191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101920 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct statv6 *st)
{
  101920:	8b 54 24 04          	mov    0x4(%esp),%edx
  101924:	8b 44 24 08          	mov    0x8(%esp),%eax
  st->dev = ip->dev;
  101928:	8b 0a                	mov    (%edx),%ecx
  10192a:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
  10192d:	8b 4a 04             	mov    0x4(%edx),%ecx
  101930:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
  101933:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  101937:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
  10193a:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  st->size = ip->size;
  10193e:	8b 52 18             	mov    0x18(%edx),%edx
stati(struct inode *ip, struct statv6 *st)
{
  st->dev = ip->dev;
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  101941:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
  101945:	89 50 10             	mov    %edx,0x10(%eax)
  101948:	c3                   	ret    
  101949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101950 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101950:	55                   	push   %ebp
  101951:	57                   	push   %edi
  101952:	56                   	push   %esi
  101953:	53                   	push   %ebx
  101954:	83 ec 1c             	sub    $0x1c,%esp
  101957:	8b 44 24 30          	mov    0x30(%esp),%eax
  10195b:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  10195f:	8b 6c 24 34          	mov    0x34(%esp),%ebp
  101963:	8b 74 24 38          	mov    0x38(%esp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101967:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  10196c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101970:	89 7c 24 04          	mov    %edi,0x4(%esp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101974:	0f 84 ae 00 00 00    	je     101a28 <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  10197a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10197e:	8b 40 18             	mov    0x18(%eax),%eax
  101981:	39 f0                	cmp    %esi,%eax
  101983:	0f 82 c7 00 00 00    	jb     101a50 <readi+0x100>
  101989:	8b 7c 24 04          	mov    0x4(%esp),%edi
  10198d:	89 fa                	mov    %edi,%edx
  10198f:	01 f2                	add    %esi,%edx
  101991:	0f 82 b9 00 00 00    	jb     101a50 <readi+0x100>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  101997:	89 c1                	mov    %eax,%ecx
  101999:	29 f1                	sub    %esi,%ecx
  10199b:	39 d0                	cmp    %edx,%eax
  10199d:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019a0:	31 ff                	xor    %edi,%edi
  1019a2:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
  1019a4:	89 4c 24 04          	mov    %ecx,0x4(%esp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019a8:	74 6b                	je     101a15 <readi+0xc5>
  1019aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1019b0:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1019b4:	89 f2                	mov    %esi,%edx
  1019b6:	c1 ea 09             	shr    $0x9,%edx
  1019b9:	89 d8                	mov    %ebx,%eax
  1019bb:	e8 30 fa ff ff       	call   1013f0 <bmap>
  1019c0:	83 ec 08             	sub    $0x8,%esp
  1019c3:	50                   	push   %eax
  1019c4:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
  1019c6:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  1019cb:	e8 f0 e7 ff ff       	call   1001c0 <bread>
  1019d0:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  1019d2:	8b 44 24 14          	mov    0x14(%esp),%eax
  1019d6:	89 f1                	mov    %esi,%ecx
  1019d8:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
  1019de:	83 c4 0c             	add    $0xc,%esp
  1019e1:	29 cb                	sub    %ecx,%ebx
  1019e3:	29 f8                	sub    %edi,%eax
  1019e5:	39 c3                	cmp    %eax,%ebx
  1019e7:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
  1019ea:	8d 44 0a 18          	lea    0x18(%edx,%ecx,1),%eax
  1019ee:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019ef:	01 df                	add    %ebx,%edi
  1019f1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  1019f3:	89 54 24 10          	mov    %edx,0x10(%esp)
  1019f7:	50                   	push   %eax
  1019f8:	55                   	push   %ebp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1019f9:	01 dd                	add    %ebx,%ebp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  1019fb:	e8 f0 25 00 00       	call   103ff0 <memmove>
    brelse(bp);
  101a00:	8b 54 24 18          	mov    0x18(%esp),%edx
  101a04:	89 14 24             	mov    %edx,(%esp)
  101a07:	e8 c4 e8 ff ff       	call   1002d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101a0c:	83 c4 10             	add    $0x10,%esp
  101a0f:	39 7c 24 04          	cmp    %edi,0x4(%esp)
  101a13:	77 9b                	ja     1019b0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101a15:	8b 44 24 04          	mov    0x4(%esp),%eax
}
  101a19:	83 c4 1c             	add    $0x1c,%esp
  101a1c:	5b                   	pop    %ebx
  101a1d:	5e                   	pop    %esi
  101a1e:	5f                   	pop    %edi
  101a1f:	5d                   	pop    %ebp
  101a20:	c3                   	ret    
  101a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  101a28:	0f bf 40 12          	movswl 0x12(%eax),%eax
  101a2c:	66 83 f8 09          	cmp    $0x9,%ax
  101a30:	77 1e                	ja     101a50 <readi+0x100>
  101a32:	8d 04 40             	lea    (%eax,%eax,2),%eax
  101a35:	8b 04 85 40 ba 10 00 	mov    0x10ba40(,%eax,4),%eax
  101a3c:	85 c0                	test   %eax,%eax
  101a3e:	74 10                	je     101a50 <readi+0x100>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  101a40:	89 7c 24 38          	mov    %edi,0x38(%esp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  101a44:	83 c4 1c             	add    $0x1c,%esp
  101a47:	5b                   	pop    %ebx
  101a48:	5e                   	pop    %esi
  101a49:	5f                   	pop    %edi
  101a4a:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  101a4b:	ff e0                	jmp    *%eax
  101a4d:	8d 76 00             	lea    0x0(%esi),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
  101a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101a55:	eb c2                	jmp    101a19 <readi+0xc9>
  101a57:	89 f6                	mov    %esi,%esi
  101a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101a60 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101a60:	55                   	push   %ebp
  101a61:	57                   	push   %edi
  101a62:	56                   	push   %esi
  101a63:	53                   	push   %ebx
  101a64:	83 ec 1c             	sub    $0x1c,%esp
  101a67:	8b 44 24 30          	mov    0x30(%esp),%eax
  101a6b:	8b 7c 24 34          	mov    0x34(%esp),%edi
  101a6f:	8b 74 24 38          	mov    0x38(%esp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101a73:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101a78:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101a7c:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  101a80:	89 44 24 0c          	mov    %eax,0xc(%esp)
  101a84:	89 7c 24 04          	mov    %edi,0x4(%esp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101a88:	0f 84 c2 00 00 00    	je     101b50 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
  101a8e:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101a92:	39 70 18             	cmp    %esi,0x18(%eax)
  101a95:	0f 82 f5 00 00 00    	jb     101b90 <writei+0x130>
  101a9b:	8b 44 24 04          	mov    0x4(%esp),%eax
  101a9f:	01 f0                	add    %esi,%eax
  101aa1:	0f 82 e9 00 00 00    	jb     101b90 <writei+0x130>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  101aa7:	3d 00 18 01 00       	cmp    $0x11800,%eax
  101aac:	0f 87 8e 00 00 00    	ja     101b40 <writei+0xe0>
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101ab2:	8b 44 24 04          	mov    0x4(%esp),%eax
  101ab6:	31 ff                	xor    %edi,%edi
  101ab8:	85 c0                	test   %eax,%eax
  101aba:	74 77                	je     101b33 <writei+0xd3>
  101abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101ac0:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  101ac4:	89 f2                	mov    %esi,%edx
  101ac6:	c1 ea 09             	shr    $0x9,%edx
  101ac9:	89 d8                	mov    %ebx,%eax
  101acb:	e8 20 f9 ff ff       	call   1013f0 <bmap>
  101ad0:	83 ec 08             	sub    $0x8,%esp
  101ad3:	50                   	push   %eax
  101ad4:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
  101ad6:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
  101adb:	e8 e0 e6 ff ff       	call   1001c0 <bread>
  101ae0:	89 c5                	mov    %eax,%ebp
    m = min(n - tot, BSIZE - off%BSIZE);
  101ae2:	8b 44 24 14          	mov    0x14(%esp),%eax
  101ae6:	89 f1                	mov    %esi,%ecx
  101ae8:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
  101aee:	83 c4 0c             	add    $0xc,%esp
  101af1:	29 cb                	sub    %ecx,%ebx
  101af3:	29 f8                	sub    %edi,%eax
  101af5:	39 c3                	cmp    %eax,%ebx
  101af7:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
  101afa:	8d 44 0d 18          	lea    0x18(%ebp,%ecx,1),%eax
  101afe:	53                   	push   %ebx
  101aff:	ff 74 24 10          	pushl  0x10(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101b03:	01 df                	add    %ebx,%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  101b05:	50                   	push   %eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101b06:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  101b08:	e8 e3 24 00 00       	call   103ff0 <memmove>
    bwrite(bp);
  101b0d:	89 2c 24             	mov    %ebp,(%esp)
  101b10:	e8 8b e7 ff ff       	call   1002a0 <bwrite>
    brelse(bp);
  101b15:	89 2c 24             	mov    %ebp,(%esp)
  101b18:	e8 b3 e7 ff ff       	call   1002d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101b1d:	01 5c 24 18          	add    %ebx,0x18(%esp)
  101b21:	83 c4 10             	add    $0x10,%esp
  101b24:	39 7c 24 04          	cmp    %edi,0x4(%esp)
  101b28:	77 96                	ja     101ac0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  101b2a:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101b2e:	3b 70 18             	cmp    0x18(%eax),%esi
  101b31:	77 45                	ja     101b78 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  101b33:	8b 44 24 04          	mov    0x4(%esp),%eax
}
  101b37:	83 c4 1c             	add    $0x1c,%esp
  101b3a:	5b                   	pop    %ebx
  101b3b:	5e                   	pop    %esi
  101b3c:	5f                   	pop    %edi
  101b3d:	5d                   	pop    %ebp
  101b3e:	c3                   	ret    
  101b3f:	90                   	nop
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;
  101b40:	b8 00 18 01 00       	mov    $0x11800,%eax
  101b45:	29 f0                	sub    %esi,%eax
  101b47:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b4b:	e9 62 ff ff ff       	jmp    101ab2 <writei+0x52>
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  101b50:	0f bf 40 12          	movswl 0x12(%eax),%eax
  101b54:	66 83 f8 09          	cmp    $0x9,%ax
  101b58:	77 36                	ja     101b90 <writei+0x130>
  101b5a:	8d 04 40             	lea    (%eax,%eax,2),%eax
  101b5d:	8b 04 85 44 ba 10 00 	mov    0x10ba44(,%eax,4),%eax
  101b64:	85 c0                	test   %eax,%eax
  101b66:	74 28                	je     101b90 <writei+0x130>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101b68:	89 7c 24 38          	mov    %edi,0x38(%esp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  101b6c:	83 c4 1c             	add    $0x1c,%esp
  101b6f:	5b                   	pop    %ebx
  101b70:	5e                   	pop    %esi
  101b71:	5f                   	pop    %edi
  101b72:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101b73:	ff e0                	jmp    *%eax
  101b75:	8d 76 00             	lea    0x0(%esi),%esi
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  101b78:	8b 44 24 0c          	mov    0xc(%esp),%eax
    iupdate(ip);
  101b7c:	83 ec 0c             	sub    $0xc,%esp
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  101b7f:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
  101b82:	50                   	push   %eax
  101b83:	e8 98 fb ff ff       	call   101720 <iupdate>
  101b88:	83 c4 10             	add    $0x10,%esp
  101b8b:	eb a6                	jmp    101b33 <writei+0xd3>
  101b8d:	8d 76 00             	lea    0x0(%esi),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
  101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101b95:	eb a0                	jmp    101b37 <writei+0xd7>
  101b97:	89 f6                	mov    %esi,%esi
  101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101ba0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
  101ba0:	83 ec 10             	sub    $0x10,%esp
  return strncmp(s, t, DIRSIZ);
  101ba3:	6a 0e                	push   $0xe
  101ba5:	ff 74 24 1c          	pushl  0x1c(%esp)
  101ba9:	ff 74 24 1c          	pushl  0x1c(%esp)
  101bad:	e8 ae 24 00 00       	call   104060 <strncmp>
}
  101bb2:	83 c4 1c             	add    $0x1c,%esp
  101bb5:	c3                   	ret    
  101bb6:	8d 76 00             	lea    0x0(%esi),%esi
  101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101bc0 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101bc0:	55                   	push   %ebp
  101bc1:	57                   	push   %edi
  101bc2:	56                   	push   %esi
  101bc3:	53                   	push   %ebx
  101bc4:	83 ec 1c             	sub    $0x1c,%esp
  101bc7:	8b 44 24 30          	mov    0x30(%esp),%eax
  101bcb:	8b 4c 24 38          	mov    0x38(%esp),%ecx
  101bcf:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101bd3:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101bd8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bdc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101be0:	0f 85 d9 00 00 00    	jne    101cbf <dirlookup+0xff>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101be6:	8b 40 18             	mov    0x18(%eax),%eax
  101be9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  101bf0:	85 c0                	test   %eax,%eax
  101bf2:	0f 84 bd 00 00 00    	je     101cb5 <dirlookup+0xf5>
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
  101bf8:	8b 7c 24 04          	mov    0x4(%esp),%edi
  101bfc:	8b 14 24             	mov    (%esp),%edx
  101bff:	89 f8                	mov    %edi,%eax
  101c01:	c1 ea 09             	shr    $0x9,%edx
  101c04:	e8 e7 f7 ff ff       	call   1013f0 <bmap>
  101c09:	83 ec 08             	sub    $0x8,%esp
  101c0c:	50                   	push   %eax
  101c0d:	ff 37                	pushl  (%edi)
  101c0f:	e8 ac e5 ff ff       	call   1001c0 <bread>
  101c14:	89 c7                	mov    %eax,%edi
    for(de = (struct dirent*)bp->data;
  101c16:	8d 40 18             	lea    0x18(%eax),%eax
        de < (struct dirent*)(bp->data + BSIZE);
  101c19:	8d af 18 02 00 00    	lea    0x218(%edi),%ebp
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101c1f:	89 44 24 18          	mov    %eax,0x18(%esp)
  101c23:	83 c4 10             	add    $0x10,%esp
  101c26:	89 c6                	mov    %eax,%esi
  101c28:	39 e8                	cmp    %ebp,%eax
  101c2a:	72 0b                	jb     101c37 <dirlookup+0x77>
  101c2c:	eb 62                	jmp    101c90 <dirlookup+0xd0>
  101c2e:	66 90                	xchg   %ax,%ax
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
  101c30:	83 c6 10             	add    $0x10,%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE));
    for(de = (struct dirent*)bp->data;
  101c33:	39 ee                	cmp    %ebp,%esi
  101c35:	73 59                	jae    101c90 <dirlookup+0xd0>
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
  101c37:	66 83 3e 00          	cmpw   $0x0,(%esi)
  101c3b:	74 f3                	je     101c30 <dirlookup+0x70>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
  101c3d:	8d 46 02             	lea    0x2(%esi),%eax
  101c40:	83 ec 04             	sub    $0x4,%esp
  101c43:	6a 0e                	push   $0xe
  101c45:	50                   	push   %eax
  101c46:	53                   	push   %ebx
  101c47:	e8 14 24 00 00       	call   104060 <strncmp>
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
        continue;
      if(namecmp(name, de->name) == 0){
  101c4c:	83 c4 10             	add    $0x10,%esp
  101c4f:	85 c0                	test   %eax,%eax
  101c51:	75 dd                	jne    101c30 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  101c53:	8b 44 24 0c          	mov    0xc(%esp),%eax
  101c57:	89 f5                	mov    %esi,%ebp
  101c59:	85 c0                	test   %eax,%eax
  101c5b:	74 0b                	je     101c68 <dirlookup+0xa8>
          *poff = off + (uchar*)de - bp->data;
  101c5d:	8b 34 24             	mov    (%esp),%esi
  101c60:	01 ee                	add    %ebp,%esi
  101c62:	2b 74 24 08          	sub    0x8(%esp),%esi
  101c66:	89 30                	mov    %esi,(%eax)
        inum = de->inum;
        brelse(bp);
  101c68:	83 ec 0c             	sub    $0xc,%esp
        continue;
      if(namecmp(name, de->name) == 0){
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
  101c6b:	0f b7 5d 00          	movzwl 0x0(%ebp),%ebx
        brelse(bp);
  101c6f:	57                   	push   %edi
  101c70:	e8 5b e6 ff ff       	call   1002d0 <brelse>
        return iget(dp->dev, inum);
  101c75:	8b 44 24 14          	mov    0x14(%esp),%eax
  101c79:	89 da                	mov    %ebx,%edx
  101c7b:	8b 00                	mov    (%eax),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  101c7d:	83 c4 2c             	add    $0x2c,%esp
  101c80:	5b                   	pop    %ebx
  101c81:	5e                   	pop    %esi
  101c82:	5f                   	pop    %edi
  101c83:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101c84:	e9 f7 f4 ff ff       	jmp    101180 <iget>
  101c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }
    brelse(bp);
  101c90:	83 ec 0c             	sub    $0xc,%esp
  101c93:	57                   	push   %edi
  101c94:	e8 37 e6 ff ff       	call   1002d0 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101c99:	81 44 24 10 00 02 00 	addl   $0x200,0x10(%esp)
  101ca0:	00 
  101ca1:	8b 44 24 10          	mov    0x10(%esp),%eax
  101ca5:	83 c4 10             	add    $0x10,%esp
  101ca8:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  101cac:	39 41 18             	cmp    %eax,0x18(%ecx)
  101caf:	0f 87 43 ff ff ff    	ja     101bf8 <dirlookup+0x38>
      }
    }
    brelse(bp);
  }
  return 0;
}
  101cb5:	83 c4 1c             	add    $0x1c,%esp
  101cb8:	31 c0                	xor    %eax,%eax
  101cba:	5b                   	pop    %ebx
  101cbb:	5e                   	pop    %esi
  101cbc:	5f                   	pop    %edi
  101cbd:	5d                   	pop    %ebp
  101cbe:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101cbf:	83 ec 0c             	sub    $0xc,%esp
  101cc2:	68 b9 60 10 00       	push   $0x1060b9
  101cc7:	e8 54 ed ff ff       	call   100a20 <panic>
  101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101cd0 <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int parent, char *name)
{
  101cd0:	55                   	push   %ebp
  101cd1:	57                   	push   %edi
  101cd2:	89 cf                	mov    %ecx,%edi
  101cd4:	56                   	push   %esi
  101cd5:	53                   	push   %ebx
  101cd6:	89 c3                	mov    %eax,%ebx
  101cd8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
  101cdb:	80 38 2f             	cmpb   $0x2f,(%eax)
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int parent, char *name)
{
  101cde:	89 54 24 08          	mov    %edx,0x8(%esp)
  struct inode *ip, *next;

  if(*path == '/')
  101ce2:	0f 84 39 01 00 00    	je     101e21 <namex+0x151>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(cp->cwd);
  101ce8:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
  101ced:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(cp->cwd);
  101cf0:	65 8b 00             	mov    %gs:(%eax),%eax
  101cf3:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
  101cf6:	68 c0 ba 10 00       	push   $0x10bac0
  101cfb:	e8 40 20 00 00       	call   103d40 <acquire>
  ip->ref++;
  101d00:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
  101d04:	c7 04 24 c0 ba 10 00 	movl   $0x10bac0,(%esp)
  101d0b:	e8 10 22 00 00       	call   103f20 <release>
  101d10:	83 c4 10             	add    $0x10,%esp
  101d13:	eb 06                	jmp    101d1b <namex+0x4b>
  101d15:	8d 76 00             	lea    0x0(%esi),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101d18:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101d1b:	0f b6 03             	movzbl (%ebx),%eax
  101d1e:	3c 2f                	cmp    $0x2f,%al
  101d20:	74 f6                	je     101d18 <namex+0x48>
    path++;
  if(*path == 0)
  101d22:	84 c0                	test   %al,%al
  101d24:	0f 84 c7 00 00 00    	je     101df1 <namex+0x121>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101d2a:	0f b6 03             	movzbl (%ebx),%eax
  101d2d:	89 dd                	mov    %ebx,%ebp
  101d2f:	84 c0                	test   %al,%al
  101d31:	0f 84 95 00 00 00    	je     101dcc <namex+0xfc>
  101d37:	3c 2f                	cmp    $0x2f,%al
  101d39:	75 09                	jne    101d44 <namex+0x74>
  101d3b:	e9 8c 00 00 00       	jmp    101dcc <namex+0xfc>
  101d40:	84 c0                	test   %al,%al
  101d42:	74 0b                	je     101d4f <namex+0x7f>
    path++;
  101d44:	83 c5 01             	add    $0x1,%ebp
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101d47:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
  101d4b:	3c 2f                	cmp    $0x2f,%al
  101d4d:	75 f1                	jne    101d40 <namex+0x70>
  101d4f:	89 e9                	mov    %ebp,%ecx
  101d51:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  101d53:	83 f9 0d             	cmp    $0xd,%ecx
  101d56:	7e 78                	jle    101dd0 <namex+0x100>
    memmove(name, s, DIRSIZ);
  101d58:	83 ec 04             	sub    $0x4,%esp
  101d5b:	6a 0e                	push   $0xe
  101d5d:	53                   	push   %ebx
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
  101d5e:	89 eb                	mov    %ebp,%ebx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  101d60:	57                   	push   %edi
  101d61:	e8 8a 22 00 00       	call   103ff0 <memmove>
  101d66:	83 c4 10             	add    $0x10,%esp
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d69:	80 7d 00 2f          	cmpb   $0x2f,0x0(%ebp)
  101d6d:	75 09                	jne    101d78 <namex+0xa8>
  101d6f:	90                   	nop
    path++;
  101d70:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101d73:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  101d76:	74 f8                	je     101d70 <namex+0xa0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
  101d78:	83 ec 0c             	sub    $0xc,%esp
  101d7b:	56                   	push   %esi
  101d7c:	e8 7f f7 ff ff       	call   101500 <ilock>
    if(ip->type != T_DIR){
  101d81:	83 c4 10             	add    $0x10,%esp
  101d84:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  101d89:	75 78                	jne    101e03 <namex+0x133>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
  101d8b:	8b 54 24 08          	mov    0x8(%esp),%edx
  101d8f:	85 d2                	test   %edx,%edx
  101d91:	74 09                	je     101d9c <namex+0xcc>
  101d93:	80 3b 00             	cmpb   $0x0,(%ebx)
  101d96:	0f 84 9b 00 00 00    	je     101e37 <namex+0x167>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101d9c:	83 ec 04             	sub    $0x4,%esp
  101d9f:	6a 00                	push   $0x0
  101da1:	57                   	push   %edi
  101da2:	56                   	push   %esi
  101da3:	e8 18 fe ff ff       	call   101bc0 <dirlookup>
  101da8:	83 c4 10             	add    $0x10,%esp
  101dab:	85 c0                	test   %eax,%eax
  101dad:	89 c5                	mov    %eax,%ebp
  101daf:	74 52                	je     101e03 <namex+0x133>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  101db1:	83 ec 0c             	sub    $0xc,%esp
  101db4:	56                   	push   %esi
  101db5:	e8 56 f8 ff ff       	call   101610 <iunlock>
  iput(ip);
  101dba:	89 34 24             	mov    %esi,(%esp)
  101dbd:	89 ee                	mov    %ebp,%esi
  101dbf:	e8 dc f9 ff ff       	call   1017a0 <iput>
  101dc4:	83 c4 10             	add    $0x10,%esp
  101dc7:	e9 4f ff ff ff       	jmp    101d1b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101dcc:	31 c9                	xor    %ecx,%ecx
  101dce:	66 90                	xchg   %ax,%ax
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101dd0:	83 ec 04             	sub    $0x4,%esp
  101dd3:	51                   	push   %ecx
  101dd4:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  101dd8:	53                   	push   %ebx
    name[len] = 0;
  101dd9:	89 eb                	mov    %ebp,%ebx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101ddb:	57                   	push   %edi
  101ddc:	e8 0f 22 00 00       	call   103ff0 <memmove>
    name[len] = 0;
  101de1:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  101de5:	83 c4 10             	add    $0x10,%esp
  101de8:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
  101dec:	e9 78 ff ff ff       	jmp    101d69 <namex+0x99>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
  101df1:	8b 44 24 08          	mov    0x8(%esp),%eax
  101df5:	85 c0                	test   %eax,%eax
  101df7:	75 54                	jne    101e4d <namex+0x17d>
  101df9:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
  101dfb:	83 c4 1c             	add    $0x1c,%esp
  101dfe:	5b                   	pop    %ebx
  101dff:	5e                   	pop    %esi
  101e00:	5f                   	pop    %edi
  101e01:	5d                   	pop    %ebp
  101e02:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  101e03:	83 ec 0c             	sub    $0xc,%esp
  101e06:	56                   	push   %esi
  101e07:	e8 04 f8 ff ff       	call   101610 <iunlock>
  iput(ip);
  101e0c:	89 34 24             	mov    %esi,(%esp)
  101e0f:	e8 8c f9 ff ff       	call   1017a0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
  101e14:	83 c4 10             	add    $0x10,%esp
  101e17:	31 c0                	xor    %eax,%eax
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101e19:	83 c4 1c             	add    $0x1c,%esp
  101e1c:	5b                   	pop    %ebx
  101e1d:	5e                   	pop    %esi
  101e1e:	5f                   	pop    %edi
  101e1f:	5d                   	pop    %ebp
  101e20:	c3                   	ret    
namex(char *path, int parent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  101e21:	ba 01 00 00 00       	mov    $0x1,%edx
  101e26:	b8 01 00 00 00       	mov    $0x1,%eax
  101e2b:	e8 50 f3 ff ff       	call   101180 <iget>
  101e30:	89 c6                	mov    %eax,%esi
  101e32:	e9 e4 fe ff ff       	jmp    101d1b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101e37:	83 ec 0c             	sub    $0xc,%esp
  101e3a:	56                   	push   %esi
  101e3b:	e8 d0 f7 ff ff       	call   101610 <iunlock>
      return ip;
  101e40:	83 c4 10             	add    $0x10,%esp
  101e43:	89 f0                	mov    %esi,%eax
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101e45:	83 c4 1c             	add    $0x1c,%esp
  101e48:	5b                   	pop    %ebx
  101e49:	5e                   	pop    %esi
  101e4a:	5f                   	pop    %edi
  101e4b:	5d                   	pop    %ebp
  101e4c:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  101e4d:	83 ec 0c             	sub    $0xc,%esp
  101e50:	56                   	push   %esi
  101e51:	e8 4a f9 ff ff       	call   1017a0 <iput>
    return 0;
  101e56:	83 c4 10             	add    $0x10,%esp
  101e59:	31 c0                	xor    %eax,%eax
  101e5b:	eb 9e                	jmp    101dfb <namex+0x12b>
  101e5d:	8d 76 00             	lea    0x0(%esi),%esi

00101e60 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
  101e60:	55                   	push   %ebp
  101e61:	57                   	push   %edi
  101e62:	56                   	push   %esi
  101e63:	53                   	push   %ebx
  101e64:	83 ec 20             	sub    $0x20,%esp
  101e67:	8b 74 24 34          	mov    0x34(%esp),%esi
  101e6b:	8b 6c 24 38          	mov    0x38(%esp),%ebp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  101e6f:	6a 00                	push   $0x0
  101e71:	55                   	push   %ebp
  101e72:	56                   	push   %esi
  101e73:	e8 48 fd ff ff       	call   101bc0 <dirlookup>
  101e78:	83 c4 10             	add    $0x10,%esp
  101e7b:	85 c0                	test   %eax,%eax
  101e7d:	75 67                	jne    101ee6 <dirlink+0x86>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101e7f:	8b 5e 18             	mov    0x18(%esi),%ebx
  101e82:	89 e7                	mov    %esp,%edi
  101e84:	85 db                	test   %ebx,%ebx
  101e86:	74 29                	je     101eb1 <dirlink+0x51>
  101e88:	31 db                	xor    %ebx,%ebx
  101e8a:	89 e7                	mov    %esp,%edi
  101e8c:	eb 0a                	jmp    101e98 <dirlink+0x38>
  101e8e:	66 90                	xchg   %ax,%ax
  101e90:	83 c3 10             	add    $0x10,%ebx
  101e93:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101e96:	76 19                	jbe    101eb1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101e98:	6a 10                	push   $0x10
  101e9a:	53                   	push   %ebx
  101e9b:	57                   	push   %edi
  101e9c:	56                   	push   %esi
  101e9d:	e8 ae fa ff ff       	call   101950 <readi>
  101ea2:	83 c4 10             	add    $0x10,%esp
  101ea5:	83 f8 10             	cmp    $0x10,%eax
  101ea8:	75 4f                	jne    101ef9 <dirlink+0x99>
      panic("dirlink read");
    if(de.inum == 0)
  101eaa:	66 83 3c 24 00       	cmpw   $0x0,(%esp)
  101eaf:	75 df                	jne    101e90 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101eb1:	83 ec 04             	sub    $0x4,%esp
  101eb4:	6a 0e                	push   $0xe
  101eb6:	55                   	push   %ebp
  101eb7:	8d 44 24 0e          	lea    0xe(%esp),%eax
  101ebb:	50                   	push   %eax
  101ebc:	e8 ff 21 00 00       	call   1040c0 <strncpy>
  de.inum = inum;
  101ec1:	8b 44 24 48          	mov    0x48(%esp),%eax
  101ec5:	66 89 44 24 10       	mov    %ax,0x10(%esp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101eca:	6a 10                	push   $0x10
  101ecc:	53                   	push   %ebx
  101ecd:	57                   	push   %edi
  101ece:	56                   	push   %esi
  101ecf:	e8 8c fb ff ff       	call   101a60 <writei>
  101ed4:	83 c4 20             	add    $0x20,%esp
  101ed7:	83 f8 10             	cmp    $0x10,%eax
  101eda:	75 2a                	jne    101f06 <dirlink+0xa6>
    panic("dirlink");
  
  return 0;
  101edc:	31 c0                	xor    %eax,%eax
}
  101ede:	83 c4 1c             	add    $0x1c,%esp
  101ee1:	5b                   	pop    %ebx
  101ee2:	5e                   	pop    %esi
  101ee3:	5f                   	pop    %edi
  101ee4:	5d                   	pop    %ebp
  101ee5:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101ee6:	83 ec 0c             	sub    $0xc,%esp
  101ee9:	50                   	push   %eax
  101eea:	e8 b1 f8 ff ff       	call   1017a0 <iput>
    return -1;
  101eef:	83 c4 10             	add    $0x10,%esp
  101ef2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101ef7:	eb e5                	jmp    101ede <dirlink+0x7e>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101ef9:	83 ec 0c             	sub    $0xc,%esp
  101efc:	68 cb 60 10 00       	push   $0x1060cb
  101f01:	e8 1a eb ff ff       	call   100a20 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101f06:	83 ec 0c             	sub    $0xc,%esp
  101f09:	68 2b 66 10 00       	push   $0x10662b
  101f0e:	e8 0d eb ff ff       	call   100a20 <panic>
  101f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f20 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101f20:	83 ec 1c             	sub    $0x1c,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
  101f23:	31 d2                	xor    %edx,%edx
  101f25:	8b 44 24 20          	mov    0x20(%esp),%eax
  101f29:	8d 4c 24 02          	lea    0x2(%esp),%ecx
  101f2d:	e8 9e fd ff ff       	call   101cd0 <namex>
}
  101f32:	83 c4 1c             	add    $0x1c,%esp
  101f35:	c3                   	ret    
  101f36:	8d 76 00             	lea    0x0(%esi),%esi
  101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
  101f40:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101f44:	8b 44 24 04          	mov    0x4(%esp),%eax
  101f48:	ba 01 00 00 00       	mov    $0x1,%edx
  101f4d:	e9 7e fd ff ff       	jmp    101cd0 <namex>
  101f52:	66 90                	xchg   %ax,%ax
  101f54:	66 90                	xchg   %ax,%ax
  101f56:	66 90                	xchg   %ax,%ax
  101f58:	66 90                	xchg   %ax,%ax
  101f5a:	66 90                	xchg   %ax,%ax
  101f5c:	66 90                	xchg   %ax,%ax
  101f5e:	66 90                	xchg   %ax,%ax

00101f60 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  101f60:	56                   	push   %esi
  101f61:	53                   	push   %ebx
  101f62:	83 ec 04             	sub    $0x4,%esp
  if(b == 0)
  101f65:	85 c0                	test   %eax,%eax
  101f67:	0f 84 97 00 00 00    	je     102004 <idestart+0xa4>
  101f6d:	89 c3                	mov    %eax,%ebx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101f6f:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101f78:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  101f79:	83 e0 c0             	and    $0xffffffc0,%eax
  101f7c:	3c 40                	cmp    $0x40,%al
  101f7e:	75 f8                	jne    101f78 <idestart+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101f80:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101f85:	31 c0                	xor    %eax,%eax
  101f87:	ee                   	out    %al,(%dx)
  101f88:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101f8d:	b8 01 00 00 00       	mov    $0x1,%eax
  101f92:	ee                   	out    %al,(%dx)
    panic("idestart");

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101f93:	8b 4b 08             	mov    0x8(%ebx),%ecx
  101f96:	ba f3 01 00 00       	mov    $0x1f3,%edx
  101f9b:	89 c8                	mov    %ecx,%eax
  101f9d:	ee                   	out    %al,(%dx)
  101f9e:	89 c8                	mov    %ecx,%eax
  101fa0:	ba f4 01 00 00       	mov    $0x1f4,%edx
  101fa5:	c1 e8 08             	shr    $0x8,%eax
  101fa8:	ee                   	out    %al,(%dx)
  101fa9:	89 c8                	mov    %ecx,%eax
  101fab:	ba f5 01 00 00       	mov    $0x1f5,%edx
  101fb0:	c1 e8 10             	shr    $0x10,%eax
  101fb3:	ee                   	out    %al,(%dx)
  101fb4:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
  101fb8:	c1 e9 18             	shr    $0x18,%ecx
  101fbb:	ba f6 01 00 00       	mov    $0x1f6,%edx
  101fc0:	83 e1 0f             	and    $0xf,%ecx
  101fc3:	83 e0 01             	and    $0x1,%eax
  101fc6:	c1 e0 04             	shl    $0x4,%eax
  101fc9:	09 c8                	or     %ecx,%eax
  101fcb:	83 c8 e0             	or     $0xffffffe0,%eax
  101fce:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  101fcf:	f6 03 04             	testb  $0x4,(%ebx)
  101fd2:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101fd7:	75 0f                	jne    101fe8 <idestart+0x88>
  101fd9:	b8 20 00 00 00       	mov    $0x20,%eax
  101fde:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101fdf:	83 c4 04             	add    $0x4,%esp
  101fe2:	5b                   	pop    %ebx
  101fe3:	5e                   	pop    %esi
  101fe4:	c3                   	ret    
  101fe5:	8d 76 00             	lea    0x0(%esi),%esi
  101fe8:	b8 30 00 00 00       	mov    $0x30,%eax
  101fed:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
  101fee:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  101ff3:	8d 73 18             	lea    0x18(%ebx),%esi
  101ff6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  101ffb:	fc                   	cld    
  101ffc:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  101ffe:	83 c4 04             	add    $0x4,%esp
  102001:	5b                   	pop    %ebx
  102002:	5e                   	pop    %esi
  102003:	c3                   	ret    
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  102004:	83 ec 0c             	sub    $0xc,%esp
  102007:	68 d8 60 10 00       	push   $0x1060d8
  10200c:	e8 0f ea ff ff       	call   100a20 <panic>
  102011:	eb 0d                	jmp    102020 <ideinit>
  102013:	90                   	nop
  102014:	90                   	nop
  102015:	90                   	nop
  102016:	90                   	nop
  102017:	90                   	nop
  102018:	90                   	nop
  102019:	90                   	nop
  10201a:	90                   	nop
  10201b:	90                   	nop
  10201c:	90                   	nop
  10201d:	90                   	nop
  10201e:	90                   	nop
  10201f:	90                   	nop

00102020 <ideinit>:
  return 0;
}

void
ideinit(void)
{
  102020:	83 ec 14             	sub    $0x14,%esp
  int i;

  initlock(&idelock, "ide");
  102023:	68 e1 60 10 00       	push   $0x1060e1
  102028:	68 40 98 10 00       	push   $0x109840
  10202d:	e8 ee 1c 00 00       	call   103d20 <initlock>
  picenable(IRQ_IDE);
  102032:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  102039:	e8 42 0c 00 00       	call   102c80 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
  10203e:	58                   	pop    %eax
  10203f:	a1 e0 d0 10 00       	mov    0x10d0e0,%eax
  102044:	5a                   	pop    %edx
  102045:	83 e8 01             	sub    $0x1,%eax
  102048:	50                   	push   %eax
  102049:	6a 0e                	push   $0xe
  10204b:	e8 c0 02 00 00       	call   102310 <ioapicenable>
  102050:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102053:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102058:	90                   	nop
  102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102060:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  102061:	83 e0 c0             	and    $0xffffffc0,%eax
  102064:	3c 40                	cmp    $0x40,%al
  102066:	75 f8                	jne    102060 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102068:	ba f6 01 00 00       	mov    $0x1f6,%edx
  10206d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  102072:	ee                   	out    %al,(%dx)
  102073:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102078:	ba f7 01 00 00       	mov    $0x1f7,%edx
  10207d:	eb 06                	jmp    102085 <ideinit+0x65>
  10207f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102080:	83 e9 01             	sub    $0x1,%ecx
  102083:	74 0f                	je     102094 <ideinit+0x74>
  102085:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102086:	84 c0                	test   %al,%al
  102088:	74 f6                	je     102080 <ideinit+0x60>
      havedisk1 = 1;
  10208a:	c7 05 20 98 10 00 01 	movl   $0x1,0x109820
  102091:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102094:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102099:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10209e:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10209f:	83 c4 0c             	add    $0xc,%esp
  1020a2:	c3                   	ret    
  1020a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1020a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001020b0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
  1020b0:	57                   	push   %edi
  1020b1:	56                   	push   %esi
  1020b2:	53                   	push   %ebx
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  1020b3:	83 ec 0c             	sub    $0xc,%esp
  1020b6:	68 40 98 10 00       	push   $0x109840
  1020bb:	e8 80 1c 00 00       	call   103d40 <acquire>
  if((b = idequeue) == 0){
  1020c0:	8b 1d 24 98 10 00    	mov    0x109824,%ebx
  1020c6:	83 c4 10             	add    $0x10,%esp
  1020c9:	85 db                	test   %ebx,%ebx
  1020cb:	74 76                	je     102143 <ideintr+0x93>
    return;
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1020cd:	8b 33                	mov    (%ebx),%esi
  if((b = idequeue) == 0){
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  1020cf:	8b 43 14             	mov    0x14(%ebx),%eax

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1020d2:	f7 c6 04 00 00 00    	test   $0x4,%esi
  if((b = idequeue) == 0){
    release(&idelock);
    cprintf("Spurious IDE interrupt.\n");
    return;
  }
  idequeue = b->qnext;
  1020d8:	a3 24 98 10 00       	mov    %eax,0x109824

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
  1020dd:	74 39                	je     102118 <ideintr+0x68>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  1020df:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
  1020e2:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  1020e5:	83 ce 02             	or     $0x2,%esi
  1020e8:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
  1020ea:	53                   	push   %ebx
  1020eb:	e8 60 18 00 00       	call   103950 <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
  1020f0:	a1 24 98 10 00       	mov    0x109824,%eax
  1020f5:	83 c4 10             	add    $0x10,%esp
  1020f8:	85 c0                	test   %eax,%eax
  1020fa:	74 05                	je     102101 <ideintr+0x51>
    idestart(idequeue);
  1020fc:	e8 5f fe ff ff       	call   101f60 <idestart>

  release(&idelock);
  102101:	83 ec 0c             	sub    $0xc,%esp
  102104:	68 40 98 10 00       	push   $0x109840
  102109:	e8 12 1e 00 00       	call   103f20 <release>
  10210e:	83 c4 10             	add    $0x10,%esp
}
  102111:	5b                   	pop    %ebx
  102112:	5e                   	pop    %esi
  102113:	5f                   	pop    %edi
  102114:	c3                   	ret    
  102115:	8d 76 00             	lea    0x0(%esi),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102118:	ba f7 01 00 00       	mov    $0x1f7,%edx
  10211d:	8d 76 00             	lea    0x0(%esi),%esi
  102120:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
  102121:	89 c1                	mov    %eax,%ecx
  102123:	83 e1 c0             	and    $0xffffffc0,%ecx
  102126:	80 f9 40             	cmp    $0x40,%cl
  102129:	75 f5                	jne    102120 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
  10212b:	a8 21                	test   $0x21,%al
  10212d:	75 b0                	jne    1020df <ideintr+0x2f>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, 512/4);
  10212f:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
  102132:	b9 80 00 00 00       	mov    $0x80,%ecx
  102137:	ba f0 01 00 00       	mov    $0x1f0,%edx
  10213c:	fc                   	cld    
  10213d:	f3 6d                	rep insl (%dx),%es:(%edi)
  10213f:	8b 33                	mov    (%ebx),%esi
  102141:	eb 9c                	jmp    1020df <ideintr+0x2f>
  struct buf *b;

  // Take first buffer off queue.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
  102143:	83 ec 0c             	sub    $0xc,%esp
  102146:	68 40 98 10 00       	push   $0x109840
  10214b:	e8 d0 1d 00 00       	call   103f20 <release>
    cprintf("Spurious IDE interrupt.\n");
  102150:	c7 04 24 e5 60 10 00 	movl   $0x1060e5,(%esp)
  102157:	e8 44 e5 ff ff       	call   1006a0 <cprintf>
    return;
  10215c:	83 c4 10             	add    $0x10,%esp
  10215f:	eb b0                	jmp    102111 <ideintr+0x61>
  102161:	eb 0d                	jmp    102170 <iderw>
  102163:	90                   	nop
  102164:	90                   	nop
  102165:	90                   	nop
  102166:	90                   	nop
  102167:	90                   	nop
  102168:	90                   	nop
  102169:	90                   	nop
  10216a:	90                   	nop
  10216b:	90                   	nop
  10216c:	90                   	nop
  10216d:	90                   	nop
  10216e:	90                   	nop
  10216f:	90                   	nop

00102170 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
  102170:	53                   	push   %ebx
  102171:	83 ec 08             	sub    $0x8,%esp
  102174:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  102178:	8b 03                	mov    (%ebx),%eax
  10217a:	a8 01                	test   $0x1,%al
  10217c:	0f 84 aa 00 00 00    	je     10222c <iderw+0xbc>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  102182:	83 e0 06             	and    $0x6,%eax
  102185:	83 f8 02             	cmp    $0x2,%eax
  102188:	0f 84 b8 00 00 00    	je     102246 <iderw+0xd6>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
  10218e:	8b 53 04             	mov    0x4(%ebx),%edx
  102191:	85 d2                	test   %edx,%edx
  102193:	74 0d                	je     1021a2 <iderw+0x32>
  102195:	a1 20 98 10 00       	mov    0x109820,%eax
  10219a:	85 c0                	test   %eax,%eax
  10219c:	0f 84 97 00 00 00    	je     102239 <iderw+0xc9>
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);
  1021a2:	83 ec 0c             	sub    $0xc,%esp
  1021a5:	68 40 98 10 00       	push   $0x109840
  1021aa:	e8 91 1b 00 00       	call   103d40 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  1021af:	8b 15 24 98 10 00    	mov    0x109824,%edx
  1021b5:	83 c4 10             	add    $0x10,%esp
    panic("idrw: ide disk 1 not present");

  acquire(&idelock);

  // Append b to idequeue.
  b->qnext = 0;
  1021b8:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  1021bf:	85 d2                	test   %edx,%edx
  1021c1:	75 07                	jne    1021ca <iderw+0x5a>
  1021c3:	eb 57                	jmp    10221c <iderw+0xac>
  1021c5:	8d 76 00             	lea    0x0(%esi),%esi
  1021c8:	89 c2                	mov    %eax,%edx
  1021ca:	8b 42 14             	mov    0x14(%edx),%eax
  1021cd:	85 c0                	test   %eax,%eax
  1021cf:	75 f7                	jne    1021c8 <iderw+0x58>
  1021d1:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
  1021d4:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(idequeue == b)
  1021d6:	3b 1d 24 98 10 00    	cmp    0x109824,%ebx
  1021dc:	74 45                	je     102223 <iderw+0xb3>
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1021de:	8b 03                	mov    (%ebx),%eax
  1021e0:	83 e0 06             	and    $0x6,%eax
  1021e3:	83 f8 02             	cmp    $0x2,%eax
  1021e6:	74 23                	je     10220b <iderw+0x9b>
  1021e8:	90                   	nop
  1021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
  1021f0:	83 ec 08             	sub    $0x8,%esp
  1021f3:	68 40 98 10 00       	push   $0x109840
  1021f8:	53                   	push   %ebx
  1021f9:	e8 a2 16 00 00       	call   1038a0 <sleep>
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1021fe:	8b 03                	mov    (%ebx),%eax
  102200:	83 c4 10             	add    $0x10,%esp
  102203:	83 e0 06             	and    $0x6,%eax
  102206:	83 f8 02             	cmp    $0x2,%eax
  102209:	75 e5                	jne    1021f0 <iderw+0x80>
    sleep(b, &idelock);

  release(&idelock);
  10220b:	c7 44 24 10 40 98 10 	movl   $0x109840,0x10(%esp)
  102212:	00 
}
  102213:	83 c4 08             	add    $0x8,%esp
  102216:	5b                   	pop    %ebx
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &idelock);

  release(&idelock);
  102217:	e9 04 1d 00 00       	jmp    103f20 <release>

  acquire(&idelock);

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)
  10221c:	ba 24 98 10 00       	mov    $0x109824,%edx
  102221:	eb b1                	jmp    1021d4 <iderw+0x64>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  102223:	89 d8                	mov    %ebx,%eax
  102225:	e8 36 fd ff ff       	call   101f60 <idestart>
  10222a:	eb b2                	jmp    1021de <iderw+0x6e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  10222c:	83 ec 0c             	sub    $0xc,%esp
  10222f:	68 fe 60 10 00       	push   $0x1060fe
  102234:	e8 e7 e7 ff ff       	call   100a20 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("idrw: ide disk 1 not present");
  102239:	83 ec 0c             	sub    $0xc,%esp
  10223c:	68 27 61 10 00       	push   $0x106127
  102241:	e8 da e7 ff ff       	call   100a20 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  102246:	83 ec 0c             	sub    $0xc,%esp
  102249:	68 12 61 10 00       	push   $0x106112
  10224e:	e8 cd e7 ff ff       	call   100a20 <panic>
  102253:	66 90                	xchg   %ax,%ax
  102255:	66 90                	xchg   %ax,%ax
  102257:	66 90                	xchg   %ax,%ax
  102259:	66 90                	xchg   %ax,%ax
  10225b:	66 90                	xchg   %ax,%ax
  10225d:	66 90                	xchg   %ax,%ax
  10225f:	90                   	nop

00102260 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
  102260:	a1 e4 ca 10 00       	mov    0x10cae4,%eax
  102265:	85 c0                	test   %eax,%eax
  102267:	0f 84 99 00 00 00    	je     102306 <ioapicinit+0xa6>
  ioapic->data = data;
}

void
ioapicinit(void)
{
  10226d:	57                   	push   %edi
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  10226e:	c7 05 94 ca 10 00 00 	movl   $0xfec00000,0x10ca94
  102275:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
  102278:	56                   	push   %esi
  102279:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  10227a:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  102281:	00 00 00 
  return ioapic->data;
  102284:	8b 3d 10 00 c0 fe    	mov    0xfec00010,%edi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  10228a:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  102291:	00 00 00 
  return ioapic->data;
  102294:	8b 15 10 00 c0 fe    	mov    0xfec00010,%edx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  10229a:	0f b6 0d e0 ca 10 00 	movzbl 0x10cae0,%ecx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  1022a1:	89 f8                	mov    %edi,%eax
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1022a3:	c1 ea 18             	shr    $0x18,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  1022a6:	c1 e8 10             	shr    $0x10,%eax
  1022a9:	0f b6 f8             	movzbl %al,%edi
  1022ac:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
  1022b1:	39 ca                	cmp    %ecx,%edx
  1022b3:	74 15                	je     1022ca <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
  1022b5:	83 ec 0c             	sub    $0xc,%esp
  1022b8:	68 44 61 10 00       	push   $0x106144
  1022bd:	e8 de e3 ff ff       	call   1006a0 <cprintf>
  1022c2:	a1 94 ca 10 00       	mov    0x10ca94,%eax
  1022c7:	83 c4 10             	add    $0x10,%esp
  1022ca:	83 c7 21             	add    $0x21,%edi
  1022cd:	b9 11 00 00 00       	mov    $0x11,%ecx
  1022d2:	ba 20 00 00 00       	mov    $0x20,%edx
  1022d7:	89 f6                	mov    %esi,%esi
  1022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  1022e0:	89 d3                	mov    %edx,%ebx
  1022e2:	8d 71 ff             	lea    -0x1(%ecx),%esi
  1022e5:	83 c2 01             	add    $0x1,%edx
  1022e8:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  1022ee:	89 30                	mov    %esi,(%eax)
  ioapic->data = data;
  1022f0:	89 58 10             	mov    %ebx,0x10(%eax)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  1022f3:	89 08                	mov    %ecx,(%eax)
  1022f5:	83 c1 02             	add    $0x2,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  1022f8:	39 fa                	cmp    %edi,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  1022fa:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  102301:	75 dd                	jne    1022e0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
  102303:	5b                   	pop    %ebx
  102304:	5e                   	pop    %esi
  102305:	5f                   	pop    %edi
  102306:	f3 c3                	repz ret 
  102308:	90                   	nop
  102309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102310 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
  102310:	8b 15 e4 ca 10 00    	mov    0x10cae4,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
  102316:	8b 44 24 04          	mov    0x4(%esp),%eax
  if(!ismp)
  10231a:	85 d2                	test   %edx,%edx
  10231c:	74 20                	je     10233e <ioapicenable+0x2e>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  10231e:	8d 48 20             	lea    0x20(%eax),%ecx
  102321:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102325:	a1 94 ca 10 00       	mov    0x10ca94,%eax
  10232a:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
  10232c:	89 48 10             	mov    %ecx,0x10(%eax)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  10232f:	83 c2 01             	add    $0x1,%edx

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102332:	8b 4c 24 08          	mov    0x8(%esp),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  102336:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
  102338:	c1 e1 18             	shl    $0x18,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  10233b:	89 48 10             	mov    %ecx,0x10(%eax)
  10233e:	f3 c3                	repz ret 

00102340 <kfree>:
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102340:	55                   	push   %ebp
  102341:	57                   	push   %edi
  102342:	56                   	push   %esi
  102343:	53                   	push   %ebx
  102344:	83 ec 0c             	sub    $0xc,%esp
  102347:	8b 7c 24 24          	mov    0x24(%esp),%edi
  10234b:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  10234f:	85 ff                	test   %edi,%edi
  102351:	0f 8e e4 00 00 00    	jle    10243b <kfree+0xfb>
  102357:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
  10235d:	0f 85 d8 00 00 00    	jne    10243b <kfree+0xfb>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102363:	83 ec 04             	sub    $0x4,%esp

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  102366:	8d 34 3b             	lea    (%ebx,%edi,1),%esi

  if(len <= 0 || len % PAGE)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102369:	57                   	push   %edi
  10236a:	6a 01                	push   $0x1
  10236c:	53                   	push   %ebx
  10236d:	e8 fe 1b 00 00       	call   103f70 <memset>

  acquire(&kmem.lock);
  102372:	c7 04 24 a0 ca 10 00 	movl   $0x10caa0,(%esp)
  102379:	e8 c2 19 00 00       	call   103d40 <acquire>
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10237e:	a1 d4 ca 10 00       	mov    0x10cad4,%eax
  102383:	83 c4 10             	add    $0x10,%esp
  102386:	85 c0                	test   %eax,%eax
  102388:	74 63                	je     1023ed <kfree+0xad>
  10238a:	39 c6                	cmp    %eax,%esi
  10238c:	72 5f                	jb     1023ed <kfree+0xad>
    rend = (struct run*)((char*)r + r->len);
  10238e:	8b 48 04             	mov    0x4(%eax),%ecx
    if(r <= p && p < rend)
  102391:	39 c3                	cmp    %eax,%ebx

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
  102393:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    if(r <= p && p < rend)
  102396:	72 08                	jb     1023a0 <kfree+0x60>
  102398:	39 d3                	cmp    %edx,%ebx
  10239a:	0f 82 8e 00 00 00    	jb     10242e <kfree+0xee>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  1023a0:	39 c6                	cmp    %eax,%esi
  1023a2:	75 2a                	jne    1023ce <kfree+0x8e>
  1023a4:	eb 6e                	jmp    102414 <kfree+0xd4>
  1023a6:	8d 76 00             	lea    0x0(%esi),%esi
  1023a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  memset(v, 1, len);

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023b0:	89 c5                	mov    %eax,%ebp
  1023b2:	8b 00                	mov    (%eax),%eax
  1023b4:	85 c0                	test   %eax,%eax
  1023b6:	74 40                	je     1023f8 <kfree+0xb8>
  1023b8:	39 c6                	cmp    %eax,%esi
  1023ba:	72 3c                	jb     1023f8 <kfree+0xb8>
    rend = (struct run*)((char*)r + r->len);
  1023bc:	8b 48 04             	mov    0x4(%eax),%ecx
    if(r <= p && p < rend)
  1023bf:	39 c3                	cmp    %eax,%ebx

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
  1023c1:	8d 14 08             	lea    (%eax,%ecx,1),%edx
    if(r <= p && p < rend)
  1023c4:	72 04                	jb     1023ca <kfree+0x8a>
  1023c6:	39 d3                	cmp    %edx,%ebx
  1023c8:	72 64                	jb     10242e <kfree+0xee>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  1023ca:	39 c6                	cmp    %eax,%esi
  1023cc:	74 52                	je     102420 <kfree+0xe0>
      p->len = len + r->len;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
  1023ce:	39 d3                	cmp    %edx,%ebx
  1023d0:	75 de                	jne    1023b0 <kfree+0x70>
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
  1023d2:	8b 10                	mov    (%eax),%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  1023d4:	01 f9                	add    %edi,%ecx
  1023d6:	89 48 04             	mov    %ecx,0x4(%eax)
      if(r->next && r->next == pend){  // r now next to r->next?
  1023d9:	39 d6                	cmp    %edx,%esi
  1023db:	75 23                	jne    102400 <kfree+0xc0>
  1023dd:	85 d2                	test   %edx,%edx
  1023df:	74 1f                	je     102400 <kfree+0xc0>
        r->len += r->next->len;
  1023e1:	03 4a 04             	add    0x4(%edx),%ecx
        r->next = r->next->next;
  1023e4:	8b 12                	mov    (%edx),%edx
  1023e6:	89 10                	mov    %edx,(%eax)
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->len += r->next->len;
  1023e8:	89 48 04             	mov    %ecx,0x4(%eax)
  1023eb:	eb 13                	jmp    102400 <kfree+0xc0>
  memset(v, 1, len);

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1023ed:	bd d4 ca 10 00       	mov    $0x10cad4,%ebp
  1023f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1023f8:	89 7b 04             	mov    %edi,0x4(%ebx)
  p->next = r;
  1023fb:	89 03                	mov    %eax,(%ebx)
  *rp = p;
  1023fd:	89 5d 00             	mov    %ebx,0x0(%ebp)

 out:
  release(&kmem.lock);
  102400:	c7 44 24 20 a0 ca 10 	movl   $0x10caa0,0x20(%esp)
  102407:	00 
}
  102408:	83 c4 0c             	add    $0xc,%esp
  10240b:	5b                   	pop    %ebx
  10240c:	5e                   	pop    %esi
  10240d:	5f                   	pop    %edi
  10240e:	5d                   	pop    %ebp
  p->len = len;
  p->next = r;
  *rp = p;

 out:
  release(&kmem.lock);
  10240f:	e9 0c 1b 00 00       	jmp    103f20 <release>
  memset(v, 1, len);

  acquire(&kmem.lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102414:	bd d4 ca 10 00       	mov    $0x10cad4,%ebp
  102419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
      p->next = r->next;
  102420:	8b 00                	mov    (%eax),%eax
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
  102422:	01 f9                	add    %edi,%ecx
  102424:	89 4b 04             	mov    %ecx,0x4(%ebx)
      p->next = r->next;
  102427:	89 03                	mov    %eax,(%ebx)
      *rp = p;
  102429:	89 5d 00             	mov    %ebx,0x0(%ebp)
      goto out;
  10242c:	eb d2                	jmp    102400 <kfree+0xc0>
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&kmem.freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
  10242e:	83 ec 0c             	sub    $0xc,%esp
  102431:	68 7c 61 10 00       	push   $0x10617c
  102436:	e8 e5 e5 ff ff       	call   100a20 <panic>
kfree(char *v, int len)
{
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
    panic("kfree");
  10243b:	83 ec 0c             	sub    $0xc,%esp
  10243e:	68 76 61 10 00       	push   $0x106176
  102443:	e8 d8 e5 ff ff       	call   100a20 <panic>
  102448:	90                   	nop
  102449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102450 <kinit>:
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  102450:	83 ec 14             	sub    $0x14,%esp
  extern int end;
  uint mem;
  char *start;

  initlock(&kmem.lock, "kmem");
  102453:	68 8e 61 10 00       	push   $0x10618e
  102458:	68 a0 ca 10 00       	push   $0x10caa0
  10245d:	e8 be 18 00 00       	call   103d20 <initlock>
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  102462:	58                   	pop    %eax
  102463:	5a                   	pop    %edx
  102464:	68 00 00 10 00       	push   $0x100000
  102469:	68 93 61 10 00       	push   $0x106193
  10246e:	e8 2d e2 ff ff       	call   1006a0 <cprintf>
  kfree(start, mem * PAGE);
  102473:	59                   	pop    %ecx
  102474:	58                   	pop    %eax
  102475:	b8 84 08 11 00       	mov    $0x110884,%eax
  10247a:	68 00 00 10 00       	push   $0x100000
  10247f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  102484:	50                   	push   %eax
  102485:	e8 b6 fe ff ff       	call   102340 <kfree>
}
  10248a:	83 c4 1c             	add    $0x1c,%esp
  10248d:	c3                   	ret    
  10248e:	66 90                	xchg   %ax,%ax

00102490 <kalloc>:
// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(int n)
{
  102490:	56                   	push   %esi
  102491:	53                   	push   %ebx
  102492:	83 ec 04             	sub    $0x4,%esp
  102495:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  102499:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  10249f:	0f 85 a4 00 00 00    	jne    102549 <kalloc+0xb9>
  1024a5:	85 f6                	test   %esi,%esi
  1024a7:	0f 8e 9c 00 00 00    	jle    102549 <kalloc+0xb9>
    panic("kalloc");

  acquire(&kmem.lock);
  1024ad:	83 ec 0c             	sub    $0xc,%esp
  1024b0:	68 a0 ca 10 00       	push   $0x10caa0
  1024b5:	e8 86 18 00 00       	call   103d40 <acquire>
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  1024ba:	8b 15 d4 ca 10 00    	mov    0x10cad4,%edx
  1024c0:	83 c4 10             	add    $0x10,%esp
  1024c3:	85 d2                	test   %edx,%edx
  1024c5:	74 22                	je     1024e9 <kalloc+0x59>
    if(r->len == n){
  1024c7:	8b 42 04             	mov    0x4(%edx),%eax
  1024ca:	39 c6                	cmp    %eax,%esi
  1024cc:	74 3f                	je     10250d <kalloc+0x7d>
      *rp = r->next;
      release(&kmem.lock);
      return (char*)r;
    }
    if(r->len > n){
  1024ce:	7d 13                	jge    1024e3 <kalloc+0x53>
  1024d0:	eb 62                	jmp    102534 <kalloc+0xa4>
  1024d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kmem.lock);
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
    if(r->len == n){
  1024d8:	8b 43 04             	mov    0x4(%ebx),%eax
  1024db:	39 c6                	cmp    %eax,%esi
  1024dd:	74 39                	je     102518 <kalloc+0x88>
  1024df:	89 da                	mov    %ebx,%edx
      *rp = r->next;
      release(&kmem.lock);
      return (char*)r;
    }
    if(r->len > n){
  1024e1:	7c 5d                	jl     102540 <kalloc+0xb0>

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kmem.lock);
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  1024e3:	8b 1a                	mov    (%edx),%ebx
  1024e5:	85 db                	test   %ebx,%ebx
  1024e7:	75 ef                	jne    1024d8 <kalloc+0x48>
      p = (char*)r + r->len;
      release(&kmem.lock);
      return p;
    }
  }
  release(&kmem.lock);
  1024e9:	83 ec 0c             	sub    $0xc,%esp
  1024ec:	68 a0 ca 10 00       	push   $0x10caa0
  1024f1:	e8 2a 1a 00 00       	call   103f20 <release>

  cprintf("kalloc: out of memory\n");
  1024f6:	c7 04 24 a4 61 10 00 	movl   $0x1061a4,(%esp)
  1024fd:	e8 9e e1 ff ff       	call   1006a0 <cprintf>
  return 0;
  102502:	83 c4 10             	add    $0x10,%esp
  102505:	31 c0                	xor    %eax,%eax
}
  102507:	83 c4 04             	add    $0x4,%esp
  10250a:	5b                   	pop    %ebx
  10250b:	5e                   	pop    %esi
  10250c:	c3                   	ret    
  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kmem.lock);
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
    if(r->len == n){
  10250d:	89 d3                	mov    %edx,%ebx

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kmem.lock);
  for(rp=&kmem.freelist; (r=*rp) != 0; rp=&r->next){
  10250f:	ba d4 ca 10 00       	mov    $0x10cad4,%edx
  102514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(r->len == n){
      *rp = r->next;
  102518:	8b 03                	mov    (%ebx),%eax
  10251a:	89 02                	mov    %eax,(%edx)
      return (char*)r;
    }
    if(r->len > n){
      r->len -= n;
      p = (char*)r + r->len;
      release(&kmem.lock);
  10251c:	83 ec 0c             	sub    $0xc,%esp
  10251f:	68 a0 ca 10 00       	push   $0x10caa0
  102524:	e8 f7 19 00 00       	call   103f20 <release>
      return p;
  102529:	83 c4 10             	add    $0x10,%esp
  10252c:	89 d8                	mov    %ebx,%eax
  }
  release(&kmem.lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  10252e:	83 c4 04             	add    $0x4,%esp
  102531:	5b                   	pop    %ebx
  102532:	5e                   	pop    %esi
  102533:	c3                   	ret    
    if(r->len == n){
      *rp = r->next;
      release(&kmem.lock);
      return (char*)r;
    }
    if(r->len > n){
  102534:	89 d3                	mov    %edx,%ebx
  102536:	8d 76 00             	lea    0x0(%esi),%esi
  102539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      r->len -= n;
  102540:	29 f0                	sub    %esi,%eax
  102542:	89 43 04             	mov    %eax,0x4(%ebx)
      p = (char*)r + r->len;
  102545:	01 c3                	add    %eax,%ebx
  102547:	eb d3                	jmp    10251c <kalloc+0x8c>
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
    panic("kalloc");
  102549:	83 ec 0c             	sub    $0xc,%esp
  10254c:	68 9d 61 10 00       	push   $0x10619d
  102551:	e8 ca e4 ff ff       	call   100a20 <panic>
  102556:	66 90                	xchg   %ax,%ax
  102558:	66 90                	xchg   %ax,%ax
  10255a:	66 90                	xchg   %ax,%ax
  10255c:	66 90                	xchg   %ax,%ax
  10255e:	66 90                	xchg   %ax,%ax

00102560 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102560:	ba 64 00 00 00       	mov    $0x64,%edx
  102565:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  102566:	a8 01                	test   $0x1,%al
  102568:	0f 84 92 00 00 00    	je     102600 <kbdgetc+0xa0>
  10256e:	ba 60 00 00 00       	mov    $0x60,%edx
  102573:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  102574:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
  102577:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
  10257d:	0f 84 8d 00 00 00    	je     102610 <kbdgetc+0xb0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102583:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  102585:	8b 0d 74 98 10 00    	mov    0x109874,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  10258b:	79 23                	jns    1025b0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  10258d:	f6 c1 40             	test   $0x40,%cl
  102590:	75 05                	jne    102597 <kbdgetc+0x37>
  102592:	89 c2                	mov    %eax,%edx
  102594:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
  102597:	0f b6 82 e0 62 10 00 	movzbl 0x1062e0(%edx),%eax
  10259e:	83 c8 40             	or     $0x40,%eax
  1025a1:	0f b6 c0             	movzbl %al,%eax
  1025a4:	f7 d0                	not    %eax
  1025a6:	21 c8                	and    %ecx,%eax
  1025a8:	a3 74 98 10 00       	mov    %eax,0x109874
    return 0;
  1025ad:	31 c0                	xor    %eax,%eax
  1025af:	c3                   	ret    
  } else if(shift & E0ESC){
  1025b0:	f6 c1 40             	test   $0x40,%cl
  1025b3:	74 09                	je     1025be <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1025b5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
  1025b8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1025bb:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025be:	0f b6 82 e0 62 10 00 	movzbl 0x1062e0(%edx),%eax
  1025c5:	09 c1                	or     %eax,%ecx
  1025c7:	0f b6 82 e0 61 10 00 	movzbl 0x1061e0(%edx),%eax
  1025ce:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
  1025d0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025d2:	89 0d 74 98 10 00    	mov    %ecx,0x109874
  c = charcode[shift & (CTL | SHIFT)][data];
  1025d8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
  1025db:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  1025de:	8b 04 85 c0 61 10 00 	mov    0x1061c0(,%eax,4),%eax
  1025e5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
  1025e9:	74 1a                	je     102605 <kbdgetc+0xa5>
    if('a' <= c && c <= 'z')
  1025eb:	8d 50 9f             	lea    -0x61(%eax),%edx
  1025ee:	83 fa 19             	cmp    $0x19,%edx
  1025f1:	77 2d                	ja     102620 <kbdgetc+0xc0>
      c += 'A' - 'a';
  1025f3:	83 e8 20             	sub    $0x20,%eax
  1025f6:	c3                   	ret    
  1025f7:	89 f6                	mov    %esi,%esi
  1025f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  102600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102605:	f3 c3                	repz ret 
  102607:	89 f6                	mov    %esi,%esi
  102609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102610:	83 0d 74 98 10 00 40 	orl    $0x40,0x109874
    return 0;
  102617:	31 c0                	xor    %eax,%eax
  102619:	c3                   	ret    
  10261a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102620:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
  102623:	8d 50 20             	lea    0x20(%eax),%edx
  102626:	83 f9 19             	cmp    $0x19,%ecx
  102629:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
  10262c:	c3                   	ret    
  10262d:	8d 76 00             	lea    0x0(%esi),%esi

00102630 <kbdintr>:
}

void
kbdintr(void)
{
  102630:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
  102633:	68 60 25 10 00       	push   $0x102560
  102638:	e8 13 e2 ff ff       	call   100850 <consoleintr>
}
  10263d:	83 c4 1c             	add    $0x1c,%esp
  102640:	c3                   	ret    
  102641:	66 90                	xchg   %ax,%ax
  102643:	66 90                	xchg   %ax,%ax
  102645:	66 90                	xchg   %ax,%ax
  102647:	66 90                	xchg   %ax,%ax
  102649:	66 90                	xchg   %ax,%ax
  10264b:	66 90                	xchg   %ax,%ax
  10264d:	66 90                	xchg   %ax,%ax
  10264f:	90                   	nop

00102650 <lapicinit>:

//PAGEBREAK!
void
lapicinit(int c)
{
  if(!lapic) 
  102650:	a1 d8 ca 10 00       	mov    0x10cad8,%eax
  102655:	85 c0                	test   %eax,%eax
  102657:	0f 84 c3 00 00 00    	je     102720 <lapicinit+0xd0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10265d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  102664:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102667:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10266a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  102671:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102674:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102677:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  10267e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  102681:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102684:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  10268b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  10268e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102691:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  102698:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10269b:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10269e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  1026a5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026a8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1026ab:	8b 50 30             	mov    0x30(%eax),%edx
  1026ae:	c1 ea 10             	shr    $0x10,%edx
  1026b1:	80 fa 03             	cmp    $0x3,%dl
  1026b4:	77 72                	ja     102728 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026b6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  1026bd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026c0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026c3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026cd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026d0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026d7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026da:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026dd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026e7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026ea:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1026f1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026f4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026f7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  1026fe:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  102701:	8b 50 20             	mov    0x20(%eax),%edx
  102704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  102708:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
  10270e:	80 e6 10             	and    $0x10,%dh
  102711:	75 f5                	jne    102708 <lapicinit+0xb8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102713:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  10271a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10271d:	8b 40 20             	mov    0x20(%eax),%eax
  102720:	f3 c3                	repz ret 
  102722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102728:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  10272f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102732:	8b 50 20             	mov    0x20(%eax),%edx
  102735:	e9 7c ff ff ff       	jmp    1026b6 <lapicinit+0x66>
  10273a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102740 <cpu>:
  lapicw(TPR, 0);
}

int
cpu(void)
{
  102740:	83 ec 0c             	sub    $0xc,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  102743:	9c                   	pushf  
  102744:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
  102745:	f6 c4 02             	test   $0x2,%ah
  102748:	74 12                	je     10275c <cpu+0x1c>
    static int n;
    if(n++ == 0)
  10274a:	a1 78 98 10 00       	mov    0x109878,%eax
  10274f:	8d 50 01             	lea    0x1(%eax),%edx
  102752:	85 c0                	test   %eax,%eax
  102754:	89 15 78 98 10 00    	mov    %edx,0x109878
  10275a:	74 14                	je     102770 <cpu+0x30>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
  10275c:	a1 d8 ca 10 00       	mov    0x10cad8,%eax
  102761:	85 c0                	test   %eax,%eax
  102763:	74 28                	je     10278d <cpu+0x4d>
    return lapic[ID]>>24;
  102765:	8b 40 20             	mov    0x20(%eax),%eax
  return 0;
}
  102768:	83 c4 0c             	add    $0xc,%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if(lapic)
    return lapic[ID]>>24;
  10276b:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  10276e:	c3                   	ret    
  10276f:	90                   	nop
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  102770:	83 ec 08             	sub    $0x8,%esp
  102773:	ff 74 24 14          	pushl  0x14(%esp)
  102777:	68 e0 63 10 00       	push   $0x1063e0
  10277c:	e8 1f df ff ff       	call   1006a0 <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
  102781:	a1 d8 ca 10 00       	mov    0x10cad8,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  102786:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
  102789:	85 c0                	test   %eax,%eax
  10278b:	75 d8                	jne    102765 <cpu+0x25>
    return lapic[ID]>>24;
  return 0;
  10278d:	31 c0                	xor    %eax,%eax
}
  10278f:	83 c4 0c             	add    $0xc,%esp
  102792:	c3                   	ret    
  102793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001027a0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
  1027a0:	a1 d8 ca 10 00       	mov    0x10cad8,%eax
  1027a5:	85 c0                	test   %eax,%eax
  1027a7:	74 0d                	je     1027b6 <lapiceoi+0x16>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027a9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1027b0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1027b3:	8b 40 20             	mov    0x20(%eax),%eax
  1027b6:	f3 c3                	repz ret 
  1027b8:	90                   	nop
  1027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001027c0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  1027c0:	83 ec 10             	sub    $0x10,%esp
  1027c3:	8b 54 24 14          	mov    0x14(%esp),%edx
  volatile int j = 0;
  1027c7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1027ce:	00 
  
  while(us-- > 0)
  1027cf:	85 d2                	test   %edx,%edx
  1027d1:	7e 3a                	jle    10280d <microdelay+0x4d>
  1027d3:	90                   	nop
  1027d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j=0; j<10000; j++);
  1027d8:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1027df:	00 
  1027e0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1027e4:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1027e9:	7f 1b                	jg     102806 <microdelay+0x46>
  1027eb:	90                   	nop
  1027ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1027f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1027f4:	83 c0 01             	add    $0x1,%eax
  1027f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1027fb:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1027ff:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102804:	7e ea                	jle    1027f0 <microdelay+0x30>
  102806:	83 ea 01             	sub    $0x1,%edx
void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  102809:	85 d2                	test   %edx,%edx
  10280b:	7f cb                	jg     1027d8 <microdelay+0x18>
    for(j=0; j<10000; j++);
}
  10280d:	83 c4 10             	add    $0x10,%esp
  102810:	c3                   	ret    
  102811:	eb 0d                	jmp    102820 <lapicstartap>
  102813:	90                   	nop
  102814:	90                   	nop
  102815:	90                   	nop
  102816:	90                   	nop
  102817:	90                   	nop
  102818:	90                   	nop
  102819:	90                   	nop
  10281a:	90                   	nop
  10281b:	90                   	nop
  10281c:	90                   	nop
  10281d:	90                   	nop
  10281e:	90                   	nop
  10281f:	90                   	nop

00102820 <lapicstartap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
  102820:	57                   	push   %edi
  102821:	56                   	push   %esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102822:	ba 70 00 00 00       	mov    $0x70,%edx
  102827:	53                   	push   %ebx
  102828:	b8 0f 00 00 00       	mov    $0xf,%eax
  10282d:	83 ec 10             	sub    $0x10,%esp
  102830:	8b 74 24 20          	mov    0x20(%esp),%esi
  102834:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  102838:	ee                   	out    %al,(%dx)
  102839:	ba 71 00 00 00       	mov    $0x71,%edx
  10283e:	b8 0a 00 00 00       	mov    $0xa,%eax
  102843:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  102844:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102846:	c1 e6 18             	shl    $0x18,%esi
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  102849:	ba c8 00 00 00       	mov    $0xc8,%edx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  10284e:	66 a3 67 04 00 00    	mov    %ax,0x467
  wrv[1] = addr >> 4;
  102854:	89 d8                	mov    %ebx,%eax
  102856:	c1 e8 04             	shr    $0x4,%eax
  102859:	66 a3 69 04 00 00    	mov    %ax,0x469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10285f:	8b 0d d8 ca 10 00    	mov    0x10cad8,%ecx
  102865:	89 b1 10 03 00 00    	mov    %esi,0x310(%ecx)
  lapic[ID];  // wait for write to finish, by reading
  10286b:	8b 41 20             	mov    0x20(%ecx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10286e:	c7 81 00 03 00 00 00 	movl   $0xc500,0x300(%ecx)
  102875:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102878:	8b 41 20             	mov    0x20(%ecx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  10287b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  102882:	00 
  102883:	90                   	nop
  102884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  while(us-- > 0)
    for(j=0; j<10000; j++);
  102888:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10288f:	00 
  102890:	8b 44 24 08          	mov    0x8(%esp),%eax
  102894:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102899:	7f 1b                	jg     1028b6 <lapicstartap+0x96>
  10289b:	90                   	nop
  10289c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1028a0:	8b 44 24 08          	mov    0x8(%esp),%eax
  1028a4:	83 c0 01             	add    $0x1,%eax
  1028a7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1028ab:	8b 44 24 08          	mov    0x8(%esp),%eax
  1028af:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1028b4:	7e ea                	jle    1028a0 <lapicstartap+0x80>
void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  1028b6:	83 ea 01             	sub    $0x1,%edx
  1028b9:	75 cd                	jne    102888 <lapicstartap+0x68>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1028bb:	c7 81 00 03 00 00 00 	movl   $0x8500,0x300(%ecx)
  1028c2:	85 00 00 
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  1028c5:	ba 64 00 00 00       	mov    $0x64,%edx

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  1028ca:	8b 41 20             	mov    0x20(%ecx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  1028cd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1028d4:	00 
  1028d5:	8d 76 00             	lea    0x0(%esi),%esi
  
  while(us-- > 0)
    for(j=0; j<10000; j++);
  1028d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1028df:	00 
  1028e0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1028e4:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  1028e9:	7f 1b                	jg     102906 <lapicstartap+0xe6>
  1028eb:	90                   	nop
  1028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1028f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1028f4:	83 c0 01             	add    $0x1,%eax
  1028f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1028fb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1028ff:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102904:	7e ea                	jle    1028f0 <lapicstartap+0xd0>
void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  102906:	83 ea 01             	sub    $0x1,%edx
  102909:	75 cd                	jne    1028d8 <lapicstartap+0xb8>
  10290b:	c1 eb 0c             	shr    $0xc,%ebx
  10290e:	bf 02 00 00 00       	mov    $0x2,%edi
  102913:	80 cf 06             	or     $0x6,%bh
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102916:	89 b1 10 03 00 00    	mov    %esi,0x310(%ecx)
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  10291c:	ba c8 00 00 00       	mov    $0xc8,%edx

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  lapic[ID];  // wait for write to finish, by reading
  102921:	8b 41 20             	mov    0x20(%ecx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102924:	89 99 00 03 00 00    	mov    %ebx,0x300(%ecx)
  lapic[ID];  // wait for write to finish, by reading
  10292a:	8b 41 20             	mov    0x20(%ecx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
  volatile int j = 0;
  10292d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  102934:	00 
  102935:	8d 76 00             	lea    0x0(%esi),%esi
  
  while(us-- > 0)
    for(j=0; j<10000; j++);
  102938:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10293f:	00 
  102940:	8b 44 24 0c          	mov    0xc(%esp),%eax
  102944:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102949:	7f 1b                	jg     102966 <lapicstartap+0x146>
  10294b:	90                   	nop
  10294c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102950:	8b 44 24 0c          	mov    0xc(%esp),%eax
  102954:	83 c0 01             	add    $0x1,%eax
  102957:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10295b:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10295f:	3d 0f 27 00 00       	cmp    $0x270f,%eax
  102964:	7e ea                	jle    102950 <lapicstartap+0x130>
void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  102966:	83 ea 01             	sub    $0x1,%edx
  102969:	75 cd                	jne    102938 <lapicstartap+0x118>
  // Send startup IPI (twice!) to enter bootstrap code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  10296b:	83 ef 01             	sub    $0x1,%edi
  10296e:	75 a6                	jne    102916 <lapicstartap+0xf6>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  102970:	83 c4 10             	add    $0x10,%esp
  102973:	5b                   	pop    %ebx
  102974:	5e                   	pop    %esi
  102975:	5f                   	pop    %edi
  102976:	c3                   	ret    
  102977:	66 90                	xchg   %ax,%ax
  102979:	66 90                	xchg   %ax,%ax
  10297b:	66 90                	xchg   %ax,%ax
  10297d:	66 90                	xchg   %ax,%ax
  10297f:	90                   	nop

00102980 <mpmain>:

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  102980:	53                   	push   %ebx
  102981:	83 ec 08             	sub    $0x8,%esp
  if(cpu() != mpbcpu())
  102984:	e8 b7 fd ff ff       	call   102740 <cpu>
  102989:	89 c3                	mov    %eax,%ebx
  10298b:	e8 c0 00 00 00       	call   102a50 <mpbcpu>
  102990:	39 c3                	cmp    %eax,%ebx
  102992:	74 11                	je     1029a5 <mpmain+0x25>
    lapicinit(cpu());
  102994:	e8 a7 fd ff ff       	call   102740 <cpu>
  102999:	83 ec 0c             	sub    $0xc,%esp
  10299c:	50                   	push   %eax
  10299d:	e8 ae fc ff ff       	call   102650 <lapicinit>
  1029a2:	83 c4 10             	add    $0x10,%esp
  ksegment();
  1029a5:	e8 96 08 00 00       	call   103240 <ksegment>
  cprintf("cpu%d: mpmain\n", cpu());
  1029aa:	e8 91 fd ff ff       	call   102740 <cpu>
  1029af:	83 ec 08             	sub    $0x8,%esp
  1029b2:	50                   	push   %eax
  1029b3:	68 0c 64 10 00       	push   $0x10640c
  1029b8:	e8 e3 dc ff ff       	call   1006a0 <cprintf>
  idtinit();
  1029bd:	e8 9e 27 00 00       	call   105160 <idtinit>
  xchg(&c->booted, 1);
  1029c2:	65 8b 15 fc ff ff ff 	mov    %gs:0xfffffffc,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  1029c9:	b8 01 00 00 00       	mov    $0x1,%eax
  1029ce:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)

  cprintf("cpu%d: scheduling\n", cpu());
  1029d5:	e8 66 fd ff ff       	call   102740 <cpu>
  1029da:	5a                   	pop    %edx
  1029db:	59                   	pop    %ecx
  1029dc:	50                   	push   %eax
  1029dd:	68 1b 64 10 00       	push   $0x10641b
  1029e2:	e8 b9 dc ff ff       	call   1006a0 <cprintf>
  scheduler();
  1029e7:	e8 34 0d 00 00       	call   103720 <scheduler>
  1029ec:	66 90                	xchg   %ax,%ax
  1029ee:	66 90                	xchg   %ax,%ax

001029f0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uchar *addr, int len)
{
  1029f0:	57                   	push   %edi
  1029f1:	56                   	push   %esi
  1029f2:	89 c6                	mov    %eax,%esi
  1029f4:	53                   	push   %ebx
  uchar *e, *p;

  e = addr+len;
  1029f5:	8d 1c 10             	lea    (%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
  1029f8:	39 d8                	cmp    %ebx,%eax
  1029fa:	73 42                	jae    102a3e <mpsearch1+0x4e>
  1029fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102a00:	83 ec 04             	sub    $0x4,%esp
  102a03:	8d 7e 10             	lea    0x10(%esi),%edi
  102a06:	6a 04                	push   $0x4
  102a08:	68 45 64 10 00       	push   $0x106445
  102a0d:	56                   	push   %esi
  102a0e:	e8 7d 15 00 00       	call   103f90 <memcmp>
  102a13:	83 c4 10             	add    $0x10,%esp
  102a16:	85 c0                	test   %eax,%eax
  102a18:	75 1e                	jne    102a38 <mpsearch1+0x48>
  102a1a:	8d 7e 10             	lea    0x10(%esi),%edi
  102a1d:	89 f2                	mov    %esi,%edx
  102a1f:	31 c9                	xor    %ecx,%ecx
  102a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  102a28:	0f b6 02             	movzbl (%edx),%eax
  102a2b:	83 c2 01             	add    $0x1,%edx
  102a2e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102a30:	39 fa                	cmp    %edi,%edx
  102a32:	75 f4                	jne    102a28 <mpsearch1+0x38>
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102a34:	84 c9                	test   %cl,%cl
  102a36:	74 0c                	je     102a44 <mpsearch1+0x54>
mpsearch1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102a38:	39 fb                	cmp    %edi,%ebx
  102a3a:	89 fe                	mov    %edi,%esi
  102a3c:	77 c2                	ja     102a00 <mpsearch1+0x10>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102a3e:	5b                   	pop    %ebx

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
  102a3f:	31 c0                	xor    %eax,%eax
}
  102a41:	5e                   	pop    %esi
  102a42:	5f                   	pop    %edi
  102a43:	c3                   	ret    
  102a44:	89 f0                	mov    %esi,%eax
  102a46:	5b                   	pop    %ebx
  102a47:	5e                   	pop    %esi
  102a48:	5f                   	pop    %edi
  102a49:	c3                   	ret    
  102a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102a50 <mpbcpu>:
uchar ioapicid;

int
mpbcpu(void)
{
  return bcpu-cpus;
  102a50:	a1 7c 98 10 00       	mov    0x10987c,%eax
  102a55:	2d 00 cb 10 00       	sub    $0x10cb00,%eax
  102a5a:	c1 f8 02             	sar    $0x2,%eax
  102a5d:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
  102a63:	c3                   	ret    
  102a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00102a70 <mpinit>:
  return conf;
}

void
mpinit(void)
{
  102a70:	55                   	push   %ebp
  102a71:	57                   	push   %edi
  102a72:	56                   	push   %esi
  102a73:	53                   	push   %ebx
  102a74:	83 ec 1c             	sub    $0x1c,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  102a77:	69 05 e0 d0 10 00 bc 	imul   $0xbc,0x10d0e0,%eax
  102a7e:	00 00 00 
  102a81:	05 00 cb 10 00       	add    $0x10cb00,%eax
  102a86:	a3 7c 98 10 00       	mov    %eax,0x10987c
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102a8b:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102a92:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102a99:	c1 e0 08             	shl    $0x8,%eax
  102a9c:	09 d0                	or     %edx,%eax
  102a9e:	c1 e0 04             	shl    $0x4,%eax
  102aa1:	85 c0                	test   %eax,%eax
  102aa3:	75 1b                	jne    102ac0 <mpinit+0x50>
    if((mp = mpsearch1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
  102aa5:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102aac:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102ab3:	c1 e0 08             	shl    $0x8,%eax
  102ab6:	09 d0                	or     %edx,%eax
  102ab8:	c1 e0 0a             	shl    $0xa,%eax
  102abb:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
    if((mp = mpsearch1((uchar*)p, 1024)))
  102ac0:	ba 00 04 00 00       	mov    $0x400,%edx
  102ac5:	e8 26 ff ff ff       	call   1029f0 <mpsearch1>
  102aca:	85 c0                	test   %eax,%eax
  102acc:	89 c7                	mov    %eax,%edi
  102ace:	0f 84 6c 01 00 00    	je     102c40 <mpinit+0x1d0>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102ad4:	8b 77 04             	mov    0x4(%edi),%esi
  102ad7:	85 f6                	test   %esi,%esi
  102ad9:	0f 84 c0 00 00 00    	je     102b9f <mpinit+0x12f>
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  102adf:	83 ec 04             	sub    $0x4,%esp
  102ae2:	6a 04                	push   $0x4
  102ae4:	68 4a 64 10 00       	push   $0x10644a
  102ae9:	56                   	push   %esi
  102aea:	e8 a1 14 00 00       	call   103f90 <memcmp>
  102aef:	83 c4 10             	add    $0x10,%esp
  102af2:	85 c0                	test   %eax,%eax
  102af4:	0f 85 a5 00 00 00    	jne    102b9f <mpinit+0x12f>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102afa:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  102afe:	3c 01                	cmp    $0x1,%al
  102b00:	0f 95 c1             	setne  %cl
  102b03:	3c 04                	cmp    $0x4,%al
  102b05:	0f 95 c0             	setne  %al
  102b08:	20 c1                	and    %al,%cl
  102b0a:	0f 85 8f 00 00 00    	jne    102b9f <mpinit+0x12f>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102b10:	0f b7 46 04          	movzwl 0x4(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102b14:	85 c0                	test   %eax,%eax
  102b16:	74 19                	je     102b31 <mpinit+0xc1>
  102b18:	31 db                	xor    %ebx,%ebx
  102b1a:	31 d2                	xor    %edx,%edx
  102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
  102b20:	0f b6 2c 16          	movzbl (%esi,%edx,1),%ebp
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102b24:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
  102b27:	01 eb                	add    %ebp,%ebx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102b29:	39 d0                	cmp    %edx,%eax
  102b2b:	75 f3                	jne    102b20 <mpinit+0xb0>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102b2d:	84 db                	test   %bl,%bl
  102b2f:	75 6e                	jne    102b9f <mpinit+0x12f>
  bcpu = &cpus[ncpu];
  if((conf = mpconfig(&mp)) == 0)
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102b31:	8b 56 24             	mov    0x24(%esi),%edx

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102b34:	01 f0                	add    %esi,%eax

  bcpu = &cpus[ncpu];
  if((conf = mpconfig(&mp)) == 0)
    return;

  ismp = 1;
  102b36:	c7 05 e4 ca 10 00 01 	movl   $0x1,0x10cae4
  102b3d:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102b40:	89 15 d8 ca 10 00    	mov    %edx,0x10cad8

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102b46:	8d 56 2c             	lea    0x2c(%esi),%edx
  102b49:	39 c2                	cmp    %eax,%edx
  102b4b:	73 37                	jae    102b84 <mpinit+0x114>
  102b4d:	8b 2d 7c 98 10 00    	mov    0x10987c,%ebp
  102b53:	88 4c 24 0f          	mov    %cl,0xf(%esp)
    switch(*p){
  102b57:	0f b6 1a             	movzbl (%edx),%ebx
  102b5a:	80 fb 04             	cmp    $0x4,%bl
  102b5d:	0f 87 b5 00 00 00    	ja     102c18 <mpinit+0x1a8>
  102b63:	ff 24 9d 78 64 10 00 	jmp    *0x106478(,%ebx,4)
  102b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102b70:	83 c2 08             	add    $0x8,%edx
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102b73:	39 d0                	cmp    %edx,%eax
  102b75:	77 e0                	ja     102b57 <mpinit+0xe7>
  102b77:	0f b6 4c 24 0f       	movzbl 0xf(%esp),%ecx
  102b7c:	84 c9                	test   %cl,%cl
  102b7e:	0f 85 da 00 00 00    	jne    102c5e <mpinit+0x1ee>
      cprintf("mpinit: unknown config type %x\n", *p);
      panic("mpinit");
    }
  }

  if(mp->imcrp){
  102b84:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  102b88:	74 15                	je     102b9f <mpinit+0x12f>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102b8a:	ba 22 00 00 00       	mov    $0x22,%edx
  102b8f:	b8 70 00 00 00       	mov    $0x70,%eax
  102b94:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102b95:	ba 23 00 00 00       	mov    $0x23,%edx
  102b9a:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102b9b:	83 c8 01             	or     $0x1,%eax
  102b9e:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102b9f:	83 c4 1c             	add    $0x1c,%esp
  102ba2:	5b                   	pop    %ebx
  102ba3:	5e                   	pop    %esi
  102ba4:	5f                   	pop    %edi
  102ba5:	5d                   	pop    %ebp
  102ba6:	c3                   	ret    
  102ba7:	89 f6                	mov    %esi,%esi
  102ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
  102bb0:	69 1d e0 d0 10 00 bc 	imul   $0xbc,0x10d0e0,%ebx
  102bb7:	00 00 00 
  102bba:	0f b6 4a 01          	movzbl 0x1(%edx),%ecx
  102bbe:	8d b3 00 cb 10 00    	lea    0x10cb00(%ebx),%esi
  102bc4:	88 8b 00 cb 10 00    	mov    %cl,0x10cb00(%ebx)
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
  102bca:	0f b6 5a 03          	movzbl 0x3(%edx),%ebx
  102bce:	b9 01 00 00 00       	mov    $0x1,%ecx
  102bd3:	83 e3 02             	and    $0x2,%ebx
  102bd6:	0f 45 ee             	cmovne %esi,%ebp
  102bd9:	0f b6 74 24 0f       	movzbl 0xf(%esp),%esi
  102bde:	0f 45 f1             	cmovne %ecx,%esi
      ncpu++;
      p += sizeof(struct mpproc);
  102be1:	83 c2 14             	add    $0x14,%edx
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
  102be4:	89 f1                	mov    %esi,%ecx
  102be6:	88 4c 24 0f          	mov    %cl,0xf(%esp)
      ncpu++;
  102bea:	8b 0d e0 d0 10 00    	mov    0x10d0e0,%ecx
  102bf0:	8d 59 01             	lea    0x1(%ecx),%ebx
  102bf3:	89 1d e0 d0 10 00    	mov    %ebx,0x10d0e0
      p += sizeof(struct mpproc);
      continue;
  102bf9:	e9 75 ff ff ff       	jmp    102b73 <mpinit+0x103>
  102bfe:	66 90                	xchg   %ax,%ax
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102c00:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
      p += sizeof(struct mpioapic);
  102c04:	83 c2 08             	add    $0x8,%edx
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
  102c07:	88 1d e0 ca 10 00    	mov    %bl,0x10cae0
      p += sizeof(struct mpioapic);
      continue;
  102c0d:	e9 61 ff ff ff       	jmp    102b73 <mpinit+0x103>
  102c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102c18:	0f b6 4c 24 0f       	movzbl 0xf(%esp),%ecx
  102c1d:	84 c9                	test   %cl,%cl
  102c1f:	75 48                	jne    102c69 <mpinit+0x1f9>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
  102c21:	83 ec 08             	sub    $0x8,%esp
  102c24:	53                   	push   %ebx
  102c25:	68 58 64 10 00       	push   $0x106458
  102c2a:	e8 71 da ff ff       	call   1006a0 <cprintf>
      panic("mpinit");
  102c2f:	c7 04 24 4f 64 10 00 	movl   $0x10644f,(%esp)
  102c36:	e8 e5 dd ff ff       	call   100a20 <panic>
  102c3b:	90                   	nop
  102c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102c40:	ba 00 00 01 00       	mov    $0x10000,%edx
  102c45:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102c4a:	e8 a1 fd ff ff       	call   1029f0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102c4f:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mpsearch1((uchar*)0xF0000, 0x10000);
  102c51:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
  102c53:	0f 85 7b fe ff ff    	jne    102ad4 <mpinit+0x64>
  102c59:	e9 41 ff ff ff       	jmp    102b9f <mpinit+0x12f>
  102c5e:	89 2d 7c 98 10 00    	mov    %ebp,0x10987c
  102c64:	e9 1b ff ff ff       	jmp    102b84 <mpinit+0x114>
  102c69:	89 2d 7c 98 10 00    	mov    %ebp,0x10987c
  102c6f:	eb b0                	jmp    102c21 <mpinit+0x1b1>
  102c71:	66 90                	xchg   %ax,%ax
  102c73:	66 90                	xchg   %ax,%ax
  102c75:	66 90                	xchg   %ax,%ax
  102c77:	66 90                	xchg   %ax,%ax
  102c79:	66 90                	xchg   %ax,%ax
  102c7b:	66 90                	xchg   %ax,%ax
  102c7d:	66 90                	xchg   %ax,%ax
  102c7f:	90                   	nop

00102c80 <picenable>:
}

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
  102c80:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  102c84:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  102c89:	ba 21 00 00 00       	mov    $0x21,%edx
  102c8e:	d3 c0                	rol    %cl,%eax
  102c90:	66 23 05 20 93 10 00 	and    0x109320,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
  102c97:	66 a3 20 93 10 00    	mov    %ax,0x109320
  102c9d:	ee                   	out    %al,(%dx)
  102c9e:	ba a1 00 00 00       	mov    $0xa1,%edx
  102ca3:	66 c1 e8 08          	shr    $0x8,%ax
  102ca7:	ee                   	out    %al,(%dx)
  102ca8:	c3                   	ret    
  102ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102cb0 <picinit>:
}

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
  102cb0:	55                   	push   %ebp
  102cb1:	57                   	push   %edi
  102cb2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102cb7:	56                   	push   %esi
  102cb8:	53                   	push   %ebx
  102cb9:	bb 21 00 00 00       	mov    $0x21,%ebx
  102cbe:	89 da                	mov    %ebx,%edx
  102cc0:	ee                   	out    %al,(%dx)
  102cc1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  102cc6:	89 ca                	mov    %ecx,%edx
  102cc8:	ee                   	out    %al,(%dx)
  102cc9:	bd 11 00 00 00       	mov    $0x11,%ebp
  102cce:	be 20 00 00 00       	mov    $0x20,%esi
  102cd3:	89 e8                	mov    %ebp,%eax
  102cd5:	89 f2                	mov    %esi,%edx
  102cd7:	ee                   	out    %al,(%dx)
  102cd8:	b8 20 00 00 00       	mov    $0x20,%eax
  102cdd:	89 da                	mov    %ebx,%edx
  102cdf:	ee                   	out    %al,(%dx)
  102ce0:	b8 04 00 00 00       	mov    $0x4,%eax
  102ce5:	ee                   	out    %al,(%dx)
  102ce6:	bf 03 00 00 00       	mov    $0x3,%edi
  102ceb:	89 f8                	mov    %edi,%eax
  102ced:	ee                   	out    %al,(%dx)
  102cee:	bb a0 00 00 00       	mov    $0xa0,%ebx
  102cf3:	89 e8                	mov    %ebp,%eax
  102cf5:	89 da                	mov    %ebx,%edx
  102cf7:	ee                   	out    %al,(%dx)
  102cf8:	b8 28 00 00 00       	mov    $0x28,%eax
  102cfd:	89 ca                	mov    %ecx,%edx
  102cff:	ee                   	out    %al,(%dx)
  102d00:	b8 02 00 00 00       	mov    $0x2,%eax
  102d05:	ee                   	out    %al,(%dx)
  102d06:	89 f8                	mov    %edi,%eax
  102d08:	ee                   	out    %al,(%dx)
  102d09:	bf 68 00 00 00       	mov    $0x68,%edi
  102d0e:	89 f2                	mov    %esi,%edx
  102d10:	89 f8                	mov    %edi,%eax
  102d12:	ee                   	out    %al,(%dx)
  102d13:	b9 0a 00 00 00       	mov    $0xa,%ecx
  102d18:	89 c8                	mov    %ecx,%eax
  102d1a:	ee                   	out    %al,(%dx)
  102d1b:	89 f8                	mov    %edi,%eax
  102d1d:	89 da                	mov    %ebx,%edx
  102d1f:	ee                   	out    %al,(%dx)
  102d20:	89 c8                	mov    %ecx,%eax
  102d22:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102d23:	0f b7 05 20 93 10 00 	movzwl 0x109320,%eax
  102d2a:	66 83 f8 ff          	cmp    $0xffff,%ax
  102d2e:	74 10                	je     102d40 <picinit+0x90>
  102d30:	ba 21 00 00 00       	mov    $0x21,%edx
  102d35:	ee                   	out    %al,(%dx)
  102d36:	ba a1 00 00 00       	mov    $0xa1,%edx
  102d3b:	66 c1 e8 08          	shr    $0x8,%ax
  102d3f:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
  102d40:	5b                   	pop    %ebx
  102d41:	5e                   	pop    %esi
  102d42:	5f                   	pop    %edi
  102d43:	5d                   	pop    %ebp
  102d44:	c3                   	ret    
  102d45:	66 90                	xchg   %ax,%ax
  102d47:	66 90                	xchg   %ax,%ax
  102d49:	66 90                	xchg   %ax,%ax
  102d4b:	66 90                	xchg   %ax,%ax
  102d4d:	66 90                	xchg   %ax,%ax
  102d4f:	90                   	nop

00102d50 <pipealloc>:
  char data[PIPESIZE];
};

int
pipealloc(struct file **f0, struct file **f1)
{
  102d50:	57                   	push   %edi
  102d51:	56                   	push   %esi
  102d52:	53                   	push   %ebx
  102d53:	8b 74 24 10          	mov    0x10(%esp),%esi
  102d57:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  102d5b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  102d61:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  102d67:	e8 24 e1 ff ff       	call   100e90 <filealloc>
  102d6c:	85 c0                	test   %eax,%eax
  102d6e:	89 06                	mov    %eax,(%esi)
  102d70:	0f 84 9c 00 00 00    	je     102e12 <pipealloc+0xc2>
  102d76:	e8 15 e1 ff ff       	call   100e90 <filealloc>
  102d7b:	85 c0                	test   %eax,%eax
  102d7d:	89 03                	mov    %eax,(%ebx)
  102d7f:	74 7f                	je     102e00 <pipealloc+0xb0>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  102d81:	83 ec 0c             	sub    $0xc,%esp
  102d84:	68 00 10 00 00       	push   $0x1000
  102d89:	e8 02 f7 ff ff       	call   102490 <kalloc>
  102d8e:	83 c4 10             	add    $0x10,%esp
  102d91:	85 c0                	test   %eax,%eax
  102d93:	89 c7                	mov    %eax,%edi
  102d95:	0f 84 95 00 00 00    	je     102e30 <pipealloc+0xe0>
    goto bad;
  p->readopen = 1;
  102d9b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  p->writeopen = 1;
  102da1:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  102da8:	8d 40 10             	lea    0x10(%eax),%eax
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->writep = 0;
  102dab:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
  p->readp = 0;
  102db2:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  initlock(&p->lock, "pipe");
  102db9:	83 ec 08             	sub    $0x8,%esp
  102dbc:	68 8c 64 10 00       	push   $0x10648c
  102dc1:	50                   	push   %eax
  102dc2:	e8 59 0f 00 00       	call   103d20 <initlock>
  (*f0)->type = FD_PIPE;
  102dc7:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
  102dc9:	83 c4 10             	add    $0x10,%esp
  p->writeopen = 1;
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  102dcc:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->readopen = 1;
  p->writeopen = 1;
  p->writep = 0;
  p->readp = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  102dd0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  102dd6:	8b 06                	mov    (%esi),%eax
  102dd8:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  102ddc:	8b 06                	mov    (%esi),%eax
  102dde:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  102de1:	8b 03                	mov    (%ebx),%eax
  (*f1)->readable = 0;
  102de3:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  102de7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  102ded:	8b 03                	mov    (%ebx),%eax
  102def:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  102df3:	8b 03                	mov    (%ebx),%eax
  102df5:	89 78 0c             	mov    %edi,0xc(%eax)
  return 0;
  102df8:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
  102dfa:	5b                   	pop    %ebx
  102dfb:	5e                   	pop    %esi
  102dfc:	5f                   	pop    %edi
  102dfd:	c3                   	ret    
  102dfe:	66 90                	xchg   %ax,%ax

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0)
  102e00:	8b 06                	mov    (%esi),%eax
  102e02:	85 c0                	test   %eax,%eax
  102e04:	74 1e                	je     102e24 <pipealloc+0xd4>
    fileclose(*f0);
  102e06:	83 ec 0c             	sub    $0xc,%esp
  102e09:	50                   	push   %eax
  102e0a:	e8 41 e1 ff ff       	call   100f50 <fileclose>
  102e0f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
  102e12:	8b 03                	mov    (%ebx),%eax
  102e14:	85 c0                	test   %eax,%eax
  102e16:	74 0c                	je     102e24 <pipealloc+0xd4>
    fileclose(*f1);
  102e18:	83 ec 0c             	sub    $0xc,%esp
  102e1b:	50                   	push   %eax
  102e1c:	e8 2f e1 ff ff       	call   100f50 <fileclose>
  102e21:	83 c4 10             	add    $0x10,%esp
  return -1;
}
  102e24:	5b                   	pop    %ebx
    kfree((char*)p, PAGE);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
  102e25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  102e2a:	5e                   	pop    %esi
  102e2b:	5f                   	pop    %edi
  102e2c:	c3                   	ret    
  102e2d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0)
  102e30:	8b 06                	mov    (%esi),%eax
  102e32:	85 c0                	test   %eax,%eax
  102e34:	75 d0                	jne    102e06 <pipealloc+0xb6>
  102e36:	eb da                	jmp    102e12 <pipealloc+0xc2>
  102e38:	90                   	nop
  102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102e40 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  102e40:	57                   	push   %edi
  102e41:	56                   	push   %esi
  102e42:	53                   	push   %ebx
  102e43:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  102e47:	8b 7c 24 14          	mov    0x14(%esp),%edi
  acquire(&p->lock);
  102e4b:	83 ec 0c             	sub    $0xc,%esp
  102e4e:	8d 73 10             	lea    0x10(%ebx),%esi
  102e51:	56                   	push   %esi
  102e52:	e8 e9 0e 00 00       	call   103d40 <acquire>
  if(writable){
  102e57:	83 c4 10             	add    $0x10,%esp
  102e5a:	85 ff                	test   %edi,%edi
  102e5c:	74 32                	je     102e90 <pipeclose+0x50>
    p->writeopen = 0;
    wakeup(&p->readp);
  102e5e:	8d 43 0c             	lea    0xc(%ebx),%eax
  102e61:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  102e64:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    wakeup(&p->readp);
  102e6b:	50                   	push   %eax
  102e6c:	e8 df 0a 00 00       	call   103950 <wakeup>
  102e71:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
  102e74:	8b 13                	mov    (%ebx),%edx
  102e76:	85 d2                	test   %edx,%edx
  102e78:	75 07                	jne    102e81 <pipeclose+0x41>
  102e7a:	8b 43 04             	mov    0x4(%ebx),%eax
  102e7d:	85 c0                	test   %eax,%eax
  102e7f:	74 2f                	je     102eb0 <pipeclose+0x70>
    release(&p->lock);
    kfree((char*)p, PAGE);
  } else
    release(&p->lock);
  102e81:	89 74 24 10          	mov    %esi,0x10(%esp)
}
  102e85:	5b                   	pop    %ebx
  102e86:	5e                   	pop    %esi
  102e87:	5f                   	pop    %edi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p, PAGE);
  } else
    release(&p->lock);
  102e88:	e9 93 10 00 00       	jmp    103f20 <release>
  102e8d:	8d 76 00             	lea    0x0(%esi),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  102e90:	8d 43 08             	lea    0x8(%ebx),%eax
  102e93:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
  102e96:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    wakeup(&p->writep);
  102e9c:	50                   	push   %eax
  102e9d:	e8 ae 0a 00 00       	call   103950 <wakeup>
  102ea2:	83 c4 10             	add    $0x10,%esp
  102ea5:	eb cd                	jmp    102e74 <pipeclose+0x34>
  102ea7:	89 f6                	mov    %esi,%esi
  102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
  102eb0:	83 ec 0c             	sub    $0xc,%esp
  102eb3:	56                   	push   %esi
  102eb4:	e8 67 10 00 00       	call   103f20 <release>
    kfree((char*)p, PAGE);
  102eb9:	83 c4 10             	add    $0x10,%esp
  102ebc:	c7 44 24 14 00 10 00 	movl   $0x1000,0x14(%esp)
  102ec3:	00 
  102ec4:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  } else
    release(&p->lock);
}
  102ec8:	5b                   	pop    %ebx
  102ec9:	5e                   	pop    %esi
  102eca:	5f                   	pop    %edi
    p->readopen = 0;
    wakeup(&p->writep);
  }
  if(p->readopen == 0 && p->writeopen == 0) {
    release(&p->lock);
    kfree((char*)p, PAGE);
  102ecb:	e9 70 f4 ff ff       	jmp    102340 <kfree>

00102ed0 <pipewrite>:
}

//PAGEBREAK: 30
int
pipewrite(struct pipe *p, char *addr, int n)
{
  102ed0:	55                   	push   %ebp
  102ed1:	57                   	push   %edi
  102ed2:	56                   	push   %esi
  102ed3:	53                   	push   %ebx
  102ed4:	83 ec 28             	sub    $0x28,%esp
  102ed7:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
  int i;

  acquire(&p->lock);
  102edb:	8d 5f 10             	lea    0x10(%edi),%ebx
  102ede:	53                   	push   %ebx
  102edf:	e8 5c 0e 00 00       	call   103d40 <acquire>
  for(i = 0; i < n; i++){
  102ee4:	83 c4 10             	add    $0x10,%esp
  102ee7:	8b 44 24 38          	mov    0x38(%esp),%eax
  102eeb:	85 c0                	test   %eax,%eax
  102eed:	0f 8e 0c 01 00 00    	jle    102fff <pipewrite+0x12f>
  102ef3:	8d 47 08             	lea    0x8(%edi),%eax
  102ef6:	8b 4f 08             	mov    0x8(%edi),%ecx
  102ef9:	8d 6f 0c             	lea    0xc(%edi),%ebp
  102efc:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  102f03:	00 
  102f04:	89 44 24 04          	mov    %eax,0x4(%esp)
    while(p->writep == p->readp + PIPESIZE) {
  102f08:	8b 47 0c             	mov    0xc(%edi),%eax
  102f0b:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
  102f11:	39 d1                	cmp    %edx,%ecx
  102f13:	0f 85 e0 00 00 00    	jne    102ff9 <pipewrite+0x129>
      if(p->readopen == 0 || cp->killed){
  102f19:	8b 17                	mov    (%edi),%edx
  102f1b:	85 d2                	test   %edx,%edx
  102f1d:	0f 84 bd 00 00 00    	je     102fe0 <pipewrite+0x110>
  102f23:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  102f29:	65 8b 16             	mov    %gs:(%esi),%edx
  102f2c:	8b 42 24             	mov    0x24(%edx),%eax
  102f2f:	85 c0                	test   %eax,%eax
  102f31:	74 25                	je     102f58 <pipewrite+0x88>
  102f33:	e9 a8 00 00 00       	jmp    102fe0 <pipewrite+0x110>
  102f38:	90                   	nop
  102f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102f40:	8b 07                	mov    (%edi),%eax
  102f42:	85 c0                	test   %eax,%eax
  102f44:	0f 84 96 00 00 00    	je     102fe0 <pipewrite+0x110>
  102f4a:	65 8b 06             	mov    %gs:(%esi),%eax
  102f4d:	8b 40 24             	mov    0x24(%eax),%eax
  102f50:	85 c0                	test   %eax,%eax
  102f52:	0f 85 88 00 00 00    	jne    102fe0 <pipewrite+0x110>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102f58:	83 ec 0c             	sub    $0xc,%esp
  102f5b:	55                   	push   %ebp
  102f5c:	e8 ef 09 00 00       	call   103950 <wakeup>
      sleep(&p->writep, &p->lock);
  102f61:	59                   	pop    %ecx
  102f62:	58                   	pop    %eax
  102f63:	53                   	push   %ebx
  102f64:	ff 74 24 10          	pushl  0x10(%esp)
  102f68:	e8 33 09 00 00       	call   1038a0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
  102f6d:	8b 47 0c             	mov    0xc(%edi),%eax
  102f70:	8b 57 08             	mov    0x8(%edi),%edx
  102f73:	83 c4 10             	add    $0x10,%esp
  102f76:	05 00 02 00 00       	add    $0x200,%eax
  102f7b:	39 c2                	cmp    %eax,%edx
  102f7d:	74 c1                	je     102f40 <pipewrite+0x70>
  102f7f:	89 54 24 0c          	mov    %edx,0xc(%esp)
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep++ % PIPESIZE] = addr[i];
  102f83:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102f87:	8b 74 24 08          	mov    0x8(%esp),%esi
  102f8b:	8d 4a 01             	lea    0x1(%edx),%ecx
  102f8e:	8b 54 24 34          	mov    0x34(%esp),%edx
  102f92:	89 4f 08             	mov    %ecx,0x8(%edi)
  102f95:	0f b6 04 32          	movzbl (%edx,%esi,1),%eax
  102f99:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102f9d:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102fa3:	88 44 17 44          	mov    %al,0x44(%edi,%edx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fa7:	89 f0                	mov    %esi,%eax
  102fa9:	83 c0 01             	add    $0x1,%eax
  102fac:	39 44 24 38          	cmp    %eax,0x38(%esp)
  102fb0:	89 44 24 08          	mov    %eax,0x8(%esp)
  102fb4:	0f 85 4e ff ff ff    	jne    102f08 <pipewrite+0x38>
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->readp);
  102fba:	8d 47 0c             	lea    0xc(%edi),%eax
  102fbd:	83 ec 0c             	sub    $0xc,%esp
  102fc0:	50                   	push   %eax
  102fc1:	e8 8a 09 00 00       	call   103950 <wakeup>
  release(&p->lock);
  102fc6:	89 1c 24             	mov    %ebx,(%esp)
  102fc9:	e8 52 0f 00 00       	call   103f20 <release>
  return i;
  102fce:	83 c4 10             	add    $0x10,%esp
  102fd1:	8b 44 24 38          	mov    0x38(%esp),%eax
  102fd5:	eb 1a                	jmp    102ff1 <pipewrite+0x121>
  102fd7:	89 f6                	mov    %esi,%esi
  102fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
  102fe0:	83 ec 0c             	sub    $0xc,%esp
  102fe3:	53                   	push   %ebx
  102fe4:	e8 37 0f 00 00       	call   103f20 <release>
        return -1;
  102fe9:	83 c4 10             	add    $0x10,%esp
  102fec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->writep++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->readp);
  release(&p->lock);
  return i;
}
  102ff1:	83 c4 1c             	add    $0x1c,%esp
  102ff4:	5b                   	pop    %ebx
  102ff5:	5e                   	pop    %esi
  102ff6:	5f                   	pop    %edi
  102ff7:	5d                   	pop    %ebp
  102ff8:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->writep == p->readp + PIPESIZE) {
  102ff9:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  102ffd:	eb 84                	jmp    102f83 <pipewrite+0xb3>
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fff:	c7 44 24 38 00 00 00 	movl   $0x0,0x38(%esp)
  103006:	00 
  103007:	eb b1                	jmp    102fba <pipewrite+0xea>
  103009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103010 <piperead>:
  return i;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  103010:	55                   	push   %ebp
  103011:	57                   	push   %edi
  103012:	56                   	push   %esi
  103013:	53                   	push   %ebx
  103014:	83 ec 18             	sub    $0x18,%esp
  103017:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
  int i;

  acquire(&p->lock);
  10301b:	8d 5d 10             	lea    0x10(%ebp),%ebx
  10301e:	53                   	push   %ebx
  10301f:	e8 1c 0d 00 00       	call   103d40 <acquire>
  while(p->readp == p->writep && p->writeopen){
  103024:	83 c4 10             	add    $0x10,%esp
  103027:	8b 45 0c             	mov    0xc(%ebp),%eax
  10302a:	39 45 08             	cmp    %eax,0x8(%ebp)
  10302d:	75 57                	jne    103086 <piperead+0x76>
  10302f:	8b 45 04             	mov    0x4(%ebp),%eax
  103032:	85 c0                	test   %eax,%eax
  103034:	0f 84 ae 00 00 00    	je     1030e8 <piperead+0xd8>
    if(cp->killed){
  10303a:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  103040:	8d 7d 0c             	lea    0xc(%ebp),%edi
  103043:	65 8b 16             	mov    %gs:(%esi),%edx
  103046:	8b 42 24             	mov    0x24(%edx),%eax
  103049:	85 c0                	test   %eax,%eax
  10304b:	74 24                	je     103071 <piperead+0x61>
  10304d:	e9 a6 00 00 00       	jmp    1030f8 <piperead+0xe8>
  103052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  103058:	8b 55 04             	mov    0x4(%ebp),%edx
  10305b:	85 d2                	test   %edx,%edx
  10305d:	0f 84 85 00 00 00    	je     1030e8 <piperead+0xd8>
    if(cp->killed){
  103063:	65 8b 16             	mov    %gs:(%esi),%edx
  103066:	8b 4a 24             	mov    0x24(%edx),%ecx
  103069:	85 c9                	test   %ecx,%ecx
  10306b:	0f 85 87 00 00 00    	jne    1030f8 <piperead+0xe8>
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  103071:	83 ec 08             	sub    $0x8,%esp
  103074:	53                   	push   %ebx
  103075:	57                   	push   %edi
  103076:	e8 25 08 00 00       	call   1038a0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  10307b:	83 c4 10             	add    $0x10,%esp
  10307e:	8b 45 08             	mov    0x8(%ebp),%eax
  103081:	39 45 0c             	cmp    %eax,0xc(%ebp)
  103084:	74 d2                	je     103058 <piperead+0x48>
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103086:	8b 44 24 28          	mov    0x28(%esp),%eax
  10308a:	85 c0                	test   %eax,%eax
  10308c:	7e 5a                	jle    1030e8 <piperead+0xd8>
    if(p->readp == p->writep)
  10308e:	8b 55 0c             	mov    0xc(%ebp),%edx
  103091:	31 c9                	xor    %ecx,%ecx
  103093:	eb 0b                	jmp    1030a0 <piperead+0x90>
  103095:	8d 76 00             	lea    0x0(%esi),%esi
  103098:	8b 55 0c             	mov    0xc(%ebp),%edx
  10309b:	3b 55 08             	cmp    0x8(%ebp),%edx
  10309e:	74 78                	je     103118 <piperead+0x108>
      break;
    addr[i] = p->data[p->readp++ % PIPESIZE];
  1030a0:	8d 72 01             	lea    0x1(%edx),%esi
  1030a3:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  1030a9:	8b 44 24 24          	mov    0x24(%esp),%eax
  1030ad:	89 75 0c             	mov    %esi,0xc(%ebp)
  1030b0:	0f b6 54 15 44       	movzbl 0x44(%ebp,%edx,1),%edx
  1030b5:	88 14 08             	mov    %dl,(%eax,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  1030b8:	83 c1 01             	add    $0x1,%ecx
  1030bb:	39 4c 24 28          	cmp    %ecx,0x28(%esp)
  1030bf:	75 d7                	jne    103098 <piperead+0x88>
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp++ % PIPESIZE];
  }
  wakeup(&p->writep);
  1030c1:	8d 45 08             	lea    0x8(%ebp),%eax
  1030c4:	83 ec 0c             	sub    $0xc,%esp
  1030c7:	50                   	push   %eax
  1030c8:	e8 83 08 00 00       	call   103950 <wakeup>
  release(&p->lock);
  1030cd:	89 1c 24             	mov    %ebx,(%esp)
  1030d0:	e8 4b 0e 00 00       	call   103f20 <release>
  return i;
  1030d5:	83 c4 10             	add    $0x10,%esp
  1030d8:	8b 44 24 28          	mov    0x28(%esp),%eax
}
  1030dc:	83 c4 0c             	add    $0xc,%esp
  1030df:	5b                   	pop    %ebx
  1030e0:	5e                   	pop    %esi
  1030e1:	5f                   	pop    %edi
  1030e2:	5d                   	pop    %ebp
  1030e3:	c3                   	ret    
  1030e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  1030e8:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  1030ef:	00 
  1030f0:	eb cf                	jmp    1030c1 <piperead+0xb1>
  1030f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
    if(cp->killed){
      release(&p->lock);
  1030f8:	83 ec 0c             	sub    $0xc,%esp
  1030fb:	53                   	push   %ebx
  1030fc:	e8 1f 0e 00 00       	call   103f20 <release>
      return -1;
  103101:	83 c4 10             	add    $0x10,%esp
  103104:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->readp++ % PIPESIZE];
  }
  wakeup(&p->writep);
  release(&p->lock);
  return i;
}
  103109:	83 c4 0c             	add    $0xc,%esp
  10310c:	5b                   	pop    %ebx
  10310d:	5e                   	pop    %esi
  10310e:	5f                   	pop    %edi
  10310f:	5d                   	pop    %ebp
  103110:	c3                   	ret    
  103111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  103118:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  10311c:	eb a3                	jmp    1030c1 <piperead+0xb1>
  10311e:	66 90                	xchg   %ax,%ax

00103120 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103120:	53                   	push   %ebx
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103121:	bb 34 d1 10 00       	mov    $0x10d134,%ebx
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and return it.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  103126:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;

  acquire(&ptable.lock);
  103129:	68 00 d1 10 00       	push   $0x10d100
  10312e:	e8 0d 0c 00 00       	call   103d40 <acquire>
  103133:	83 c4 10             	add    $0x10,%esp
  103136:	eb 13                	jmp    10314b <allocproc+0x2b>
  103138:	90                   	nop
  103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103140:	83 c3 7c             	add    $0x7c,%ebx
  103143:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  103149:	74 75                	je     1031c0 <allocproc+0xa0>
    if(p->state == UNUSED){
  10314b:	8b 43 0c             	mov    0xc(%ebx),%eax
  10314e:	85 c0                	test   %eax,%eax
  103150:	75 ee                	jne    103140 <allocproc+0x20>
      p->state = EMBRYO;
      p->pid = nextpid++;
  103152:	a1 24 93 10 00       	mov    0x109324,%eax
  }
  release(&ptable.lock);
  return 0;

found:
  release(&ptable.lock);
  103157:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED){
      p->state = EMBRYO;
  10315a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  }
  release(&ptable.lock);
  return 0;

found:
  release(&ptable.lock);
  103161:	68 00 d1 10 00       	push   $0x10d100

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED){
      p->state = EMBRYO;
      p->pid = nextpid++;
  103166:	8d 50 01             	lea    0x1(%eax),%edx
  103169:	89 43 10             	mov    %eax,0x10(%ebx)
  10316c:	89 15 24 93 10 00    	mov    %edx,0x109324
  }
  release(&ptable.lock);
  return 0;

found:
  release(&ptable.lock);
  103172:	e8 a9 0d 00 00       	call   103f20 <release>

  // Allocate kernel stack if necessary.
  if((p->kstack = kalloc(KSTACKSIZE)) == 0){
  103177:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  10317e:	e8 0d f3 ff ff       	call   102490 <kalloc>
  103183:	83 c4 10             	add    $0x10,%esp
  103186:	85 c0                	test   %eax,%eax
  103188:	89 43 08             	mov    %eax,0x8(%ebx)
  10318b:	74 4a                	je     1031d7 <allocproc+0xb7>
  }
  p->tf = (struct trapframe*)(p->kstack + KSTACKSIZE) - 1;

  // Set up new context to start executing at forkret (see below).
  p->context = (struct context *)p->tf - 1;
  memset(p->context, 0, sizeof(*p->context));
  10318d:	83 ec 04             	sub    $0x4,%esp
  // Allocate kernel stack if necessary.
  if((p->kstack = kalloc(KSTACKSIZE)) == 0){
    p->state = UNUSED;
    return 0;
  }
  p->tf = (struct trapframe*)(p->kstack + KSTACKSIZE) - 1;
  103190:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx

  // Set up new context to start executing at forkret (see below).
  p->context = (struct context *)p->tf - 1;
  103196:	05 a0 0f 00 00       	add    $0xfa0,%eax
  memset(p->context, 0, sizeof(*p->context));
  10319b:	6a 14                	push   $0x14
  10319d:	6a 00                	push   $0x0
  10319f:	50                   	push   %eax
  // Allocate kernel stack if necessary.
  if((p->kstack = kalloc(KSTACKSIZE)) == 0){
    p->state = UNUSED;
    return 0;
  }
  p->tf = (struct trapframe*)(p->kstack + KSTACKSIZE) - 1;
  1031a0:	89 53 18             	mov    %edx,0x18(%ebx)

  // Set up new context to start executing at forkret (see below).
  p->context = (struct context *)p->tf - 1;
  1031a3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof(*p->context));
  1031a6:	e8 c5 0d 00 00       	call   103f70 <memset>
  p->context->eip = (uint)forkret;
  1031ab:	8b 43 1c             	mov    0x1c(%ebx),%eax
  return p;
  1031ae:	83 c4 10             	add    $0x10,%esp
  p->tf = (struct trapframe*)(p->kstack + KSTACKSIZE) - 1;

  // Set up new context to start executing at forkret (see below).
  p->context = (struct context *)p->tf - 1;
  memset(p->context, 0, sizeof(*p->context));
  p->context->eip = (uint)forkret;
  1031b1:	c7 40 10 f0 31 10 00 	movl   $0x1031f0,0x10(%eax)
  return p;
  1031b8:	89 d8                	mov    %ebx,%eax
}
  1031ba:	83 c4 08             	add    $0x8,%esp
  1031bd:	5b                   	pop    %ebx
  1031be:	c3                   	ret    
  1031bf:	90                   	nop
      p->state = EMBRYO;
      p->pid = nextpid++;
      goto found;
    }
  }
  release(&ptable.lock);
  1031c0:	83 ec 0c             	sub    $0xc,%esp
  1031c3:	68 00 d1 10 00       	push   $0x10d100
  1031c8:	e8 53 0d 00 00       	call   103f20 <release>
  return 0;
  1031cd:	83 c4 10             	add    $0x10,%esp
  1031d0:	31 c0                	xor    %eax,%eax
  // Set up new context to start executing at forkret (see below).
  p->context = (struct context *)p->tf - 1;
  memset(p->context, 0, sizeof(*p->context));
  p->context->eip = (uint)forkret;
  return p;
}
  1031d2:	83 c4 08             	add    $0x8,%esp
  1031d5:	5b                   	pop    %ebx
  1031d6:	c3                   	ret    
found:
  release(&ptable.lock);

  // Allocate kernel stack if necessary.
  if((p->kstack = kalloc(KSTACKSIZE)) == 0){
    p->state = UNUSED;
  1031d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
  1031de:	31 c0                	xor    %eax,%eax
  1031e0:	eb d8                	jmp    1031ba <allocproc+0x9a>
  1031e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1031e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001031f0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1031f0:	83 ec 18             	sub    $0x18,%esp
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
  1031f3:	68 00 d1 10 00       	push   $0x10d100
  1031f8:	e8 23 0d 00 00       	call   103f20 <release>

  // Jump into assembly, never to return.
  forkret1(cp->tf);
  1031fd:	58                   	pop    %eax
  1031fe:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  103203:	65 8b 00             	mov    %gs:(%eax),%eax
  103206:	ff 70 18             	pushl  0x18(%eax)
  103209:	e8 b7 1e 00 00       	call   1050c5 <forkret1>
}
  10320e:	83 c4 1c             	add    $0x1c,%esp
  103211:	c3                   	ret    
  103212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103220 <pinit>:
extern void forkret(void);
extern void forkret1(struct trapframe*);

void
pinit(void)
{
  103220:	83 ec 14             	sub    $0x14,%esp
  initlock(&ptable.lock, "ptable");
  103223:	68 91 64 10 00       	push   $0x106491
  103228:	68 00 d1 10 00       	push   $0x10d100
  10322d:	e8 ee 0a 00 00       	call   103d20 <initlock>
}
  103232:	83 c4 1c             	add    $0x1c,%esp
  103235:	c3                   	ret    
  103236:	8d 76 00             	lea    0x0(%esi),%esi
  103239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103240 <ksegment>:
}

// Set up CPU's kernel segment descriptors.
void
ksegment(void)
{
  103240:	53                   	push   %ebx
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103241:	31 db                	xor    %ebx,%ebx
}

// Set up CPU's kernel segment descriptors.
void
ksegment(void)
{
  103243:	83 ec 18             	sub    $0x18,%esp
  struct cpu *c1;

  c1 = &cpus[cpu()];
  103246:	e8 f5 f4 ff ff       	call   102740 <cpu>
  c1->gdt[0] = SEG_NULL;
  10324b:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103251:	b9 0f 01 00 00       	mov    $0x10f,%ecx
ksegment(void)
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  103256:	8d 90 00 cb 10 00    	lea    0x10cb00(%eax),%edx
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  10325c:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103260:	31 db                	xor    %ebx,%ebx
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103262:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103266:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  10326d:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  103272:	8d 98 b0 cb 10 00    	lea    0x10cbb0(%eax),%ebx
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103278:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  10327f:	8d 88 bc cb 10 00    	lea    0x10cbbc(%eax),%ecx
ksegment(void)
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  103285:	c7 42 70 00 00 00 00 	movl   $0x0,0x70(%edx)
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  10328c:	83 c3 0c             	add    $0xc,%ebx
ksegment(void)
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  10328f:	c7 42 74 00 00 00 00 	movl   $0x0,0x74(%edx)
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103296:	c6 80 7d cb 10 00 9a 	movb   $0x9a,0x10cb7d(%eax)
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  10329d:	66 89 9a 8a 00 00 00 	mov    %bx,0x8a(%edx)
  1032a4:	89 cb                	mov    %ecx,%ebx
  1032a6:	c1 e9 18             	shr    $0x18,%ecx
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1032a9:	c6 80 7e cb 10 00 c0 	movb   $0xc0,0x10cb7e(%eax)
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1032b0:	c6 80 85 cb 10 00 92 	movb   $0x92,0x10cb85(%eax)
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  1032b7:	c1 eb 10             	shr    $0x10,%ebx
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1032ba:	c6 80 86 cb 10 00 cf 	movb   $0xcf,0x10cb86(%eax)
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  1032c1:	c6 80 8d cb 10 00 92 	movb   $0x92,0x10cb8d(%eax)
  1032c8:	c6 80 8e cb 10 00 cf 	movb   $0xcf,0x10cb8e(%eax)
  1032cf:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
  c1->gdt[SEG_UCODE] = SEG_NULL;
  c1->gdt[SEG_UDATA] = SEG_NULL;
  c1->gdt[SEG_TSS] = SEG_NULL;
  lgdt(c1->gdt, sizeof(c1->gdt));
  1032d5:	05 70 cb 10 00       	add    $0x10cb70,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1032da:	b9 37 00 00 00       	mov    $0x37,%ecx
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  c1->gdt[0] = SEG_NULL;
  c1->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  1032df:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
  1032e3:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  1032e7:	66 89 4c 24 0a       	mov    %cx,0xa(%esp)
  pd[1] = (uint)p;
  1032ec:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  pd[2] = (uint)p >> 16;
  1032f1:	c1 e8 10             	shr    $0x10,%eax
  1032f4:	66 89 44 24 0e       	mov    %ax,0xe(%esp)
  c1->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  1032f9:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)

  asm volatile("lgdt (%0)" : : "r" (pd));
  103300:	8d 44 24 0a          	lea    0xa(%esp),%eax
  103304:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c1->gdt[SEG_KCPU] = SEG(STA_W, (uint)&c1->tls+sizeof(c1->tls), 0xffffffff, 0);
  10330b:	66 c7 82 88 00 00 00 	movw   $0xffff,0x88(%edx)
  103312:	ff ff 
  103314:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
  c1->gdt[SEG_UCODE] = SEG_NULL;
  10331a:	c7 82 90 00 00 00 00 	movl   $0x0,0x90(%edx)
  103321:	00 00 00 
  103324:	c7 82 94 00 00 00 00 	movl   $0x0,0x94(%edx)
  10332b:	00 00 00 
  c1->gdt[SEG_UDATA] = SEG_NULL;
  10332e:	c7 82 98 00 00 00 00 	movl   $0x0,0x98(%edx)
  103335:	00 00 00 
  103338:	c7 82 9c 00 00 00 00 	movl   $0x0,0x9c(%edx)
  10333f:	00 00 00 
  c1->gdt[SEG_TSS] = SEG_NULL;
  103342:	c7 82 a0 00 00 00 00 	movl   $0x0,0xa0(%edx)
  103349:	00 00 00 
  10334c:	c7 82 a4 00 00 00 00 	movl   $0x0,0xa4(%edx)
  103353:	00 00 00 
  103356:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadfsgs(ushort v)
{
  asm volatile("movw %0, %%fs" : : "r" (v));
  103359:	b8 18 00 00 00       	mov    $0x18,%eax
  10335e:	8e e0                	mov    %eax,%fs
  asm volatile("movw %0, %%gs" : : "r" (v));
  103360:	8e e8                	mov    %eax,%gs
  lgdt(c1->gdt, sizeof(c1->gdt));
  loadfsgs(SEG_KCPU << 3);
  
  // Initialize cpu-local variables.
  c = c1;
  103362:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
void
ksegment(void)
{
  struct cpu *c1;

  c1 = &cpus[cpu()];
  103367:	65 89 10             	mov    %edx,%gs:(%eax)
  lgdt(c1->gdt, sizeof(c1->gdt));
  loadfsgs(SEG_KCPU << 3);
  
  // Initialize cpu-local variables.
  c = c1;
  cp = 0;
  10336a:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  10336f:	65 c7 00 00 00 00 00 	movl   $0x0,%gs:(%eax)
}
  103376:	83 c4 18             	add    $0x18,%esp
  103379:	5b                   	pop    %ebx
  10337a:	c3                   	ret    
  10337b:	90                   	nop
  10337c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103380 <usegment>:

// Set up CPU's segment descriptors and task state for the current process.
// If cp==0, set up for "idle" state for when scheduler() is running.
void
usegment(void)
{
  103380:	55                   	push   %ebp
  103381:	57                   	push   %edi
  103382:	56                   	push   %esi
  103383:	53                   	push   %ebx
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  103384:	be 10 00 00 00       	mov    $0x10,%esi

// Set up CPU's segment descriptors and task state for the current process.
// If cp==0, set up for "idle" state for when scheduler() is running.
void
usegment(void)
{
  103389:	83 ec 2c             	sub    $0x2c,%esp
  pushcli();
  10338c:	e8 0f 0b 00 00       	call   103ea0 <pushcli>
  c->ts.ss0 = SEG_KDATA << 3;
  if(cp)
  103391:	c7 c2 f8 ff ff ff    	mov    $0xfffffff8,%edx
// If cp==0, set up for "idle" state for when scheduler() is running.
void
usegment(void)
{
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  103397:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  if(cp)
  10339c:	65 8b 0a             	mov    %gs:(%edx),%ecx
// If cp==0, set up for "idle" state for when scheduler() is running.
void
usegment(void)
{
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  10339f:	65 8b 00             	mov    %gs:(%eax),%eax
  if(cp)
  1033a2:	85 c9                	test   %ecx,%ecx
// If cp==0, set up for "idle" state for when scheduler() is running.
void
usegment(void)
{
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  1033a4:	66 89 70 10          	mov    %si,0x10(%eax)
  if(cp)
  1033a8:	0f 84 02 01 00 00    	je     1034b0 <usegment+0x130>
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  1033ae:	8b 59 08             	mov    0x8(%ecx),%ebx
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  1033b1:	8b 71 04             	mov    0x4(%ecx),%esi
  1033b4:	8b 09                	mov    (%ecx),%ecx
  1033b6:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
usegment(void)
{
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  if(cp)
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  1033bd:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  1033c3:	89 cf                	mov    %ecx,%edi
  1033c5:	89 cb                	mov    %ecx,%ebx
  1033c7:	66 89 88 92 00 00 00 	mov    %cx,0x92(%eax)
usegment(void)
{
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  if(cp)
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  1033ce:	89 50 0c             	mov    %edx,0xc(%eax)
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  1033d1:	8d 56 ff             	lea    -0x1(%esi),%edx
  1033d4:	c1 ef 10             	shr    $0x10,%edi
  1033d7:	c1 eb 18             	shr    $0x18,%ebx
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  1033da:	66 89 88 9a 00 00 00 	mov    %cx,0x9a(%eax)
  1033e1:	89 f9                	mov    %edi,%ecx
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  1033e3:	89 d6                	mov    %edx,%esi
  1033e5:	c1 ea 1c             	shr    $0x1c,%edx
  1033e8:	88 98 97 00 00 00    	mov    %bl,0x97(%eax)
  1033ee:	89 d5                	mov    %edx,%ebp
  1033f0:	89 fa                	mov    %edi,%edx
  1033f2:	c1 ee 0c             	shr    $0xc,%esi
  1033f5:	88 90 94 00 00 00    	mov    %dl,0x94(%eax)
  1033fb:	89 ea                	mov    %ebp,%edx
  1033fd:	83 cd c0             	or     $0xffffffc0,%ebp
  103400:	88 54 24 0f          	mov    %dl,0xf(%esp)
  103404:	89 ea                	mov    %ebp,%edx
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  103406:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  10340d:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  103413:	0f b6 54 24 0f       	movzbl 0xf(%esp),%edx
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
  103418:	66 89 b0 90 00 00 00 	mov    %si,0x90(%eax)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  10341f:	66 89 b0 98 00 00 00 	mov    %si,0x98(%eax)
  103426:	88 88 9c 00 00 00    	mov    %cl,0x9c(%eax)
  10342c:	88 98 9f 00 00 00    	mov    %bl,0x9f(%eax)
  103432:	83 ca c0             	or     $0xffffffc0,%edx
  103435:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  10343b:	8d 50 08             	lea    0x8(%eax),%edx
  10343e:	b9 67 00 00 00       	mov    $0x67,%ecx
  103443:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  10344a:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
  c->gdt[SEG_TSS].s = 0;
  103451:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  103458:	bb 37 00 00 00       	mov    $0x37,%ebx
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  10345d:	89 d1                	mov    %edx,%ecx
  10345f:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
  103466:	c1 ea 18             	shr    $0x18,%edx
  103469:	c1 e9 10             	shr    $0x10,%ecx
  10346c:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  c->gdt[SEG_TSS].s = 0;

  lgdt(c->gdt, sizeof(c->gdt));
  103472:	83 c0 70             	add    $0x70,%eax
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  103475:	88 48 34             	mov    %cl,0x34(%eax)
  103478:	66 89 5c 24 1a       	mov    %bx,0x1a(%esp)
  pd[1] = (uint)p;
  10347d:	66 89 44 24 1c       	mov    %ax,0x1c(%esp)
  pd[2] = (uint)p >> 16;
  103482:	c1 e8 10             	shr    $0x10,%eax
  103485:	66 89 44 24 1e       	mov    %ax,0x1e(%esp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  10348a:	8d 44 24 1a          	lea    0x1a(%esp),%eax
  10348e:	0f 01 10             	lgdtl  (%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  103491:	b8 30 00 00 00       	mov    $0x30,%eax
  103496:	0f 00 d8             	ltr    %ax
  c->gdt[SEG_TSS].s = 0;

  lgdt(c->gdt, sizeof(c->gdt));
  ltr(SEG_TSS << 3);
  popcli();
  103499:	e8 32 0a 00 00       	call   103ed0 <popcli>
}
  10349e:	83 c4 2c             	add    $0x2c,%esp
  1034a1:	5b                   	pop    %ebx
  1034a2:	5e                   	pop    %esi
  1034a3:	5f                   	pop    %edi
  1034a4:	5d                   	pop    %ebp
  1034a5:	c3                   	ret    
  1034a6:	8d 76 00             	lea    0x0(%esi),%esi
  1034a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  pushcli();
  c->ts.ss0 = SEG_KDATA << 3;
  if(cp)
    c->ts.esp0 = (uint)(cp->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;
  1034b0:	c7 40 0c ff ff ff ff 	movl   $0xffffffff,0xc(%eax)

  if(cp){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)cp->mem, cp->sz-1, DPL_USER);
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)cp->mem, cp->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
  1034b7:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
  1034be:	00 00 00 
  1034c1:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
  1034c8:	00 00 00 
    c->gdt[SEG_UDATA] = SEG_NULL;
  1034cb:	c7 80 98 00 00 00 00 	movl   $0x0,0x98(%eax)
  1034d2:	00 00 00 
  1034d5:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%eax)
  1034dc:	00 00 00 
  1034df:	e9 57 ff ff ff       	jmp    10343b <usegment+0xbb>
  1034e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1034ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001034f0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  1034f0:	57                   	push   %edi
  1034f1:	56                   	push   %esi
  1034f2:	53                   	push   %ebx
  char *newmem;

  newmem = kalloc(cp->sz + n);
  1034f3:	c7 c3 f8 ff ff ff    	mov    $0xfffffff8,%ebx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  1034f9:	8b 7c 24 10          	mov    0x10(%esp),%edi
  char *newmem;

  newmem = kalloc(cp->sz + n);
  1034fd:	83 ec 0c             	sub    $0xc,%esp
  103500:	65 8b 03             	mov    %gs:(%ebx),%eax
  103503:	8b 50 04             	mov    0x4(%eax),%edx
  103506:	01 fa                	add    %edi,%edx
  103508:	52                   	push   %edx
  103509:	e8 82 ef ff ff       	call   102490 <kalloc>
  if(newmem == 0)
  10350e:	83 c4 10             	add    $0x10,%esp
  103511:	85 c0                	test   %eax,%eax
  103513:	74 53                	je     103568 <growproc+0x78>
  103515:	89 c6                	mov    %eax,%esi
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  103517:	65 8b 03             	mov    %gs:(%ebx),%eax
  10351a:	83 ec 04             	sub    $0x4,%esp
  10351d:	ff 70 04             	pushl  0x4(%eax)
  103520:	ff 30                	pushl  (%eax)
  103522:	56                   	push   %esi
  103523:	e8 c8 0a 00 00       	call   103ff0 <memmove>
  memset(newmem + cp->sz, 0, n);
  103528:	65 8b 03             	mov    %gs:(%ebx),%eax
  10352b:	83 c4 0c             	add    $0xc,%esp
  10352e:	57                   	push   %edi
  10352f:	6a 00                	push   $0x0
  103531:	8b 48 04             	mov    0x4(%eax),%ecx
  103534:	01 f1                	add    %esi,%ecx
  103536:	51                   	push   %ecx
  103537:	e8 34 0a 00 00       	call   103f70 <memset>
  kfree(cp->mem, cp->sz);
  10353c:	65 8b 03             	mov    %gs:(%ebx),%eax
  10353f:	5a                   	pop    %edx
  103540:	59                   	pop    %ecx
  103541:	ff 70 04             	pushl  0x4(%eax)
  103544:	ff 30                	pushl  (%eax)
  103546:	e8 f5 ed ff ff       	call   102340 <kfree>
  cp->mem = newmem;
  10354b:	65 8b 03             	mov    %gs:(%ebx),%eax
  cp->sz += n;
  10354e:	01 78 04             	add    %edi,0x4(%eax)
  if(newmem == 0)
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  memset(newmem + cp->sz, 0, n);
  kfree(cp->mem, cp->sz);
  cp->mem = newmem;
  103551:	89 30                	mov    %esi,(%eax)
  cp->sz += n;
  usegment();
  103553:	e8 28 fe ff ff       	call   103380 <usegment>
  return 0;
  103558:	83 c4 10             	add    $0x10,%esp
  10355b:	31 c0                	xor    %eax,%eax
}
  10355d:	5b                   	pop    %ebx
  10355e:	5e                   	pop    %esi
  10355f:	5f                   	pop    %edi
  103560:	c3                   	ret    
  103561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  char *newmem;

  newmem = kalloc(cp->sz + n);
  if(newmem == 0)
    return -1;
  103568:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10356d:	eb ee                	jmp    10355d <growproc+0x6d>
  10356f:	90                   	nop

00103570 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  103570:	55                   	push   %ebp
  103571:	57                   	push   %edi
  103572:	56                   	push   %esi
  103573:	53                   	push   %ebx
  103574:	83 ec 0c             	sub    $0xc,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103577:	e8 a4 fb ff ff       	call   103120 <allocproc>
  10357c:	85 c0                	test   %eax,%eax
  10357e:	0f 84 a3 00 00 00    	je     103627 <fork+0xb7>
    return -1;

  // Copy process state from p.
  np->sz = cp->sz;
  103584:	c7 c5 f8 ff ff ff    	mov    $0xfffffff8,%ebp
  10358a:	89 c3                	mov    %eax,%ebx
  if((np->mem = kalloc(np->sz)) == 0){
  10358c:	83 ec 0c             	sub    $0xc,%esp
  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;

  // Copy process state from p.
  np->sz = cp->sz;
  10358f:	65 8b 45 00          	mov    %gs:0x0(%ebp),%eax
  103593:	8b 40 04             	mov    0x4(%eax),%eax
  103596:	89 43 04             	mov    %eax,0x4(%ebx)
  if((np->mem = kalloc(np->sz)) == 0){
  103599:	50                   	push   %eax
  10359a:	e8 f1 ee ff ff       	call   102490 <kalloc>
  10359f:	83 c4 10             	add    $0x10,%esp
  1035a2:	85 c0                	test   %eax,%eax
  1035a4:	89 03                	mov    %eax,(%ebx)
  1035a6:	0f 84 82 00 00 00    	je     10362e <fork+0xbe>
    kfree(np->kstack, KSTACKSIZE);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  memmove(np->mem, cp->mem, np->sz);
  1035ac:	65 8b 55 00          	mov    %gs:0x0(%ebp),%edx
  1035b0:	83 ec 04             	sub    $0x4,%esp
  1035b3:	ff 73 04             	pushl  0x4(%ebx)
  1035b6:	ff 32                	pushl  (%edx)
  1035b8:	50                   	push   %eax
  1035b9:	e8 32 0a 00 00       	call   103ff0 <memmove>
  np->parent = cp;
  1035be:	65 8b 45 00          	mov    %gs:0x0(%ebp),%eax
  *np->tf = *cp->tf;
  1035c2:	8b 53 18             	mov    0x18(%ebx),%edx
  1035c5:	b9 13 00 00 00       	mov    $0x13,%ecx

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  1035ca:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  memmove(np->mem, cp->mem, np->sz);
  np->parent = cp;
  1035cd:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *cp->tf;
  1035d0:	8b 70 18             	mov    0x18(%eax),%esi
  1035d3:	89 d7                	mov    %edx,%edi
  1035d5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
  1035d7:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)

  for(i = 0; i < NOFILE; i++)
  1035de:	31 f6                	xor    %esi,%esi
    if(cp->ofile[i])
  1035e0:	8b 54 b0 28          	mov    0x28(%eax,%esi,4),%edx
  1035e4:	85 d2                	test   %edx,%edx
  1035e6:	74 14                	je     1035fc <fork+0x8c>
      np->ofile[i] = filedup(cp->ofile[i]);
  1035e8:	83 ec 0c             	sub    $0xc,%esp
  1035eb:	52                   	push   %edx
  1035ec:	e8 0f d9 ff ff       	call   100f00 <filedup>
  1035f1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  1035f5:	65 8b 45 00          	mov    %gs:0x0(%ebp),%eax
  1035f9:	83 c4 10             	add    $0x10,%esp
  *np->tf = *cp->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
  1035fc:	83 c6 01             	add    $0x1,%esi
  1035ff:	83 fe 10             	cmp    $0x10,%esi
  103602:	75 dc                	jne    1035e0 <fork+0x70>
    if(cp->ofile[i])
      np->ofile[i] = filedup(cp->ofile[i]);
  np->cwd = idup(cp->cwd);
  103604:	83 ec 0c             	sub    $0xc,%esp
  103607:	ff 70 68             	pushl  0x68(%eax)
  10360a:	e8 c1 de ff ff       	call   1014d0 <idup>
  10360f:	89 43 68             	mov    %eax,0x68(%ebx)
 
  pid = np->pid;
  103612:	8b 43 10             	mov    0x10(%ebx),%eax
  np->state = RUNNABLE;

  return pid;
  103615:	83 c4 10             	add    $0x10,%esp
    if(cp->ofile[i])
      np->ofile[i] = filedup(cp->ofile[i]);
  np->cwd = idup(cp->cwd);
 
  pid = np->pid;
  np->state = RUNNABLE;
  103618:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  return pid;
}
  10361f:	83 c4 0c             	add    $0xc,%esp
  103622:	5b                   	pop    %ebx
  103623:	5e                   	pop    %esi
  103624:	5f                   	pop    %edi
  103625:	5d                   	pop    %ebp
  103626:	c3                   	ret    
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
    return -1;
  103627:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10362c:	eb f1                	jmp    10361f <fork+0xaf>

  // Copy process state from p.
  np->sz = cp->sz;
  if((np->mem = kalloc(np->sz)) == 0){
    kfree(np->kstack, KSTACKSIZE);
  10362e:	83 ec 08             	sub    $0x8,%esp
  103631:	68 00 10 00 00       	push   $0x1000
  103636:	ff 73 08             	pushl  0x8(%ebx)
  103639:	e8 02 ed ff ff       	call   102340 <kfree>
    np->kstack = 0;
  10363e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
  103645:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
  10364c:	83 c4 10             	add    $0x10,%esp
  10364f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103654:	eb c9                	jmp    10361f <fork+0xaf>
  103656:	8d 76 00             	lea    0x0(%esi),%esi
  103659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103660 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103660:	53                   	push   %ebx
  103661:	83 ec 08             	sub    $0x8,%esp
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  103664:	e8 b7 fa ff ff       	call   103120 <allocproc>
  initproc = p;

  // Initialize memory from initcode.S
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  103669:	83 ec 0c             	sub    $0xc,%esp
  
  p = allocproc();
  initproc = p;

  // Initialize memory from initcode.S
  p->sz = PAGE;
  10366c:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
userinit(void)
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  103673:	89 c3                	mov    %eax,%ebx
  initproc = p;

  // Initialize memory from initcode.S
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  103675:	68 00 10 00 00       	push   $0x1000
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = allocproc();
  initproc = p;
  10367a:	a3 80 98 10 00       	mov    %eax,0x109880

  // Initialize memory from initcode.S
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  10367f:	e8 0c ee ff ff       	call   102490 <kalloc>
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  103684:	83 c4 0c             	add    $0xc,%esp
  p = allocproc();
  initproc = p;

  // Initialize memory from initcode.S
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  103687:	89 03                	mov    %eax,(%ebx)
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  103689:	68 2c 00 00 00       	push   $0x2c
  10368e:	68 28 97 10 00       	push   $0x109728
  103693:	50                   	push   %eax
  103694:	e8 57 09 00 00       	call   103ff0 <memmove>

  memset(p->tf, 0, sizeof(*p->tf));
  103699:	83 c4 0c             	add    $0xc,%esp
  10369c:	6a 4c                	push   $0x4c
  10369e:	6a 00                	push   $0x0
  1036a0:	ff 73 18             	pushl  0x18(%ebx)
  1036a3:	e8 c8 08 00 00       	call   103f70 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  1036a8:	8b 43 18             	mov    0x18(%ebx),%eax
  1036ab:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  1036b0:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  1036b5:	83 c4 0c             	add    $0xc,%esp
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);

  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  1036b8:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  1036bc:	ba 2b 00 00 00       	mov    $0x2b,%edx
  p->mem = kalloc(p->sz);
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);

  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  1036c1:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
  1036c5:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  1036c9:	8b 53 04             	mov    0x4(%ebx),%edx

  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  1036cc:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  1036d1:	66 89 48 48          	mov    %cx,0x48(%eax)
  p->tf->eflags = FL_IF;
  1036d5:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = p->sz;
  p->tf->eip = 0;  // beginning of initcode.S
  1036dc:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  1036e3:	89 50 44             	mov    %edx,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  1036e6:	8d 43 6c             	lea    0x6c(%ebx),%eax
  1036e9:	6a 10                	push   $0x10
  1036eb:	68 98 64 10 00       	push   $0x106498
  1036f0:	50                   	push   %eax
  1036f1:	e8 2a 0a 00 00       	call   104120 <safestrcpy>
  p->cwd = namei("/");
  1036f6:	c7 04 24 a1 64 10 00 	movl   $0x1064a1,(%esp)
  1036fd:	e8 1e e8 ff ff       	call   101f20 <namei>

  p->state = RUNNABLE;
  103702:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
  103709:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;
}
  10370c:	83 c4 18             	add    $0x18,%esp
  10370f:	5b                   	pop    %ebx
  103710:	c3                   	ret    
  103711:	eb 0d                	jmp    103720 <scheduler>
  103713:	90                   	nop
  103714:	90                   	nop
  103715:	90                   	nop
  103716:	90                   	nop
  103717:	90                   	nop
  103718:	90                   	nop
  103719:	90                   	nop
  10371a:	90                   	nop
  10371b:	90                   	nop
  10371c:	90                   	nop
  10371d:	90                   	nop
  10371e:	90                   	nop
  10371f:	90                   	nop

00103720 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  103720:	57                   	push   %edi
  103721:	c7 c7 fc ff ff ff    	mov    $0xfffffffc,%edi
  103727:	56                   	push   %esi
  103728:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  10372e:	53                   	push   %ebx
  10372f:	90                   	nop
}

static inline void
sti(void)
{
  asm volatile("sti");
  103730:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor, in lieu of saving intena.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  103731:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103734:	bb 34 d1 10 00       	mov    $0x10d134,%ebx
  for(;;){
    // Enable interrupts on this processor, in lieu of saving intena.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
  103739:	68 00 d1 10 00       	push   $0x10d100
  10373e:	e8 fd 05 00 00       	call   103d40 <acquire>
  103743:	83 c4 10             	add    $0x10,%esp
  103746:	eb 13                	jmp    10375b <scheduler+0x3b>
  103748:	90                   	nop
  103749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103750:	83 c3 7c             	add    $0x7c,%ebx
  103753:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  103759:	74 45                	je     1037a0 <scheduler+0x80>
      if(p->state != RUNNABLE)
  10375b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
  10375f:	75 ef                	jne    103750 <scheduler+0x30>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      cp = p;
  103761:	65 89 1e             	mov    %ebx,%gs:(%esi)
      usegment();
  103764:	e8 17 fc ff ff       	call   103380 <usegment>
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  103769:	8d 43 1c             	lea    0x1c(%ebx),%eax
  10376c:	83 ec 08             	sub    $0x8,%esp
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      cp = p;
      usegment();
      p->state = RUNNING;
  10376f:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor, in lieu of saving intena.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103776:	83 c3 7c             	add    $0x7c,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      cp = p;
      usegment();
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  103779:	50                   	push   %eax
  10377a:	65 8b 07             	mov    %gs:(%edi),%eax
  10377d:	83 c0 04             	add    $0x4,%eax
  103780:	50                   	push   %eax
  103781:	e8 f7 09 00 00       	call   10417d <swtch>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      cp = 0;
  103786:	65 c7 06 00 00 00 00 	movl   $0x0,%gs:(%esi)
      usegment();
  10378d:	e8 ee fb ff ff       	call   103380 <usegment>
  103792:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor, in lieu of saving intena.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103795:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  10379b:	75 be                	jne    10375b <scheduler+0x3b>
  10379d:	8d 76 00             	lea    0x0(%esi),%esi
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      cp = 0;
      usegment();
    }
    release(&ptable.lock);
  1037a0:	83 ec 0c             	sub    $0xc,%esp
  1037a3:	68 00 d1 10 00       	push   $0x10d100
  1037a8:	e8 73 07 00 00       	call   103f20 <release>

  }
  1037ad:	83 c4 10             	add    $0x10,%esp
  1037b0:	e9 7b ff ff ff       	jmp    103730 <scheduler+0x10>
  1037b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1037b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001037c0 <sched>:

// Enter scheduler.  Must already hold ptable.lock
// and have changed cp->state.
void
sched(void)
{
  1037c0:	57                   	push   %edi
  1037c1:	56                   	push   %esi
  1037c2:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1037c3:	9c                   	pushf  
  1037c4:	58                   	pop    %eax
  int intena;

  if(readeflags()&FL_IF)
  1037c5:	f6 c4 02             	test   $0x2,%ah
  1037c8:	75 5e                	jne    103828 <sched+0x68>
    panic("sched interruptible");
  if(cp->state == RUNNING)
  1037ca:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  1037d0:	65 8b 06             	mov    %gs:(%esi),%eax
  1037d3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  1037d7:	74 76                	je     10384f <sched+0x8f>
    panic("sched running");
  if(!holding(&ptable.lock))
  1037d9:	83 ec 0c             	sub    $0xc,%esp
  1037dc:	68 00 d1 10 00       	push   $0x10d100
  1037e1:	e8 8a 06 00 00       	call   103e70 <holding>
  1037e6:	83 c4 10             	add    $0x10,%esp
  1037e9:	85 c0                	test   %eax,%eax
  1037eb:	74 55                	je     103842 <sched+0x82>
    panic("sched ptable.lock");
  if(c->ncli != 1)
  1037ed:	c7 c3 fc ff ff ff    	mov    $0xfffffffc,%ebx
  1037f3:	65 8b 03             	mov    %gs:(%ebx),%eax
  1037f6:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
  1037fd:	75 36                	jne    103835 <sched+0x75>
    panic("sched locks");

  intena = c->intena;
  1037ff:	8b b8 b0 00 00 00    	mov    0xb0(%eax),%edi
  swtch(&cp->context, &c->context);
  103805:	83 ec 08             	sub    $0x8,%esp
  103808:	83 c0 04             	add    $0x4,%eax
  10380b:	50                   	push   %eax
  10380c:	65 8b 06             	mov    %gs:(%esi),%eax
  10380f:	83 c0 1c             	add    $0x1c,%eax
  103812:	50                   	push   %eax
  103813:	e8 65 09 00 00       	call   10417d <swtch>
  c->intena = intena;
  103818:	65 8b 03             	mov    %gs:(%ebx),%eax
}
  10381b:	83 c4 10             	add    $0x10,%esp
  if(c->ncli != 1)
    panic("sched locks");

  intena = c->intena;
  swtch(&cp->context, &c->context);
  c->intena = intena;
  10381e:	89 b8 b0 00 00 00    	mov    %edi,0xb0(%eax)
}
  103824:	5b                   	pop    %ebx
  103825:	5e                   	pop    %esi
  103826:	5f                   	pop    %edi
  103827:	c3                   	ret    
sched(void)
{
  int intena;

  if(readeflags()&FL_IF)
    panic("sched interruptible");
  103828:	83 ec 0c             	sub    $0xc,%esp
  10382b:	68 a3 64 10 00       	push   $0x1064a3
  103830:	e8 eb d1 ff ff       	call   100a20 <panic>
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(c->ncli != 1)
    panic("sched locks");
  103835:	83 ec 0c             	sub    $0xc,%esp
  103838:	68 d7 64 10 00       	push   $0x1064d7
  10383d:	e8 de d1 ff ff       	call   100a20 <panic>
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  103842:	83 ec 0c             	sub    $0xc,%esp
  103845:	68 c5 64 10 00       	push   $0x1064c5
  10384a:	e8 d1 d1 ff ff       	call   100a20 <panic>
  int intena;

  if(readeflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  10384f:	83 ec 0c             	sub    $0xc,%esp
  103852:	68 b7 64 10 00       	push   $0x1064b7
  103857:	e8 c4 d1 ff ff       	call   100a20 <panic>
  10385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103860 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  103860:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
  103863:	68 00 d1 10 00       	push   $0x10d100
  103868:	e8 d3 04 00 00       	call   103d40 <acquire>
  cp->state = RUNNABLE;
  10386d:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  103872:	65 8b 00             	mov    %gs:(%eax),%eax
  103875:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  10387c:	e8 3f ff ff ff       	call   1037c0 <sched>
  release(&ptable.lock);
  103881:	c7 04 24 00 d1 10 00 	movl   $0x10d100,(%esp)
  103888:	e8 93 06 00 00       	call   103f20 <release>
}
  10388d:	83 c4 1c             	add    $0x1c,%esp
  103890:	c3                   	ret    
  103891:	eb 0d                	jmp    1038a0 <sleep>
  103893:	90                   	nop
  103894:	90                   	nop
  103895:	90                   	nop
  103896:	90                   	nop
  103897:	90                   	nop
  103898:	90                   	nop
  103899:	90                   	nop
  10389a:	90                   	nop
  10389b:	90                   	nop
  10389c:	90                   	nop
  10389d:	90                   	nop
  10389e:	90                   	nop
  10389f:	90                   	nop

001038a0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1038a0:	57                   	push   %edi
  1038a1:	56                   	push   %esi
  if(cp == 0)
  1038a2:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1038a8:	53                   	push   %ebx
  1038a9:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1038ad:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  if(cp == 0)
  1038b1:	65 8b 06             	mov    %gs:(%esi),%eax
  1038b4:	85 c0                	test   %eax,%eax
  1038b6:	0f 84 86 00 00 00    	je     103942 <sleep+0xa2>
    panic("sleep");

  if(lk == 0)
  1038bc:	85 db                	test   %ebx,%ebx
  1038be:	74 75                	je     103935 <sleep+0x95>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){
  1038c0:	81 fb 00 d1 10 00    	cmp    $0x10d100,%ebx
  1038c6:	74 50                	je     103918 <sleep+0x78>
    acquire(&ptable.lock);
  1038c8:	83 ec 0c             	sub    $0xc,%esp
  1038cb:	68 00 d1 10 00       	push   $0x10d100
  1038d0:	e8 6b 04 00 00       	call   103d40 <acquire>
    release(lk);
  1038d5:	89 1c 24             	mov    %ebx,(%esp)
  1038d8:	e8 43 06 00 00       	call   103f20 <release>
  }

  // Go to sleep.
  cp->chan = chan;
  1038dd:	65 8b 06             	mov    %gs:(%esi),%eax
  1038e0:	89 78 20             	mov    %edi,0x20(%eax)
  cp->state = SLEEPING;
  1038e3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  1038ea:	e8 d1 fe ff ff       	call   1037c0 <sched>

  // Tidy up.
  cp->chan = 0;
  1038ef:	65 8b 06             	mov    %gs:(%esi),%eax
  1038f2:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
  1038f9:	c7 04 24 00 d1 10 00 	movl   $0x10d100,(%esp)
  103900:	e8 1b 06 00 00       	call   103f20 <release>
    acquire(lk);
  103905:	83 c4 10             	add    $0x10,%esp
  103908:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  }
}
  10390c:	5b                   	pop    %ebx
  10390d:	5e                   	pop    %esi
  10390e:	5f                   	pop    %edi
  cp->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    acquire(lk);
  10390f:	e9 2c 04 00 00       	jmp    103d40 <acquire>
  103914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&ptable.lock);
    release(lk);
  }

  // Go to sleep.
  cp->chan = chan;
  103918:	89 78 20             	mov    %edi,0x20(%eax)
  cp->state = SLEEPING;
  10391b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103922:	e8 99 fe ff ff       	call   1037c0 <sched>

  // Tidy up.
  cp->chan = 0;
  103927:	65 8b 06             	mov    %gs:(%esi),%eax
  10392a:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){
    release(&ptable.lock);
    acquire(lk);
  }
}
  103931:	5b                   	pop    %ebx
  103932:	5e                   	pop    %esi
  103933:	5f                   	pop    %edi
  103934:	c3                   	ret    
{
  if(cp == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
  103935:	83 ec 0c             	sub    $0xc,%esp
  103938:	68 e9 64 10 00       	push   $0x1064e9
  10393d:	e8 de d0 ff ff       	call   100a20 <panic>
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(cp == 0)
    panic("sleep");
  103942:	83 ec 0c             	sub    $0xc,%esp
  103945:	68 e3 64 10 00       	push   $0x1064e3
  10394a:	e8 d1 d0 ff ff       	call   100a20 <panic>
  10394f:	90                   	nop

00103950 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  103950:	53                   	push   %ebx
  103951:	83 ec 14             	sub    $0x14,%esp
  103954:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  acquire(&ptable.lock);
  103958:	68 00 d1 10 00       	push   $0x10d100
  10395d:	e8 de 03 00 00       	call   103d40 <acquire>
  103962:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103965:	b8 34 d1 10 00       	mov    $0x10d134,%eax
  10396a:	eb 0e                	jmp    10397a <wakeup+0x2a>
  10396c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103970:	83 c0 7c             	add    $0x7c,%eax
  103973:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  103978:	74 1c                	je     103996 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
  10397a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  10397e:	75 f0                	jne    103970 <wakeup+0x20>
  103980:	3b 58 20             	cmp    0x20(%eax),%ebx
  103983:	75 eb                	jne    103970 <wakeup+0x20>
      p->state = RUNNABLE;
  103985:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  10398c:	83 c0 7c             	add    $0x7c,%eax
  10398f:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  103994:	75 e4                	jne    10397a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  103996:	c7 44 24 10 00 d1 10 	movl   $0x10d100,0x10(%esp)
  10399d:	00 
}
  10399e:	83 c4 08             	add    $0x8,%esp
  1039a1:	5b                   	pop    %ebx
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
  1039a2:	e9 79 05 00 00       	jmp    103f20 <release>
  1039a7:	89 f6                	mov    %esi,%esi
  1039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001039b0 <kill>:
// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  1039b0:	53                   	push   %ebx
  1039b1:	83 ec 14             	sub    $0x14,%esp
  1039b4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
  1039b8:	68 00 d1 10 00       	push   $0x10d100
  1039bd:	e8 7e 03 00 00       	call   103d40 <acquire>
  1039c2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  1039c5:	b8 34 d1 10 00       	mov    $0x10d134,%eax
  1039ca:	eb 0e                	jmp    1039da <kill+0x2a>
  1039cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1039d0:	83 c0 7c             	add    $0x7c,%eax
  1039d3:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  1039d8:	74 3e                	je     103a18 <kill+0x68>
    if(p->pid == pid){
  1039da:	8b 50 10             	mov    0x10(%eax),%edx
  1039dd:	39 da                	cmp    %ebx,%edx
  1039df:	75 ef                	jne    1039d0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1039e1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  1039e5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1039ec:	74 1a                	je     103a08 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
  1039ee:	83 ec 0c             	sub    $0xc,%esp
  1039f1:	68 00 d1 10 00       	push   $0x10d100
  1039f6:	e8 25 05 00 00       	call   103f20 <release>
      return 0;
  1039fb:	83 c4 10             	add    $0x10,%esp
  1039fe:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
  103a00:	83 c4 08             	add    $0x8,%esp
  103a03:	5b                   	pop    %ebx
  103a04:	c3                   	ret    
  103a05:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  103a08:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103a0f:	eb dd                	jmp    1039ee <kill+0x3e>
  103a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  103a18:	83 ec 0c             	sub    $0xc,%esp
  103a1b:	68 00 d1 10 00       	push   $0x10d100
  103a20:	e8 fb 04 00 00       	call   103f20 <release>
  return -1;
  103a25:	83 c4 10             	add    $0x10,%esp
  103a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  103a2d:	83 c4 08             	add    $0x8,%esp
  103a30:	5b                   	pop    %ebx
  103a31:	c3                   	ret    
  103a32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  103a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103a40 <exit>:
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103a40:	57                   	push   %edi
  struct proc *p;
  int fd;

  if(cp == initproc)
  103a41:	c7 c7 f8 ff ff ff    	mov    $0xfffffff8,%edi
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103a47:	56                   	push   %esi
  103a48:	53                   	push   %ebx
  103a49:	31 db                	xor    %ebx,%ebx
  struct proc *p;
  int fd;

  if(cp == initproc)
  103a4b:	65 8b 17             	mov    %gs:(%edi),%edx
  103a4e:	3b 15 80 98 10 00    	cmp    0x109880,%edx
  103a54:	0f 84 04 01 00 00    	je     103b5e <exit+0x11e>
  103a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd]){
  103a60:	8d 73 08             	lea    0x8(%ebx),%esi
  103a63:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
  103a67:	85 c0                	test   %eax,%eax
  103a69:	74 17                	je     103a82 <exit+0x42>
      fileclose(cp->ofile[fd]);
  103a6b:	83 ec 0c             	sub    $0xc,%esp
  103a6e:	50                   	push   %eax
  103a6f:	e8 dc d4 ff ff       	call   100f50 <fileclose>
      cp->ofile[fd] = 0;
  103a74:	65 8b 17             	mov    %gs:(%edi),%edx
  103a77:	83 c4 10             	add    $0x10,%esp
  103a7a:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
  103a81:	00 

  if(cp == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  103a82:	83 c3 01             	add    $0x1,%ebx
  103a85:	83 fb 10             	cmp    $0x10,%ebx
  103a88:	75 d6                	jne    103a60 <exit+0x20>
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  103a8a:	83 ec 0c             	sub    $0xc,%esp
  103a8d:	ff 72 68             	pushl  0x68(%edx)
  103a90:	e8 0b dd ff ff       	call   1017a0 <iput>
  cp->cwd = 0;
  103a95:	65 8b 07             	mov    %gs:(%edi),%eax
  103a98:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
  103a9f:	c7 04 24 00 d1 10 00 	movl   $0x10d100,(%esp)
  103aa6:	e8 95 02 00 00       	call   103d40 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  103aab:	65 8b 0f             	mov    %gs:(%edi),%ecx
  103aae:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103ab1:	b8 34 d1 10 00       	mov    $0x10d134,%eax
  cp->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  103ab6:	8b 51 14             	mov    0x14(%ecx),%edx
  103ab9:	eb 0f                	jmp    103aca <exit+0x8a>
  103abb:	90                   	nop
  103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103ac0:	83 c0 7c             	add    $0x7c,%eax
  103ac3:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  103ac8:	74 1c                	je     103ae6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
  103aca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103ace:	75 f0                	jne    103ac0 <exit+0x80>
  103ad0:	3b 50 20             	cmp    0x20(%eax),%edx
  103ad3:	75 eb                	jne    103ac0 <exit+0x80>
      p->state = RUNNABLE;
  103ad5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103adc:	83 c0 7c             	add    $0x7c,%eax
  103adf:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  103ae4:	75 e4                	jne    103aca <exit+0x8a>
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  103ae6:	8b 1d 80 98 10 00    	mov    0x109880,%ebx
  103aec:	ba 34 d1 10 00       	mov    $0x10d134,%edx
  103af1:	eb 10                	jmp    103b03 <exit+0xc3>
  103af3:	90                   	nop
  103af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103af8:	83 c2 7c             	add    $0x7c,%edx
  103afb:	81 fa 34 f0 10 00    	cmp    $0x10f034,%edx
  103b01:	74 3b                	je     103b3e <exit+0xfe>
    if(p->parent == cp){
  103b03:	3b 4a 14             	cmp    0x14(%edx),%ecx
  103b06:	75 f0                	jne    103af8 <exit+0xb8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
  103b08:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  103b0c:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
  103b0f:	75 e7                	jne    103af8 <exit+0xb8>
  103b11:	b8 34 d1 10 00       	mov    $0x10d134,%eax
  103b16:	eb 12                	jmp    103b2a <exit+0xea>
  103b18:	90                   	nop
  103b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  103b20:	83 c0 7c             	add    $0x7c,%eax
  103b23:	3d 34 f0 10 00       	cmp    $0x10f034,%eax
  103b28:	74 ce                	je     103af8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
  103b2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103b2e:	75 f0                	jne    103b20 <exit+0xe0>
  103b30:	3b 58 20             	cmp    0x20(%eax),%ebx
  103b33:	75 eb                	jne    103b20 <exit+0xe0>
      p->state = RUNNABLE;
  103b35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  103b3c:	eb e2                	jmp    103b20 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  cp->killed = 0;
  103b3e:	c7 41 24 00 00 00 00 	movl   $0x0,0x24(%ecx)
  cp->state = ZOMBIE;
  103b45:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
  103b4c:	e8 6f fc ff ff       	call   1037c0 <sched>
  panic("zombie exit");
  103b51:	83 ec 0c             	sub    $0xc,%esp
  103b54:	68 07 65 10 00       	push   $0x106507
  103b59:	e8 c2 ce ff ff       	call   100a20 <panic>
{
  struct proc *p;
  int fd;

  if(cp == initproc)
    panic("init exiting");
  103b5e:	83 ec 0c             	sub    $0xc,%esp
  103b61:	68 fa 64 10 00       	push   $0x1064fa
  103b66:	e8 b5 ce ff ff       	call   100a20 <panic>
  103b6b:	90                   	nop
  103b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103b70 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  103b70:	56                   	push   %esi
  103b71:	53                   	push   %ebx
  103b72:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
  103b75:	68 00 d1 10 00       	push   $0x10d100
  103b7a:	e8 c1 01 00 00       	call   103d40 <acquire>
  103b7f:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  103b85:	83 c4 10             	add    $0x10,%esp
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
  103b88:	65 8b 16             	mov    %gs:(%esi),%edx
  int havekids, pid;

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
  103b8b:	31 c9                	xor    %ecx,%ecx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103b8d:	bb 34 d1 10 00       	mov    $0x10d134,%ebx
  103b92:	eb 0f                	jmp    103ba3 <wait+0x33>
  103b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103b98:	83 c3 7c             	add    $0x7c,%ebx
  103b9b:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  103ba1:	74 25                	je     103bc8 <wait+0x58>
      if(p->state == UNUSED)
  103ba3:	8b 43 0c             	mov    0xc(%ebx),%eax
  103ba6:	85 c0                	test   %eax,%eax
  103ba8:	74 ee                	je     103b98 <wait+0x28>
        continue;
      if(p->parent == cp){
  103baa:	39 53 14             	cmp    %edx,0x14(%ebx)
  103bad:	75 e9                	jne    103b98 <wait+0x28>
        havekids = 1;
        if(p->state == ZOMBIE){
  103baf:	83 f8 05             	cmp    $0x5,%eax
  103bb2:	74 32                	je     103be6 <wait+0x76>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103bb4:	83 c3 7c             	add    $0x7c,%ebx
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
        havekids = 1;
  103bb7:	b9 01 00 00 00       	mov    $0x1,%ecx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103bbc:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  103bc2:	75 df                	jne    103ba3 <wait+0x33>
  103bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
  103bc8:	85 c9                	test   %ecx,%ecx
  103bca:	74 69                	je     103c35 <wait+0xc5>
  103bcc:	8b 42 24             	mov    0x24(%edx),%eax
  103bcf:	85 c0                	test   %eax,%eax
  103bd1:	75 62                	jne    103c35 <wait+0xc5>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &ptable.lock);
  103bd3:	83 ec 08             	sub    $0x8,%esp
  103bd6:	68 00 d1 10 00       	push   $0x10d100
  103bdb:	52                   	push   %edx
  103bdc:	e8 bf fc ff ff       	call   1038a0 <sleep>
  }
  103be1:	83 c4 10             	add    $0x10,%esp
  103be4:	eb a2                	jmp    103b88 <wait+0x18>
        continue;
      if(p->parent == cp){
        havekids = 1;
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
  103be6:	83 ec 08             	sub    $0x8,%esp
  103be9:	ff 73 04             	pushl  0x4(%ebx)
  103bec:	ff 33                	pushl  (%ebx)
  103bee:	e8 4d e7 ff ff       	call   102340 <kfree>
          kfree(p->kstack, KSTACKSIZE);
  103bf3:	5a                   	pop    %edx
  103bf4:	59                   	pop    %ecx
  103bf5:	68 00 10 00 00       	push   $0x1000
  103bfa:	ff 73 08             	pushl  0x8(%ebx)
  103bfd:	e8 3e e7 ff ff       	call   102340 <kfree>
          pid = p->pid;
  103c02:	8b 73 10             	mov    0x10(%ebx),%esi
          p->state = UNUSED;
  103c05:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
          p->pid = 0;
  103c0c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
          p->parent = 0;
  103c13:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
          p->name[0] = 0;
  103c1a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
          release(&ptable.lock);
  103c1e:	c7 04 24 00 d1 10 00 	movl   $0x10d100,(%esp)
  103c25:	e8 f6 02 00 00       	call   103f20 <release>
          return pid;
  103c2a:	83 c4 10             	add    $0x10,%esp
  103c2d:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &ptable.lock);
  }
}
  103c2f:	83 c4 04             	add    $0x4,%esp
  103c32:	5b                   	pop    %ebx
  103c33:	5e                   	pop    %esi
  103c34:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
      release(&ptable.lock);
  103c35:	83 ec 0c             	sub    $0xc,%esp
  103c38:	68 00 d1 10 00       	push   $0x10d100
  103c3d:	e8 de 02 00 00       	call   103f20 <release>
      return -1;
  103c42:	83 c4 10             	add    $0x10,%esp
  103c45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &ptable.lock);
  }
}
  103c4a:	83 c4 04             	add    $0x4,%esp
  103c4d:	5b                   	pop    %ebx
  103c4e:	5e                   	pop    %esi
  103c4f:	c3                   	ret    

00103c50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103c50:	55                   	push   %ebp
  103c51:	57                   	push   %edi
  103c52:	56                   	push   %esi
  103c53:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103c54:	bb 34 d1 10 00       	mov    $0x10d134,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  103c59:	83 ec 3c             	sub    $0x3c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
  103c5c:	8d 7c 24 08          	lea    0x8(%esp),%edi
  103c60:	8d 74 24 30          	lea    0x30(%esp),%esi
  103c64:	eb 29                	jmp    103c8f <procdump+0x3f>
  103c66:	8d 76 00             	lea    0x0(%esi),%esi
  103c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  103c70:	83 ec 0c             	sub    $0xc,%esp
  103c73:	68 43 64 10 00       	push   $0x106443
  103c78:	e8 23 ca ff ff       	call   1006a0 <cprintf>
  103c7d:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  103c80:	83 c3 7c             	add    $0x7c,%ebx
  103c83:	81 fb 34 f0 10 00    	cmp    $0x10f034,%ebx
  103c89:	0f 84 81 00 00 00    	je     103d10 <procdump+0xc0>
    if(p->state == UNUSED)
  103c8f:	8b 43 0c             	mov    0xc(%ebx),%eax
  103c92:	85 c0                	test   %eax,%eax
  103c94:	74 ea                	je     103c80 <procdump+0x30>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103c96:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
  103c99:	ba 13 65 10 00       	mov    $0x106513,%edx
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  103c9e:	77 11                	ja     103cb1 <procdump+0x61>
  103ca0:	8b 14 85 4c 65 10 00 	mov    0x10654c(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
  103ca7:	b8 13 65 10 00       	mov    $0x106513,%eax
  103cac:	85 d2                	test   %edx,%edx
  103cae:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
  103cb1:	8b 43 10             	mov    0x10(%ebx),%eax
  103cb4:	8d 4b 6c             	lea    0x6c(%ebx),%ecx
  103cb7:	51                   	push   %ecx
  103cb8:	52                   	push   %edx
  103cb9:	50                   	push   %eax
  103cba:	68 17 65 10 00       	push   $0x106517
  103cbf:	e8 dc c9 ff ff       	call   1006a0 <cprintf>
    if(p->state == SLEEPING){
  103cc4:	83 c4 10             	add    $0x10,%esp
  103cc7:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
  103ccb:	75 a3                	jne    103c70 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
  103ccd:	8b 43 1c             	mov    0x1c(%ebx),%eax
  103cd0:	83 ec 08             	sub    $0x8,%esp
  103cd3:	89 fd                	mov    %edi,%ebp
  103cd5:	57                   	push   %edi
  103cd6:	8b 40 0c             	mov    0xc(%eax),%eax
  103cd9:	83 c0 08             	add    $0x8,%eax
  103cdc:	50                   	push   %eax
  103cdd:	e8 3e 01 00 00       	call   103e20 <getcallerpcs>
  103ce2:	83 c4 10             	add    $0x10,%esp
  103ce5:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
  103ce8:	8b 45 00             	mov    0x0(%ebp),%eax
  103ceb:	85 c0                	test   %eax,%eax
  103ced:	74 81                	je     103c70 <procdump+0x20>
        cprintf(" %p", pc[i]);
  103cef:	83 ec 08             	sub    $0x8,%esp
  103cf2:	83 c5 04             	add    $0x4,%ebp
  103cf5:	50                   	push   %eax
  103cf6:	68 ea 5f 10 00       	push   $0x105fea
  103cfb:	e8 a0 c9 ff ff       	call   1006a0 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
  103d00:	83 c4 10             	add    $0x10,%esp
  103d03:	39 f5                	cmp    %esi,%ebp
  103d05:	75 e1                	jne    103ce8 <procdump+0x98>
  103d07:	e9 64 ff ff ff       	jmp    103c70 <procdump+0x20>
  103d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
  103d10:	83 c4 3c             	add    $0x3c,%esp
  103d13:	5b                   	pop    %ebx
  103d14:	5e                   	pop    %esi
  103d15:	5f                   	pop    %edi
  103d16:	5d                   	pop    %ebp
  103d17:	c3                   	ret    
  103d18:	66 90                	xchg   %ax,%ax
  103d1a:	66 90                	xchg   %ax,%ax
  103d1c:	66 90                	xchg   %ax,%ax
  103d1e:	66 90                	xchg   %ax,%ax

00103d20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lock, char *name)
{
  103d20:	8b 44 24 04          	mov    0x4(%esp),%eax
  lock->name = name;
  103d24:	8b 54 24 08          	mov    0x8(%esp),%edx
  lock->locked = 0;
  103d28:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  103d2e:	89 50 04             	mov    %edx,0x4(%eax)
  lock->locked = 0;
  lock->cpu = 0xffffffff;
  103d31:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
  103d38:	c3                   	ret    
  103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103d40 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  103d40:	56                   	push   %esi
  103d41:	53                   	push   %ebx
  103d42:	83 ec 04             	sub    $0x4,%esp
  103d45:	9c                   	pushf  
  103d46:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103d47:	fa                   	cli    
{
  int eflags;
  
  eflags = readeflags();
  cli();
  if(c->ncli++ == 0)
  103d48:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  103d4d:	65 8b 00             	mov    %gs:(%eax),%eax
  103d50:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103d56:	8d 5a 01             	lea    0x1(%edx),%ebx
  103d59:	85 d2                	test   %edx,%edx
  103d5b:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
  103d61:	75 0c                	jne    103d6f <acquire+0x2f>
    c->intena = eflags & FL_IF;
  103d63:	81 e1 00 02 00 00    	and    $0x200,%ecx
  103d69:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
  103d6f:	8b 74 24 10          	mov    0x10(%esp),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103d73:	8b 06                	mov    (%esi),%eax
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
  103d75:	89 f3                	mov    %esi,%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103d77:	85 c0                	test   %eax,%eax
  103d79:	75 75                	jne    103df0 <acquire+0xb0>
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103d7b:	ba 01 00 00 00       	mov    $0x1,%edx
  103d80:	eb 08                	jmp    103d8a <acquire+0x4a>
  103d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103d88:	89 f3                	mov    %esi,%ebx
  103d8a:	89 d0                	mov    %edx,%eax
  103d8c:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it.  
  while(xchg(&lock->locked, 1) == 1)
  103d8f:	83 f8 01             	cmp    $0x1,%eax
  103d92:	74 f4                	je     103d88 <acquire+0x48>

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  103d94:	e8 a7 e9 ff ff       	call   102740 <cpu>
  getcallerpcs(&lock, lock->pcs);
  103d99:	8d 56 0c             	lea    0xc(%esi),%edx

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  103d9c:	83 c0 0a             	add    $0xa,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103d9f:	8d 4c 24 08          	lea    0x8(%esp),%ecx

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  103da3:	89 46 08             	mov    %eax,0x8(%esi)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103da6:	31 c0                	xor    %eax,%eax
  103da8:	90                   	nop
  103da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103db0:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  103db3:	83 fb fd             	cmp    $0xfffffffd,%ebx
  103db6:	77 18                	ja     103dd0 <acquire+0x90>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103db8:	8b 59 04             	mov    0x4(%ecx),%ebx
  103dbb:	89 1c 82             	mov    %ebx,(%edx,%eax,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103dbe:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103dc1:	8b 09                	mov    (%ecx),%ecx
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103dc3:	83 f8 0a             	cmp    $0xa,%eax
  103dc6:	75 e8                	jne    103db0 <acquire+0x70>
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  getcallerpcs(&lock, lock->pcs);
}
  103dc8:	83 c4 04             	add    $0x4,%esp
  103dcb:	5b                   	pop    %ebx
  103dcc:	5e                   	pop    %esi
  103dcd:	c3                   	ret    
  103dce:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  103dd0:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103dd7:	83 c0 01             	add    $0x1,%eax
  103dda:	83 f8 0a             	cmp    $0xa,%eax
  103ddd:	74 e9                	je     103dc8 <acquire+0x88>
    pcs[i] = 0;
  103ddf:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103de6:	83 c0 01             	add    $0x1,%eax
  103de9:	83 f8 0a             	cmp    $0xa,%eax
  103dec:	75 e2                	jne    103dd0 <acquire+0x90>
  103dee:	eb d8                	jmp    103dc8 <acquire+0x88>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103df0:	8b 76 08             	mov    0x8(%esi),%esi
  103df3:	e8 48 e9 ff ff       	call   102740 <cpu>
  103df8:	83 c0 0a             	add    $0xa,%eax
  103dfb:	39 c6                	cmp    %eax,%esi
  103dfd:	74 09                	je     103e08 <acquire+0xc8>
  103dff:	8b 74 24 10          	mov    0x10(%esp),%esi
  103e03:	e9 73 ff ff ff       	jmp    103d7b <acquire+0x3b>
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
    panic("acquire");
  103e08:	83 ec 0c             	sub    $0xc,%esp
  103e0b:	68 64 65 10 00       	push   $0x106564
  103e10:	e8 0b cc ff ff       	call   100a20 <panic>
  103e15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103e20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103e20:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103e21:	8b 44 24 08          	mov    0x8(%esp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103e25:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103e29:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
  103e2c:	31 c0                	xor    %eax,%eax
  103e2e:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103e30:	8d 5a ff             	lea    -0x1(%edx),%ebx
  103e33:	83 fb fd             	cmp    $0xfffffffd,%ebx
  103e36:	77 18                	ja     103e50 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103e38:	8b 5a 04             	mov    0x4(%edx),%ebx
  103e3b:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e3e:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103e41:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e43:	83 f8 0a             	cmp    $0xa,%eax
  103e46:	75 e8                	jne    103e30 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  103e48:	5b                   	pop    %ebx
  103e49:	c3                   	ret    
  103e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
  103e50:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e57:	83 c0 01             	add    $0x1,%eax
  103e5a:	83 f8 0a             	cmp    $0xa,%eax
  103e5d:	74 e9                	je     103e48 <getcallerpcs+0x28>
    pcs[i] = 0;
  103e5f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e66:	83 c0 01             	add    $0x1,%eax
  103e69:	83 f8 0a             	cmp    $0xa,%eax
  103e6c:	75 e2                	jne    103e50 <getcallerpcs+0x30>
  103e6e:	eb d8                	jmp    103e48 <getcallerpcs+0x28>

00103e70 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103e70:	53                   	push   %ebx
  103e71:	83 ec 08             	sub    $0x8,%esp
  103e74:	8b 54 24 10          	mov    0x10(%esp),%edx
  return lock->locked && lock->cpu == cpu() + 10;
  103e78:	8b 02                	mov    (%edx),%eax
  103e7a:	85 c0                	test   %eax,%eax
  103e7c:	75 0a                	jne    103e88 <holding+0x18>
}
  103e7e:	83 c4 08             	add    $0x8,%esp
  103e81:	31 c0                	xor    %eax,%eax
  103e83:	5b                   	pop    %ebx
  103e84:	c3                   	ret    
  103e85:	8d 76 00             	lea    0x0(%esi),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103e88:	8b 5a 08             	mov    0x8(%edx),%ebx
  103e8b:	e8 b0 e8 ff ff       	call   102740 <cpu>
  103e90:	83 c0 0a             	add    $0xa,%eax
  103e93:	39 d8                	cmp    %ebx,%eax
  103e95:	0f 94 c0             	sete   %al
}
  103e98:	83 c4 08             	add    $0x8,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103e9b:	0f b6 c0             	movzbl %al,%eax
}
  103e9e:	5b                   	pop    %ebx
  103e9f:	c3                   	ret    

00103ea0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103ea0:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103ea1:	9c                   	pushf  
  103ea2:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103ea3:	fa                   	cli    
  int eflags;
  
  eflags = readeflags();
  cli();
  if(c->ncli++ == 0)
  103ea4:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  103ea9:	65 8b 00             	mov    %gs:(%eax),%eax
  103eac:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
  103eb2:	8d 5a 01             	lea    0x1(%edx),%ebx
  103eb5:	85 d2                	test   %edx,%edx
  103eb7:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
  103ebd:	75 0c                	jne    103ecb <pushcli+0x2b>
    c->intena = eflags & FL_IF;
  103ebf:	81 e1 00 02 00 00    	and    $0x200,%ecx
  103ec5:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
}
  103ecb:	5b                   	pop    %ebx
  103ecc:	c3                   	ret    
  103ecd:	8d 76 00             	lea    0x0(%esi),%esi

00103ed0 <popcli>:

void
popcli(void)
{
  103ed0:	83 ec 0c             	sub    $0xc,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103ed3:	9c                   	pushf  
  103ed4:	58                   	pop    %eax
  if(readeflags()&FL_IF)
  103ed5:	f6 c4 02             	test   $0x2,%ah
  103ed8:	75 2f                	jne    103f09 <popcli+0x39>
    panic("popcli - interruptible");
  if(--c->ncli < 0)
  103eda:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  103edf:	65 8b 10             	mov    %gs:(%eax),%edx
  103ee2:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
  103ee9:	78 11                	js     103efc <popcli+0x2c>
    panic("popcli");
  if(c->ncli == 0 && c->intena)
  103eeb:	75 0b                	jne    103ef8 <popcli+0x28>
  103eed:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
  103ef3:	85 c0                	test   %eax,%eax
  103ef5:	74 01                	je     103ef8 <popcli+0x28>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103ef7:	fb                   	sti    
    sti();
}
  103ef8:	83 c4 0c             	add    $0xc,%esp
  103efb:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--c->ncli < 0)
    panic("popcli");
  103efc:	83 ec 0c             	sub    $0xc,%esp
  103eff:	68 83 65 10 00       	push   $0x106583
  103f04:	e8 17 cb ff ff       	call   100a20 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  103f09:	83 ec 0c             	sub    $0xc,%esp
  103f0c:	68 6c 65 10 00       	push   $0x10656c
  103f11:	e8 0a cb ff ff       	call   100a20 <panic>
  103f16:	8d 76 00             	lea    0x0(%esi),%esi
  103f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103f20 <release>:
}

// Release the lock.
void
release(struct spinlock *lock)
{
  103f20:	56                   	push   %esi
  103f21:	53                   	push   %ebx
  103f22:	83 ec 04             	sub    $0x4,%esp
  103f25:	8b 5c 24 10          	mov    0x10(%esp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103f29:	8b 03                	mov    (%ebx),%eax
  103f2b:	85 c0                	test   %eax,%eax
  103f2d:	75 11                	jne    103f40 <release+0x20>
// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");
  103f2f:	83 ec 0c             	sub    $0xc,%esp
  103f32:	68 8a 65 10 00       	push   $0x10658a
  103f37:	e8 e4 ca ff ff       	call   100a20 <panic>
  103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103f40:	8b 73 08             	mov    0x8(%ebx),%esi
  103f43:	e8 f8 e7 ff ff       	call   102740 <cpu>
  103f48:	83 c0 0a             	add    $0xa,%eax
  103f4b:	39 c6                	cmp    %eax,%esi
  103f4d:	75 e0                	jne    103f2f <release+0xf>
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");

  lock->pcs[0] = 0;
  103f4f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lock->cpu = 0xffffffff;
  103f56:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103f5d:	31 c0                	xor    %eax,%eax
  103f5f:	f0 87 03             	lock xchg %eax,(%ebx)
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lock->locked, 0);

  popcli();
}
  103f62:	83 c4 04             	add    $0x4,%esp
  103f65:	5b                   	pop    %ebx
  103f66:	5e                   	pop    %esi
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lock->locked, 0);

  popcli();
  103f67:	e9 64 ff ff ff       	jmp    103ed0 <popcli>
  103f6c:	66 90                	xchg   %ax,%ax
  103f6e:	66 90                	xchg   %ax,%ax

00103f70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  103f70:	57                   	push   %edi
  103f71:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  103f75:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  103f79:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103f7d:	89 d7                	mov    %edx,%edi
  103f7f:	fc                   	cld    
  103f80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  103f82:	89 d0                	mov    %edx,%eax
  103f84:	5f                   	pop    %edi
  103f85:	c3                   	ret    
  103f86:	8d 76 00             	lea    0x0(%esi),%esi
  103f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00103f90 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  103f90:	57                   	push   %edi
  103f91:	56                   	push   %esi
  103f92:	53                   	push   %ebx
  103f93:	8b 44 24 18          	mov    0x18(%esp),%eax
  103f97:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  103f9b:	8b 74 24 14          	mov    0x14(%esp),%esi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103f9f:	85 c0                	test   %eax,%eax
  103fa1:	74 29                	je     103fcc <memcmp+0x3c>
    if(*s1 != *s2)
  103fa3:	0f b6 13             	movzbl (%ebx),%edx
  103fa6:	0f b6 0e             	movzbl (%esi),%ecx
  103fa9:	38 d1                	cmp    %dl,%cl
  103fab:	75 2b                	jne    103fd8 <memcmp+0x48>
  103fad:	8d 78 ff             	lea    -0x1(%eax),%edi
  103fb0:	31 c0                	xor    %eax,%eax
  103fb2:	eb 14                	jmp    103fc8 <memcmp+0x38>
  103fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103fb8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
  103fbd:	83 c0 01             	add    $0x1,%eax
  103fc0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
  103fc4:	38 ca                	cmp    %cl,%dl
  103fc6:	75 10                	jne    103fd8 <memcmp+0x48>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  103fc8:	39 f8                	cmp    %edi,%eax
  103fca:	75 ec                	jne    103fb8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  103fcc:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
  103fcd:	31 c0                	xor    %eax,%eax
}
  103fcf:	5e                   	pop    %esi
  103fd0:	5f                   	pop    %edi
  103fd1:	c3                   	ret    
  103fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103fd8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
  103fdb:	5b                   	pop    %ebx
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  103fdc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
  103fde:	5e                   	pop    %esi
  103fdf:	5f                   	pop    %edi
  103fe0:	c3                   	ret    
  103fe1:	eb 0d                	jmp    103ff0 <memmove>
  103fe3:	90                   	nop
  103fe4:	90                   	nop
  103fe5:	90                   	nop
  103fe6:	90                   	nop
  103fe7:	90                   	nop
  103fe8:	90                   	nop
  103fe9:	90                   	nop
  103fea:	90                   	nop
  103feb:	90                   	nop
  103fec:	90                   	nop
  103fed:	90                   	nop
  103fee:	90                   	nop
  103fef:	90                   	nop

00103ff0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  103ff0:	56                   	push   %esi
  103ff1:	53                   	push   %ebx
  103ff2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103ff6:	8b 74 24 10          	mov    0x10(%esp),%esi
  103ffa:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  103ffe:	39 c6                	cmp    %eax,%esi
  104000:	73 2e                	jae    104030 <memmove+0x40>
  104002:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
  104005:	39 c8                	cmp    %ecx,%eax
  104007:	73 27                	jae    104030 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  104009:	85 db                	test   %ebx,%ebx
  10400b:	8d 53 ff             	lea    -0x1(%ebx),%edx
  10400e:	74 17                	je     104027 <memmove+0x37>
      *--d = *--s;
  104010:	29 d9                	sub    %ebx,%ecx
  104012:	89 cb                	mov    %ecx,%ebx
  104014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104018:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  10401c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  10401f:	83 ea 01             	sub    $0x1,%edx
  104022:	83 fa ff             	cmp    $0xffffffff,%edx
  104025:	75 f1                	jne    104018 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  104027:	5b                   	pop    %ebx
  104028:	5e                   	pop    %esi
  104029:	c3                   	ret    
  10402a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  104030:	31 d2                	xor    %edx,%edx
  104032:	85 db                	test   %ebx,%ebx
  104034:	74 f1                	je     104027 <memmove+0x37>
  104036:	8d 76 00             	lea    0x0(%esi),%esi
  104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
  104040:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  104044:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  104047:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  10404a:	39 d3                	cmp    %edx,%ebx
  10404c:	75 f2                	jne    104040 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
  10404e:	5b                   	pop    %ebx
  10404f:	5e                   	pop    %esi
  104050:	c3                   	ret    
  104051:	eb 0d                	jmp    104060 <strncmp>
  104053:	90                   	nop
  104054:	90                   	nop
  104055:	90                   	nop
  104056:	90                   	nop
  104057:	90                   	nop
  104058:	90                   	nop
  104059:	90                   	nop
  10405a:	90                   	nop
  10405b:	90                   	nop
  10405c:	90                   	nop
  10405d:	90                   	nop
  10405e:	90                   	nop
  10405f:	90                   	nop

00104060 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  104060:	57                   	push   %edi
  104061:	56                   	push   %esi
  104062:	53                   	push   %ebx
  104063:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104067:	8b 7c 24 10          	mov    0x10(%esp),%edi
  10406b:	8b 74 24 14          	mov    0x14(%esp),%esi
  while(n > 0 && *p && *p == *q)
  10406f:	85 c9                	test   %ecx,%ecx
  104071:	74 37                	je     1040aa <strncmp+0x4a>
  104073:	0f b6 17             	movzbl (%edi),%edx
  104076:	0f b6 1e             	movzbl (%esi),%ebx
  104079:	84 d2                	test   %dl,%dl
  10407b:	74 37                	je     1040b4 <strncmp+0x54>
  10407d:	38 d3                	cmp    %dl,%bl
  10407f:	75 33                	jne    1040b4 <strncmp+0x54>
  104081:	8d 47 01             	lea    0x1(%edi),%eax
  104084:	01 cf                	add    %ecx,%edi
  104086:	eb 1b                	jmp    1040a3 <strncmp+0x43>
  104088:	90                   	nop
  104089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104090:	0f b6 10             	movzbl (%eax),%edx
  104093:	84 d2                	test   %dl,%dl
  104095:	74 19                	je     1040b0 <strncmp+0x50>
  104097:	0f b6 19             	movzbl (%ecx),%ebx
  10409a:	83 c0 01             	add    $0x1,%eax
  10409d:	89 ce                	mov    %ecx,%esi
  10409f:	38 da                	cmp    %bl,%dl
  1040a1:	75 11                	jne    1040b4 <strncmp+0x54>
  1040a3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
  1040a5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  1040a8:	75 e6                	jne    104090 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  1040aa:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  1040ab:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
  1040ad:	5e                   	pop    %esi
  1040ae:	5f                   	pop    %edi
  1040af:	c3                   	ret    
  1040b0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  1040b4:	0f b6 c2             	movzbl %dl,%eax
  1040b7:	29 d8                	sub    %ebx,%eax
}
  1040b9:	5b                   	pop    %ebx
  1040ba:	5e                   	pop    %esi
  1040bb:	5f                   	pop    %edi
  1040bc:	c3                   	ret    
  1040bd:	8d 76 00             	lea    0x0(%esi),%esi

001040c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
  1040c0:	56                   	push   %esi
  1040c1:	53                   	push   %ebx
  1040c2:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1040c6:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1040ca:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  1040ce:	89 c2                	mov    %eax,%edx
  1040d0:	eb 19                	jmp    1040eb <strncpy+0x2b>
  1040d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1040d8:	83 c3 01             	add    $0x1,%ebx
  1040db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
  1040df:	83 c2 01             	add    $0x1,%edx
  1040e2:	84 c9                	test   %cl,%cl
  1040e4:	88 4a ff             	mov    %cl,-0x1(%edx)
  1040e7:	74 09                	je     1040f2 <strncpy+0x32>
  1040e9:	89 f1                	mov    %esi,%ecx
  1040eb:	85 c9                	test   %ecx,%ecx
  1040ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
  1040f0:	7f e6                	jg     1040d8 <strncpy+0x18>
    ;
  while(n-- > 0)
  1040f2:	31 c9                	xor    %ecx,%ecx
  1040f4:	85 f6                	test   %esi,%esi
  1040f6:	7e 17                	jle    10410f <strncpy+0x4f>
  1040f8:	90                   	nop
  1040f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
  104100:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
  104104:	89 f3                	mov    %esi,%ebx
  104106:	83 c1 01             	add    $0x1,%ecx
  104109:	29 cb                	sub    %ecx,%ebx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  10410b:	85 db                	test   %ebx,%ebx
  10410d:	7f f1                	jg     104100 <strncpy+0x40>
    *s++ = 0;
  return os;
}
  10410f:	5b                   	pop    %ebx
  104110:	5e                   	pop    %esi
  104111:	c3                   	ret    
  104112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104120 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  104120:	56                   	push   %esi
  104121:	53                   	push   %ebx
  104122:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  104126:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10412a:	8b 54 24 10          	mov    0x10(%esp),%edx
  char *os;
  
  os = s;
  if(n <= 0)
  10412e:	85 c9                	test   %ecx,%ecx
  104130:	7e 26                	jle    104158 <safestrcpy+0x38>
  104132:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
  104136:	89 c1                	mov    %eax,%ecx
  104138:	eb 17                	jmp    104151 <safestrcpy+0x31>
  10413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  104140:	83 c2 01             	add    $0x1,%edx
  104143:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
  104147:	83 c1 01             	add    $0x1,%ecx
  10414a:	84 db                	test   %bl,%bl
  10414c:	88 59 ff             	mov    %bl,-0x1(%ecx)
  10414f:	74 04                	je     104155 <safestrcpy+0x35>
  104151:	39 f2                	cmp    %esi,%edx
  104153:	75 eb                	jne    104140 <safestrcpy+0x20>
    ;
  *s = 0;
  104155:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  104158:	5b                   	pop    %ebx
  104159:	5e                   	pop    %esi
  10415a:	c3                   	ret    
  10415b:	90                   	nop
  10415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104160 <strlen>:

int
strlen(const char *s)
{
  104160:	8b 54 24 04          	mov    0x4(%esp),%edx
  int n;

  for(n = 0; s[n]; n++)
  104164:	31 c0                	xor    %eax,%eax
  104166:	80 3a 00             	cmpb   $0x0,(%edx)
  104169:	74 10                	je     10417b <strlen+0x1b>
  10416b:	90                   	nop
  10416c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104170:	83 c0 01             	add    $0x1,%eax
  104173:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  104177:	75 f7                	jne    104170 <strlen+0x10>
  104179:	f3 c3                	repz ret 
    ;
  return n;
}
  10417b:	f3 c3                	repz ret 

0010417d <swtch>:
  10417d:	8b 44 24 04          	mov    0x4(%esp),%eax
  104181:	8b 54 24 08          	mov    0x8(%esp),%edx
  104185:	55                   	push   %ebp
  104186:	53                   	push   %ebx
  104187:	56                   	push   %esi
  104188:	57                   	push   %edi
  104189:	89 20                	mov    %esp,(%eax)
  10418b:	8b 22                	mov    (%edx),%esp
  10418d:	5f                   	pop    %edi
  10418e:	5e                   	pop    %esi
  10418f:	5b                   	pop    %ebx
  104190:	5d                   	pop    %ebp
  104191:	c3                   	ret    
  104192:	66 90                	xchg   %ax,%ax
  104194:	66 90                	xchg   %ax,%ax
  104196:	66 90                	xchg   %ax,%ax
  104198:	66 90                	xchg   %ax,%ax
  10419a:	66 90                	xchg   %ax,%ax
  10419c:	66 90                	xchg   %ax,%ax
  10419e:	66 90                	xchg   %ax,%ax

001041a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  1041a0:	53                   	push   %ebx
  1041a1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1041a5:	8b 44 24 0c          	mov    0xc(%esp),%eax
  if(addr >= p->sz || addr+4 > p->sz)
  1041a9:	8b 51 04             	mov    0x4(%ecx),%edx
  1041ac:	39 c2                	cmp    %eax,%edx
  1041ae:	76 20                	jbe    1041d0 <fetchint+0x30>
  1041b0:	8d 58 04             	lea    0x4(%eax),%ebx
  1041b3:	39 da                	cmp    %ebx,%edx
  1041b5:	72 19                	jb     1041d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1041b7:	8b 11                	mov    (%ecx),%edx
  1041b9:	8b 14 02             	mov    (%edx,%eax,1),%edx
  1041bc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1041c0:	89 10                	mov    %edx,(%eax)
  return 0;
  1041c2:	31 c0                	xor    %eax,%eax
}
  1041c4:	5b                   	pop    %ebx
  1041c5:	c3                   	ret    
  1041c6:	8d 76 00             	lea    0x0(%esi),%esi
  1041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  1041d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(p->mem + addr);
  return 0;
}
  1041d5:	5b                   	pop    %ebx
  1041d6:	c3                   	ret    
  1041d7:	89 f6                	mov    %esi,%esi
  1041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001041e0 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  1041e0:	53                   	push   %ebx
  1041e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1041e5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *s, *ep;

  if(addr >= p->sz)
  1041e9:	8b 50 04             	mov    0x4(%eax),%edx
  1041ec:	39 ca                	cmp    %ecx,%edx
  1041ee:	76 2c                	jbe    10421c <fetchstr+0x3c>
    return -1;
  *pp = p->mem + addr;
  1041f0:	03 08                	add    (%eax),%ecx
  1041f2:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1041f6:	89 0b                	mov    %ecx,(%ebx)
  ep = p->mem + p->sz;
  1041f8:	03 10                	add    (%eax),%edx
  for(s = *pp; s < ep; s++)
  1041fa:	39 d1                	cmp    %edx,%ecx
  1041fc:	73 1e                	jae    10421c <fetchstr+0x3c>
    if(*s == 0)
  1041fe:	80 39 00             	cmpb   $0x0,(%ecx)
  104201:	74 29                	je     10422c <fetchstr+0x4c>
  104203:	89 c8                	mov    %ecx,%eax
  104205:	eb 0e                	jmp    104215 <fetchstr+0x35>
  104207:	89 f6                	mov    %esi,%esi
  104209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  104210:	80 38 00             	cmpb   $0x0,(%eax)
  104213:	74 13                	je     104228 <fetchstr+0x48>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  104215:	83 c0 01             	add    $0x1,%eax
  104218:	39 c2                	cmp    %eax,%edx
  10421a:	75 f4                	jne    104210 <fetchstr+0x30>
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  10421c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
  104221:	5b                   	pop    %ebx
  104222:	c3                   	ret    
  104223:	90                   	nop
  104224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104228:	29 c8                	sub    %ecx,%eax
  10422a:	5b                   	pop    %ebx
  10422b:	c3                   	ret    
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  10422c:	31 c0                	xor    %eax,%eax
      return s - *pp;
  return -1;
}
  10422e:	5b                   	pop    %ebx
  10422f:	c3                   	ret    

00104230 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104230:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  104235:	53                   	push   %ebx
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104236:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  10423a:	65 8b 00             	mov    %gs:(%eax),%eax
  10423d:	8b 50 18             	mov    0x18(%eax),%edx
  104240:	8b 52 44             	mov    0x44(%edx),%edx
  104243:	8d 14 8a             	lea    (%edx,%ecx,4),%edx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104246:	8b 48 04             	mov    0x4(%eax),%ecx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104249:	8d 5a 04             	lea    0x4(%edx),%ebx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  10424c:	39 cb                	cmp    %ecx,%ebx
  10424e:	73 20                	jae    104270 <argint+0x40>
  104250:	8d 5a 08             	lea    0x8(%edx),%ebx
  104253:	39 d9                	cmp    %ebx,%ecx
  104255:	72 19                	jb     104270 <argint+0x40>
    return -1;
  *ip = *(int*)(p->mem + addr);
  104257:	8b 00                	mov    (%eax),%eax
  104259:	8b 54 10 04          	mov    0x4(%eax,%edx,1),%edx
  10425d:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104261:	89 10                	mov    %edx,(%eax)
  return 0;
  104263:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  104265:	5b                   	pop    %ebx
  104266:	c3                   	ret    
  104267:	89 f6                	mov    %esi,%esi
  104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  104270:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  104275:	5b                   	pop    %ebx
  104276:	c3                   	ret    
  104277:	89 f6                	mov    %esi,%esi
  104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104280 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104280:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  104285:	56                   	push   %esi
  104286:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  104287:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  10428b:	65 8b 10             	mov    %gs:(%eax),%edx
  10428e:	8b 42 18             	mov    0x18(%edx),%eax
  104291:	8b 40 44             	mov    0x44(%eax),%eax
  104294:	8d 1c 88             	lea    (%eax,%ecx,4),%ebx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104297:	8b 4a 04             	mov    0x4(%edx),%ecx
argptr(int n, char **pp, int size)
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  10429a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  10429f:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1042a2:	39 ce                	cmp    %ecx,%esi
  1042a4:	73 25                	jae    1042cb <argptr+0x4b>
  1042a6:	8d 73 08             	lea    0x8(%ebx),%esi
  1042a9:	39 f1                	cmp    %esi,%ecx
  1042ab:	72 1e                	jb     1042cb <argptr+0x4b>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1042ad:	8b 32                	mov    (%edx),%esi
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
  1042af:	8b 54 1e 04          	mov    0x4(%esi,%ebx,1),%edx
  1042b3:	39 ca                	cmp    %ecx,%edx
  1042b5:	73 14                	jae    1042cb <argptr+0x4b>
  1042b7:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1042bb:	01 d3                	add    %edx,%ebx
  1042bd:	39 cb                	cmp    %ecx,%ebx
  1042bf:	73 0a                	jae    1042cb <argptr+0x4b>
    return -1;
  *pp = cp->mem + i;
  1042c1:	8b 44 24 10          	mov    0x10(%esp),%eax
  1042c5:	01 f2                	add    %esi,%edx
  1042c7:	89 10                	mov    %edx,(%eax)
  return 0;
  1042c9:	31 c0                	xor    %eax,%eax
}
  1042cb:	5b                   	pop    %ebx
  1042cc:	5e                   	pop    %esi
  1042cd:	c3                   	ret    
  1042ce:	66 90                	xchg   %ax,%ax

001042d0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  1042d0:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  1042d5:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  1042d6:	8b 54 24 08          	mov    0x8(%esp),%edx
  1042da:	65 8b 18             	mov    %gs:(%eax),%ebx
  1042dd:	8b 43 18             	mov    0x18(%ebx),%eax
  1042e0:	8b 40 44             	mov    0x44(%eax),%eax
  1042e3:	8d 04 90             	lea    (%eax,%edx,4),%eax

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1042e6:	8b 53 04             	mov    0x4(%ebx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  1042e9:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1042ec:	39 d1                	cmp    %edx,%ecx
  1042ee:	73 07                	jae    1042f7 <argstr+0x27>
  1042f0:	8d 48 08             	lea    0x8(%eax),%ecx
  1042f3:	39 ca                	cmp    %ecx,%edx
  1042f5:	73 09                	jae    104300 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  1042f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(cp, addr, pp);
}
  1042fc:	5b                   	pop    %ebx
  1042fd:	c3                   	ret    
  1042fe:	66 90                	xchg   %ax,%ax
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
    return -1;
  *ip = *(int*)(p->mem + addr);
  104300:	8b 0b                	mov    (%ebx),%ecx
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
  104302:	8b 44 01 04          	mov    0x4(%ecx,%eax,1),%eax
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  104306:	39 d0                	cmp    %edx,%eax
  104308:	73 ed                	jae    1042f7 <argstr+0x27>
    return -1;
  *pp = p->mem + addr;
  10430a:	01 c1                	add    %eax,%ecx
  10430c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104310:	89 08                	mov    %ecx,(%eax)
  ep = p->mem + p->sz;
  104312:	03 13                	add    (%ebx),%edx
  for(s = *pp; s < ep; s++)
  104314:	39 d1                	cmp    %edx,%ecx
  104316:	73 df                	jae    1042f7 <argstr+0x27>
    if(*s == 0)
  104318:	80 39 00             	cmpb   $0x0,(%ecx)
  10431b:	74 27                	je     104344 <argstr+0x74>
  10431d:	89 c8                	mov    %ecx,%eax
  10431f:	eb 0c                	jmp    10432d <argstr+0x5d>
  104321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104328:	80 38 00             	cmpb   $0x0,(%eax)
  10432b:	74 13                	je     104340 <argstr+0x70>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  10432d:	83 c0 01             	add    $0x1,%eax
  104330:	39 c2                	cmp    %eax,%edx
  104332:	75 f4                	jne    104328 <argstr+0x58>
  104334:	eb c1                	jmp    1042f7 <argstr+0x27>
  104336:	8d 76 00             	lea    0x0(%esi),%esi
  104339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  104340:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104342:	5b                   	pop    %ebx
  104343:	c3                   	ret    
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104344:	31 c0                	xor    %eax,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  104346:	5b                   	pop    %ebx
  104347:	c3                   	ret    
  104348:	90                   	nop
  104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104350 <syscall>:
[SYS_write]   sys_write,
};

void
syscall(void)
{
  104350:	56                   	push   %esi
  104351:	53                   	push   %ebx
  104352:	83 ec 04             	sub    $0x4,%esp
  int num;
  
  num = cp->tf->eax;
  104355:	c7 c3 f8 ff ff ff    	mov    $0xfffffff8,%ebx
  10435b:	65 8b 03             	mov    %gs:(%ebx),%eax
  10435e:	8b 70 18             	mov    0x18(%eax),%esi
  104361:	8b 56 1c             	mov    0x1c(%esi),%edx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  104364:	83 fa 14             	cmp    $0x14,%edx
  104367:	77 17                	ja     104380 <syscall+0x30>
  104369:	8b 0c 95 c0 65 10 00 	mov    0x1065c0(,%edx,4),%ecx
  104370:	85 c9                	test   %ecx,%ecx
  104372:	74 0c                	je     104380 <syscall+0x30>
    cp->tf->eax = syscalls[num]();
  104374:	ff d1                	call   *%ecx
  104376:	89 46 1c             	mov    %eax,0x1c(%esi)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  104379:	83 c4 04             	add    $0x4,%esp
  10437c:	5b                   	pop    %ebx
  10437d:	5e                   	pop    %esi
  10437e:	c3                   	ret    
  10437f:	90                   	nop
  
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  104380:	8b 48 10             	mov    0x10(%eax),%ecx
            cp->pid, cp->name, num);
  104383:	83 c0 6c             	add    $0x6c,%eax
  
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  104386:	52                   	push   %edx
  104387:	50                   	push   %eax
  104388:	51                   	push   %ecx
  104389:	68 92 65 10 00       	push   $0x106592
  10438e:	e8 0d c3 ff ff       	call   1006a0 <cprintf>
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  104393:	65 8b 03             	mov    %gs:(%ebx),%eax
  104396:	83 c4 10             	add    $0x10,%esp
  104399:	8b 40 18             	mov    0x18(%eax),%eax
  10439c:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  1043a3:	83 c4 04             	add    $0x4,%esp
  1043a6:	5b                   	pop    %ebx
  1043a7:	5e                   	pop    %esi
  1043a8:	c3                   	ret    
  1043a9:	66 90                	xchg   %ax,%ax
  1043ab:	66 90                	xchg   %ax,%ax
  1043ad:	66 90                	xchg   %ax,%ax
  1043af:	90                   	nop

001043b0 <create>:
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  1043b0:	55                   	push   %ebp
  1043b1:	57                   	push   %edi
  1043b2:	89 d7                	mov    %edx,%edi
  1043b4:	56                   	push   %esi
  1043b5:	53                   	push   %ebx
  1043b6:	83 ec 44             	sub    $0x44,%esp
  1043b9:	8b 54 24 58          	mov    0x58(%esp),%edx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  1043bd:	8d 74 24 2a          	lea    0x2a(%esp),%esi
  return 0;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  1043c1:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  1043c5:	89 54 24 14          	mov    %edx,0x14(%esp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  1043c9:	56                   	push   %esi
  1043ca:	50                   	push   %eax
  1043cb:	e8 70 db ff ff       	call   101f40 <nameiparent>
  1043d0:	83 c4 10             	add    $0x10,%esp
  1043d3:	85 c0                	test   %eax,%eax
  1043d5:	0f 84 f5 00 00 00    	je     1044d0 <create+0x120>
    return 0;
  ilock(dp);
  1043db:	83 ec 0c             	sub    $0xc,%esp
  1043de:	89 c5                	mov    %eax,%ebp
  1043e0:	50                   	push   %eax
  1043e1:	e8 1a d1 ff ff       	call   101500 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
  1043e6:	83 c4 0c             	add    $0xc,%esp
  1043e9:	8d 44 24 20          	lea    0x20(%esp),%eax
  1043ed:	50                   	push   %eax
  1043ee:	56                   	push   %esi
  1043ef:	55                   	push   %ebp
  1043f0:	e8 cb d7 ff ff       	call   101bc0 <dirlookup>
  1043f5:	83 c4 10             	add    $0x10,%esp
  1043f8:	85 c0                	test   %eax,%eax
  1043fa:	89 c3                	mov    %eax,%ebx
  1043fc:	74 52                	je     104450 <create+0xa0>
    iunlockput(dp);
  1043fe:	83 ec 0c             	sub    $0xc,%esp
  104401:	55                   	push   %ebp
  104402:	e8 f9 d4 ff ff       	call   101900 <iunlockput>
    ilock(ip);
  104407:	89 1c 24             	mov    %ebx,(%esp)
  10440a:	e8 f1 d0 ff ff       	call   101500 <ilock>
    if(ip->type != type || type != T_FILE){
  10440f:	83 c4 10             	add    $0x10,%esp
  104412:	66 39 7b 10          	cmp    %di,0x10(%ebx)
  104416:	75 18                	jne    104430 <create+0x80>
  104418:	66 83 ff 02          	cmp    $0x2,%di
  10441c:	89 d8                	mov    %ebx,%eax
  10441e:	75 10                	jne    104430 <create+0x80>
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  104420:	83 c4 3c             	add    $0x3c,%esp
  104423:	5b                   	pop    %ebx
  104424:	5e                   	pop    %esi
  104425:	5f                   	pop    %edi
  104426:	5d                   	pop    %ebp
  104427:	c3                   	ret    
  104428:	90                   	nop
  104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(ip->type != type || type != T_FILE){
      iunlockput(ip);
  104430:	83 ec 0c             	sub    $0xc,%esp
  104433:	53                   	push   %ebx
  104434:	e8 c7 d4 ff ff       	call   101900 <iunlockput>
      return 0;
  104439:	83 c4 10             	add    $0x10,%esp
  10443c:	31 c0                	xor    %eax,%eax
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);
  return ip;
}
  10443e:	83 c4 3c             	add    $0x3c,%esp
  104441:	5b                   	pop    %ebx
  104442:	5e                   	pop    %esi
  104443:	5f                   	pop    %edi
  104444:	5d                   	pop    %ebp
  104445:	c3                   	ret    
  104446:	8d 76 00             	lea    0x0(%esi),%esi
  104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return 0;
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
  104450:	83 ec 08             	sub    $0x8,%esp
  104453:	0f bf c7             	movswl %di,%eax
  104456:	50                   	push   %eax
  104457:	ff 75 00             	pushl  0x0(%ebp)
  10445a:	e8 01 d2 ff ff       	call   101660 <ialloc>
  10445f:	83 c4 10             	add    $0x10,%esp
  104462:	85 c0                	test   %eax,%eax
  104464:	89 c3                	mov    %eax,%ebx
  104466:	0f 84 c4 00 00 00    	je     104530 <create+0x180>
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  10446c:	83 ec 0c             	sub    $0xc,%esp
  10446f:	50                   	push   %eax
  104470:	e8 8b d0 ff ff       	call   101500 <ilock>
  ip->major = major;
  104475:	0f b7 44 24 18       	movzwl 0x18(%esp),%eax
  10447a:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10447e:	0f b7 44 24 1c       	movzwl 0x1c(%esp),%eax
  104483:	66 89 43 14          	mov    %ax,0x14(%ebx)
  ip->nlink = 1;
  104487:	b8 01 00 00 00       	mov    $0x1,%eax
  10448c:	66 89 43 16          	mov    %ax,0x16(%ebx)
  iupdate(ip);
  104490:	89 1c 24             	mov    %ebx,(%esp)
  104493:	e8 88 d2 ff ff       	call   101720 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
  104498:	83 c4 10             	add    $0x10,%esp
  10449b:	66 83 ff 01          	cmp    $0x1,%di
  10449f:	74 3f                	je     1044e0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
  1044a1:	83 ec 04             	sub    $0x4,%esp
  1044a4:	ff 73 04             	pushl  0x4(%ebx)
  1044a7:	56                   	push   %esi
  1044a8:	55                   	push   %ebp
  1044a9:	e8 b2 d9 ff ff       	call   101e60 <dirlink>
  1044ae:	83 c4 10             	add    $0x10,%esp
  1044b1:	85 c0                	test   %eax,%eax
  1044b3:	0f 88 8a 00 00 00    	js     104543 <create+0x193>
    panic("create: dirlink");

  iunlockput(dp);
  1044b9:	83 ec 0c             	sub    $0xc,%esp
  1044bc:	55                   	push   %ebp
  1044bd:	e8 3e d4 ff ff       	call   101900 <iunlockput>
  return ip;
  1044c2:	83 c4 10             	add    $0x10,%esp
  1044c5:	89 d8                	mov    %ebx,%eax
}
  1044c7:	83 c4 3c             	add    $0x3c,%esp
  1044ca:	5b                   	pop    %ebx
  1044cb:	5e                   	pop    %esi
  1044cc:	5f                   	pop    %edi
  1044cd:	5d                   	pop    %ebp
  1044ce:	c3                   	ret    
  1044cf:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  1044d0:	31 c0                	xor    %eax,%eax
  1044d2:	e9 49 ff ff ff       	jmp    104420 <create+0x70>
  1044d7:	89 f6                	mov    %esi,%esi
  1044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  1044e0:	66 83 45 16 01       	addw   $0x1,0x16(%ebp)
    iupdate(dp);
  1044e5:	83 ec 0c             	sub    $0xc,%esp
  1044e8:	55                   	push   %ebp
  1044e9:	e8 32 d2 ff ff       	call   101720 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  1044ee:	83 c4 0c             	add    $0xc,%esp
  1044f1:	ff 73 04             	pushl  0x4(%ebx)
  1044f4:	68 21 66 10 00       	push   $0x106621
  1044f9:	53                   	push   %ebx
  1044fa:	e8 61 d9 ff ff       	call   101e60 <dirlink>
  1044ff:	83 c4 10             	add    $0x10,%esp
  104502:	85 c0                	test   %eax,%eax
  104504:	78 18                	js     10451e <create+0x16e>
  104506:	83 ec 04             	sub    $0x4,%esp
  104509:	ff 75 04             	pushl  0x4(%ebp)
  10450c:	68 20 66 10 00       	push   $0x106620
  104511:	53                   	push   %ebx
  104512:	e8 49 d9 ff ff       	call   101e60 <dirlink>
  104517:	83 c4 10             	add    $0x10,%esp
  10451a:	85 c0                	test   %eax,%eax
  10451c:	79 83                	jns    1044a1 <create+0xf1>
      panic("create dots");
  10451e:	83 ec 0c             	sub    $0xc,%esp
  104521:	68 14 66 10 00       	push   $0x106614
  104526:	e8 f5 c4 ff ff       	call   100a20 <panic>
  10452b:	90                   	nop
  10452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
  104530:	83 ec 0c             	sub    $0xc,%esp
  104533:	55                   	push   %ebp
  104534:	e8 c7 d3 ff ff       	call   101900 <iunlockput>
    return 0;
  104539:	83 c4 10             	add    $0x10,%esp
  10453c:	31 c0                	xor    %eax,%eax
  10453e:	e9 dd fe ff ff       	jmp    104420 <create+0x70>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
  104543:	83 ec 0c             	sub    $0xc,%esp
  104546:	68 23 66 10 00       	push   $0x106623
  10454b:	e8 d0 c4 ff ff       	call   100a20 <panic>

00104550 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104550:	56                   	push   %esi
  104551:	53                   	push   %ebx
  104552:	89 c6                	mov    %eax,%esi
  104554:	89 d3                	mov    %edx,%ebx
  104556:	83 ec 1c             	sub    $0x1c,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  104559:	8d 44 24 14          	lea    0x14(%esp),%eax
  10455d:	50                   	push   %eax
  10455e:	6a 00                	push   $0x0
  104560:	e8 cb fc ff ff       	call   104230 <argint>
  104565:	83 c4 10             	add    $0x10,%esp
  104568:	85 c0                	test   %eax,%eax
  10456a:	78 3c                	js     1045a8 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
  10456c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104570:	83 f8 0f             	cmp    $0xf,%eax
  104573:	77 33                	ja     1045a8 <argfd.constprop.0+0x58>
  104575:	c7 c2 f8 ff ff ff    	mov    $0xfffffff8,%edx
  10457b:	65 8b 12             	mov    %gs:(%edx),%edx
  10457e:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
  104582:	85 d2                	test   %edx,%edx
  104584:	74 22                	je     1045a8 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
  104586:	85 f6                	test   %esi,%esi
  104588:	74 02                	je     10458c <argfd.constprop.0+0x3c>
    *pfd = fd;
  10458a:	89 06                	mov    %eax,(%esi)
  if(pf)
  10458c:	85 db                	test   %ebx,%ebx
  10458e:	74 10                	je     1045a0 <argfd.constprop.0+0x50>
    *pf = f;
  104590:	89 13                	mov    %edx,(%ebx)
  return 0;
  104592:	31 c0                	xor    %eax,%eax
}
  104594:	83 c4 14             	add    $0x14,%esp
  104597:	5b                   	pop    %ebx
  104598:	5e                   	pop    %esi
  104599:	c3                   	ret    
  10459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
  1045a0:	31 c0                	xor    %eax,%eax
  1045a2:	eb f0                	jmp    104594 <argfd.constprop.0+0x44>
  1045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  1045a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1045ad:	eb e5                	jmp    104594 <argfd.constprop.0+0x44>
  1045af:	90                   	nop

001045b0 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  1045b0:	83 ec 1c             	sub    $0x1c,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  1045b3:	31 c0                	xor    %eax,%eax
  1045b5:	8d 54 24 04          	lea    0x4(%esp),%edx
  1045b9:	e8 92 ff ff ff       	call   104550 <argfd.constprop.0>
  1045be:	85 c0                	test   %eax,%eax
  1045c0:	78 4e                	js     104610 <sys_read+0x60>
  1045c2:	83 ec 08             	sub    $0x8,%esp
  1045c5:	8d 44 24 10          	lea    0x10(%esp),%eax
  1045c9:	50                   	push   %eax
  1045ca:	6a 02                	push   $0x2
  1045cc:	e8 5f fc ff ff       	call   104230 <argint>
  1045d1:	83 c4 10             	add    $0x10,%esp
  1045d4:	85 c0                	test   %eax,%eax
  1045d6:	78 38                	js     104610 <sys_read+0x60>
  1045d8:	83 ec 04             	sub    $0x4,%esp
  1045db:	ff 74 24 0c          	pushl  0xc(%esp)
  1045df:	8d 44 24 14          	lea    0x14(%esp),%eax
  1045e3:	50                   	push   %eax
  1045e4:	6a 01                	push   $0x1
  1045e6:	e8 95 fc ff ff       	call   104280 <argptr>
  1045eb:	83 c4 10             	add    $0x10,%esp
  1045ee:	85 c0                	test   %eax,%eax
  1045f0:	78 1e                	js     104610 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
  1045f2:	83 ec 04             	sub    $0x4,%esp
  1045f5:	ff 74 24 0c          	pushl  0xc(%esp)
  1045f9:	ff 74 24 14          	pushl  0x14(%esp)
  1045fd:	ff 74 24 10          	pushl  0x10(%esp)
  104601:	e8 5a ca ff ff       	call   101060 <fileread>
  104606:	83 c4 10             	add    $0x10,%esp
}
  104609:	83 c4 1c             	add    $0x1c,%esp
  10460c:	c3                   	ret    
  10460d:	8d 76 00             	lea    0x0(%esi),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  104610:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
  104615:	83 c4 1c             	add    $0x1c,%esp
  104618:	c3                   	ret    
  104619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104620 <sys_write>:

int
sys_write(void)
{
  104620:	83 ec 1c             	sub    $0x1c,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104623:	31 c0                	xor    %eax,%eax
  104625:	8d 54 24 04          	lea    0x4(%esp),%edx
  104629:	e8 22 ff ff ff       	call   104550 <argfd.constprop.0>
  10462e:	85 c0                	test   %eax,%eax
  104630:	78 4e                	js     104680 <sys_write+0x60>
  104632:	83 ec 08             	sub    $0x8,%esp
  104635:	8d 44 24 10          	lea    0x10(%esp),%eax
  104639:	50                   	push   %eax
  10463a:	6a 02                	push   $0x2
  10463c:	e8 ef fb ff ff       	call   104230 <argint>
  104641:	83 c4 10             	add    $0x10,%esp
  104644:	85 c0                	test   %eax,%eax
  104646:	78 38                	js     104680 <sys_write+0x60>
  104648:	83 ec 04             	sub    $0x4,%esp
  10464b:	ff 74 24 0c          	pushl  0xc(%esp)
  10464f:	8d 44 24 14          	lea    0x14(%esp),%eax
  104653:	50                   	push   %eax
  104654:	6a 01                	push   $0x1
  104656:	e8 25 fc ff ff       	call   104280 <argptr>
  10465b:	83 c4 10             	add    $0x10,%esp
  10465e:	85 c0                	test   %eax,%eax
  104660:	78 1e                	js     104680 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
  104662:	83 ec 04             	sub    $0x4,%esp
  104665:	ff 74 24 0c          	pushl  0xc(%esp)
  104669:	ff 74 24 14          	pushl  0x14(%esp)
  10466d:	ff 74 24 10          	pushl  0x10(%esp)
  104671:	e8 7a ca ff ff       	call   1010f0 <filewrite>
  104676:	83 c4 10             	add    $0x10,%esp
}
  104679:	83 c4 1c             	add    $0x1c,%esp
  10467c:	c3                   	ret    
  10467d:	8d 76 00             	lea    0x0(%esi),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  104680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
  104685:	83 c4 1c             	add    $0x1c,%esp
  104688:	c3                   	ret    
  104689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104690 <sys_dup>:

int
sys_dup(void)
{
  104690:	53                   	push   %ebx
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104691:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  104693:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104696:	8d 54 24 0c          	lea    0xc(%esp),%edx
  10469a:	e8 b1 fe ff ff       	call   104550 <argfd.constprop.0>
  10469f:	85 c0                	test   %eax,%eax
  1046a1:	78 25                	js     1046c8 <sys_dup+0x38>
  1046a3:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
    return -1;
  if((fd=fdalloc(f)) < 0)
  1046a8:	8b 54 24 0c          	mov    0xc(%esp),%edx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  1046ac:	31 db                	xor    %ebx,%ebx
  1046ae:	65 8b 00             	mov    %gs:(%eax),%eax
  1046b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cp->ofile[fd] == 0){
  1046b8:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
  1046bc:	85 c9                	test   %ecx,%ecx
  1046be:	74 18                	je     1046d8 <sys_dup+0x48>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  1046c0:	83 c3 01             	add    $0x1,%ebx
  1046c3:	83 fb 10             	cmp    $0x10,%ebx
  1046c6:	75 f0                	jne    1046b8 <sys_dup+0x28>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
  1046c8:	83 c4 18             	add    $0x18,%esp
{
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  1046cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
  1046d0:	5b                   	pop    %ebx
  1046d1:	c3                   	ret    
  1046d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  1046d8:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  1046db:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  1046df:	52                   	push   %edx
  1046e0:	e8 1b c8 ff ff       	call   100f00 <filedup>
  return fd;
  1046e5:	83 c4 10             	add    $0x10,%esp
  1046e8:	89 d8                	mov    %ebx,%eax
}
  1046ea:	83 c4 18             	add    $0x18,%esp
  1046ed:	5b                   	pop    %ebx
  1046ee:	c3                   	ret    
  1046ef:	90                   	nop

001046f0 <sys_close>:

int
sys_close(void)
{
  1046f0:	83 ec 1c             	sub    $0x1c,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  1046f3:	8d 54 24 0c          	lea    0xc(%esp),%edx
  1046f7:	8d 44 24 08          	lea    0x8(%esp),%eax
  1046fb:	e8 50 fe ff ff       	call   104550 <argfd.constprop.0>
  104700:	85 c0                	test   %eax,%eax
  104702:	78 2c                	js     104730 <sys_close+0x40>
    return -1;
  cp->ofile[fd] = 0;
  104704:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  104709:	8b 54 24 08          	mov    0x8(%esp),%edx
  fileclose(f);
  10470d:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
    return -1;
  cp->ofile[fd] = 0;
  104710:	65 8b 00             	mov    %gs:(%eax),%eax
  104713:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
  10471a:	00 
  fileclose(f);
  10471b:	ff 74 24 18          	pushl  0x18(%esp)
  10471f:	e8 2c c8 ff ff       	call   100f50 <fileclose>
  return 0;
  104724:	83 c4 10             	add    $0x10,%esp
  104727:	31 c0                	xor    %eax,%eax
}
  104729:	83 c4 1c             	add    $0x1c,%esp
  10472c:	c3                   	ret    
  10472d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
    return -1;
  104730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104735:	eb f2                	jmp    104729 <sys_close+0x39>
  104737:	89 f6                	mov    %esi,%esi
  104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104740 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104740:	83 ec 1c             	sub    $0x1c,%esp
  struct file *f;
  struct statv6 *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104743:	31 c0                	xor    %eax,%eax
  104745:	8d 54 24 08          	lea    0x8(%esp),%edx
  104749:	e8 02 fe ff ff       	call   104550 <argfd.constprop.0>
  10474e:	85 c0                	test   %eax,%eax
  104750:	78 36                	js     104788 <sys_fstat+0x48>
  104752:	83 ec 04             	sub    $0x4,%esp
  104755:	6a 14                	push   $0x14
  104757:	8d 44 24 14          	lea    0x14(%esp),%eax
  10475b:	50                   	push   %eax
  10475c:	6a 01                	push   $0x1
  10475e:	e8 1d fb ff ff       	call   104280 <argptr>
  104763:	83 c4 10             	add    $0x10,%esp
  104766:	85 c0                	test   %eax,%eax
  104768:	78 1e                	js     104788 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
  10476a:	83 ec 08             	sub    $0x8,%esp
  10476d:	ff 74 24 14          	pushl  0x14(%esp)
  104771:	ff 74 24 14          	pushl  0x14(%esp)
  104775:	e8 96 c8 ff ff       	call   101010 <filestat>
  10477a:	83 c4 10             	add    $0x10,%esp
}
  10477d:	83 c4 1c             	add    $0x1c,%esp
  104780:	c3                   	ret    
  104781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  struct statv6 *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  104788:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10478d:	eb ee                	jmp    10477d <sys_fstat+0x3d>
  10478f:	90                   	nop

00104790 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104790:	57                   	push   %edi
  104791:	56                   	push   %esi
  104792:	53                   	push   %ebx
  104793:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104796:	8d 44 24 14          	lea    0x14(%esp),%eax
  10479a:	50                   	push   %eax
  10479b:	6a 00                	push   $0x0
  10479d:	e8 2e fb ff ff       	call   1042d0 <argstr>
  1047a2:	83 c4 10             	add    $0x10,%esp
  1047a5:	85 c0                	test   %eax,%eax
  1047a7:	0f 88 f0 00 00 00    	js     10489d <sys_link+0x10d>
  1047ad:	83 ec 08             	sub    $0x8,%esp
  1047b0:	8d 44 24 10          	lea    0x10(%esp),%eax
  1047b4:	50                   	push   %eax
  1047b5:	6a 01                	push   $0x1
  1047b7:	e8 14 fb ff ff       	call   1042d0 <argstr>
  1047bc:	83 c4 10             	add    $0x10,%esp
  1047bf:	85 c0                	test   %eax,%eax
  1047c1:	0f 88 d6 00 00 00    	js     10489d <sys_link+0x10d>
    return -1;
  if((ip = namei(old)) == 0)
  1047c7:	83 ec 0c             	sub    $0xc,%esp
  1047ca:	ff 74 24 18          	pushl  0x18(%esp)
  1047ce:	e8 4d d7 ff ff       	call   101f20 <namei>
  1047d3:	83 c4 10             	add    $0x10,%esp
  1047d6:	85 c0                	test   %eax,%eax
  1047d8:	89 c3                	mov    %eax,%ebx
  1047da:	0f 84 bd 00 00 00    	je     10489d <sys_link+0x10d>
    return -1;
  ilock(ip);
  1047e0:	83 ec 0c             	sub    $0xc,%esp
  1047e3:	50                   	push   %eax
  1047e4:	e8 17 cd ff ff       	call   101500 <ilock>
  if(ip->type == T_DIR){
  1047e9:	83 c4 10             	add    $0x10,%esp
  1047ec:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1047f1:	0f 84 b9 00 00 00    	je     1048b0 <sys_link+0x120>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  1047f7:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  1047fc:	83 ec 0c             	sub    $0xc,%esp
  1047ff:	53                   	push   %ebx
  104800:	e8 1b cf ff ff       	call   101720 <iupdate>
  iunlock(ip);
  104805:	89 1c 24             	mov    %ebx,(%esp)
  104808:	e8 03 ce ff ff       	call   101610 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  10480d:	58                   	pop    %eax
  10480e:	5a                   	pop    %edx
  10480f:	8d 7c 24 1a          	lea    0x1a(%esp),%edi
  104813:	57                   	push   %edi
  104814:	ff 74 24 14          	pushl  0x14(%esp)
  104818:	e8 23 d7 ff ff       	call   101f40 <nameiparent>
  10481d:	83 c4 10             	add    $0x10,%esp
  104820:	85 c0                	test   %eax,%eax
  104822:	89 c6                	mov    %eax,%esi
  104824:	74 56                	je     10487c <sys_link+0xec>
    goto bad;
  ilock(dp);
  104826:	83 ec 0c             	sub    $0xc,%esp
  104829:	50                   	push   %eax
  10482a:	e8 d1 cc ff ff       	call   101500 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
  10482f:	83 c4 10             	add    $0x10,%esp
  104832:	8b 03                	mov    (%ebx),%eax
  104834:	39 06                	cmp    %eax,(%esi)
  104836:	75 38                	jne    104870 <sys_link+0xe0>
  104838:	83 ec 04             	sub    $0x4,%esp
  10483b:	ff 73 04             	pushl  0x4(%ebx)
  10483e:	57                   	push   %edi
  10483f:	56                   	push   %esi
  104840:	e8 1b d6 ff ff       	call   101e60 <dirlink>
  104845:	83 c4 10             	add    $0x10,%esp
  104848:	85 c0                	test   %eax,%eax
  10484a:	78 24                	js     104870 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  10484c:	83 ec 0c             	sub    $0xc,%esp
  10484f:	56                   	push   %esi
  104850:	e8 ab d0 ff ff       	call   101900 <iunlockput>
  iput(ip);
  104855:	89 1c 24             	mov    %ebx,(%esp)
  104858:	e8 43 cf ff ff       	call   1017a0 <iput>
  return 0;
  10485d:	83 c4 10             	add    $0x10,%esp
  104860:	31 c0                	xor    %eax,%eax
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
}
  104862:	83 c4 20             	add    $0x20,%esp
  104865:	5b                   	pop    %ebx
  104866:	5e                   	pop    %esi
  104867:	5f                   	pop    %edi
  104868:	c3                   	ret    
  104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
  104870:	83 ec 0c             	sub    $0xc,%esp
  104873:	56                   	push   %esi
  104874:	e8 87 d0 ff ff       	call   101900 <iunlockput>
    goto bad;
  104879:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
  iput(ip);
  return 0;

bad:
  ilock(ip);
  10487c:	83 ec 0c             	sub    $0xc,%esp
  10487f:	53                   	push   %ebx
  104880:	e8 7b cc ff ff       	call   101500 <ilock>
  ip->nlink--;
  104885:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  10488a:	89 1c 24             	mov    %ebx,(%esp)
  10488d:	e8 8e ce ff ff       	call   101720 <iupdate>
  iunlockput(ip);
  104892:	89 1c 24             	mov    %ebx,(%esp)
  104895:	e8 66 d0 ff ff       	call   101900 <iunlockput>
  return -1;
  10489a:	83 c4 10             	add    $0x10,%esp
}
  10489d:	83 c4 20             	add    $0x20,%esp
bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  1048a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1048a5:	5b                   	pop    %ebx
  1048a6:	5e                   	pop    %esi
  1048a7:	5f                   	pop    %edi
  1048a8:	c3                   	ret    
  1048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if((ip = namei(old)) == 0)
    return -1;
  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
  1048b0:	83 ec 0c             	sub    $0xc,%esp
  1048b3:	53                   	push   %ebx
  1048b4:	e8 47 d0 ff ff       	call   101900 <iunlockput>
    return -1;
  1048b9:	83 c4 10             	add    $0x10,%esp
  1048bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1048c1:	eb 9f                	jmp    104862 <sys_link+0xd2>
  1048c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001048d0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
  1048d0:	55                   	push   %ebp
  1048d1:	57                   	push   %edi
  1048d2:	56                   	push   %esi
  1048d3:	53                   	push   %ebx
  1048d4:	83 ec 44             	sub    $0x44,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  1048d7:	8d 44 24 10          	lea    0x10(%esp),%eax
  1048db:	50                   	push   %eax
  1048dc:	6a 00                	push   $0x0
  1048de:	e8 ed f9 ff ff       	call   1042d0 <argstr>
  1048e3:	83 c4 10             	add    $0x10,%esp
  1048e6:	85 c0                	test   %eax,%eax
  1048e8:	0f 88 38 01 00 00    	js     104a26 <sys_unlink+0x156>
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  1048ee:	83 ec 08             	sub    $0x8,%esp
  1048f1:	8d 5c 24 1a          	lea    0x1a(%esp),%ebx
  1048f5:	53                   	push   %ebx
  1048f6:	ff 74 24 14          	pushl  0x14(%esp)
  1048fa:	e8 41 d6 ff ff       	call   101f40 <nameiparent>
  1048ff:	83 c4 10             	add    $0x10,%esp
  104902:	85 c0                	test   %eax,%eax
  104904:	89 c5                	mov    %eax,%ebp
  104906:	0f 84 1a 01 00 00    	je     104a26 <sys_unlink+0x156>
    return -1;
  ilock(dp);
  10490c:	83 ec 0c             	sub    $0xc,%esp
  10490f:	50                   	push   %eax
  104910:	e8 eb cb ff ff       	call   101500 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104915:	58                   	pop    %eax
  104916:	5a                   	pop    %edx
  104917:	68 21 66 10 00       	push   $0x106621
  10491c:	53                   	push   %ebx
  10491d:	e8 7e d2 ff ff       	call   101ba0 <namecmp>
  104922:	83 c4 10             	add    $0x10,%esp
  104925:	85 c0                	test   %eax,%eax
  104927:	0f 84 0b 01 00 00    	je     104a38 <sys_unlink+0x168>
  10492d:	83 ec 08             	sub    $0x8,%esp
  104930:	68 20 66 10 00       	push   $0x106620
  104935:	53                   	push   %ebx
  104936:	e8 65 d2 ff ff       	call   101ba0 <namecmp>
  10493b:	83 c4 10             	add    $0x10,%esp
  10493e:	85 c0                	test   %eax,%eax
  104940:	0f 84 f2 00 00 00    	je     104a38 <sys_unlink+0x168>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104946:	83 ec 04             	sub    $0x4,%esp
  104949:	8d 44 24 10          	lea    0x10(%esp),%eax
  10494d:	50                   	push   %eax
  10494e:	53                   	push   %ebx
  10494f:	55                   	push   %ebp
  104950:	e8 6b d2 ff ff       	call   101bc0 <dirlookup>
  104955:	83 c4 10             	add    $0x10,%esp
  104958:	85 c0                	test   %eax,%eax
  10495a:	89 c3                	mov    %eax,%ebx
  10495c:	0f 84 d6 00 00 00    	je     104a38 <sys_unlink+0x168>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104962:	83 ec 0c             	sub    $0xc,%esp
  104965:	50                   	push   %eax
  104966:	e8 95 cb ff ff       	call   101500 <ilock>

  if(ip->nlink < 1)
  10496b:	83 c4 10             	add    $0x10,%esp
  10496e:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
  104973:	0f 8e 0f 01 00 00    	jle    104a88 <sys_unlink+0x1b8>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104979:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10497e:	8d 7c 24 20          	lea    0x20(%esp),%edi
  104982:	74 5c                	je     1049e0 <sys_unlink+0x110>
    iunlockput(ip);
    iunlockput(dp);
    return -1;
  }

  memset(&de, 0, sizeof(de));
  104984:	83 ec 04             	sub    $0x4,%esp
  104987:	6a 10                	push   $0x10
  104989:	6a 00                	push   $0x0
  10498b:	57                   	push   %edi
  10498c:	e8 df f5 ff ff       	call   103f70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104991:	6a 10                	push   $0x10
  104993:	ff 74 24 20          	pushl  0x20(%esp)
  104997:	57                   	push   %edi
  104998:	55                   	push   %ebp
  104999:	e8 c2 d0 ff ff       	call   101a60 <writei>
  10499e:	83 c4 20             	add    $0x20,%esp
  1049a1:	83 f8 10             	cmp    $0x10,%eax
  1049a4:	0f 85 d1 00 00 00    	jne    104a7b <sys_unlink+0x1ab>
    panic("unlink: writei");
  if(ip->type == T_DIR){
  1049aa:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1049af:	0f 84 a3 00 00 00    	je     104a58 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
  1049b5:	83 ec 0c             	sub    $0xc,%esp
  1049b8:	55                   	push   %ebp
  1049b9:	e8 42 cf ff ff       	call   101900 <iunlockput>

  ip->nlink--;
  1049be:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  1049c3:	89 1c 24             	mov    %ebx,(%esp)
  1049c6:	e8 55 cd ff ff       	call   101720 <iupdate>
  iunlockput(ip);
  1049cb:	89 1c 24             	mov    %ebx,(%esp)
  1049ce:	e8 2d cf ff ff       	call   101900 <iunlockput>
  return 0;
  1049d3:	83 c4 10             	add    $0x10,%esp
  1049d6:	31 c0                	xor    %eax,%eax
}
  1049d8:	83 c4 3c             	add    $0x3c,%esp
  1049db:	5b                   	pop    %ebx
  1049dc:	5e                   	pop    %esi
  1049dd:	5f                   	pop    %edi
  1049de:	5d                   	pop    %ebp
  1049df:	c3                   	ret    
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  1049e0:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
  1049e4:	76 9e                	jbe    104984 <sys_unlink+0xb4>
  1049e6:	be 20 00 00 00       	mov    $0x20,%esi
  1049eb:	eb 0b                	jmp    1049f8 <sys_unlink+0x128>
  1049ed:	8d 76 00             	lea    0x0(%esi),%esi
  1049f0:	83 c6 10             	add    $0x10,%esi
  1049f3:	3b 73 18             	cmp    0x18(%ebx),%esi
  1049f6:	73 8c                	jae    104984 <sys_unlink+0xb4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  1049f8:	6a 10                	push   $0x10
  1049fa:	56                   	push   %esi
  1049fb:	57                   	push   %edi
  1049fc:	53                   	push   %ebx
  1049fd:	e8 4e cf ff ff       	call   101950 <readi>
  104a02:	83 c4 10             	add    $0x10,%esp
  104a05:	83 f8 10             	cmp    $0x10,%eax
  104a08:	75 64                	jne    104a6e <sys_unlink+0x19e>
      panic("isdirempty: readi");
    if(de.inum != 0)
  104a0a:	66 83 7c 24 20 00    	cmpw   $0x0,0x20(%esp)
  104a10:	74 de                	je     1049f0 <sys_unlink+0x120>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104a12:	83 ec 0c             	sub    $0xc,%esp
  104a15:	53                   	push   %ebx
  104a16:	e8 e5 ce ff ff       	call   101900 <iunlockput>
    iunlockput(dp);
  104a1b:	89 2c 24             	mov    %ebp,(%esp)
  104a1e:	e8 dd ce ff ff       	call   101900 <iunlockput>
    return -1;
  104a23:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  104a26:	83 c4 3c             	add    $0x3c,%esp
  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    iunlockput(dp);
    return -1;
  104a29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  104a2e:	5b                   	pop    %ebx
  104a2f:	5e                   	pop    %esi
  104a30:	5f                   	pop    %edi
  104a31:	5d                   	pop    %ebp
  104a32:	c3                   	ret    
  104a33:	90                   	nop
  104a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
    iunlockput(dp);
  104a38:	83 ec 0c             	sub    $0xc,%esp
  104a3b:	55                   	push   %ebp
  104a3c:	e8 bf ce ff ff       	call   101900 <iunlockput>
    return -1;
  104a41:	83 c4 10             	add    $0x10,%esp
  104a44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
}
  104a49:	83 c4 3c             	add    $0x3c,%esp
  104a4c:	5b                   	pop    %ebx
  104a4d:	5e                   	pop    %esi
  104a4e:	5f                   	pop    %edi
  104a4f:	5d                   	pop    %ebp
  104a50:	c3                   	ret    
  104a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
  104a58:	66 83 6d 16 01       	subw   $0x1,0x16(%ebp)
    iupdate(dp);
  104a5d:	83 ec 0c             	sub    $0xc,%esp
  104a60:	55                   	push   %ebp
  104a61:	e8 ba cc ff ff       	call   101720 <iupdate>
  104a66:	83 c4 10             	add    $0x10,%esp
  104a69:	e9 47 ff ff ff       	jmp    1049b5 <sys_unlink+0xe5>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  104a6e:	83 ec 0c             	sub    $0xc,%esp
  104a71:	68 45 66 10 00       	push   $0x106645
  104a76:	e8 a5 bf ff ff       	call   100a20 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104a7b:	83 ec 0c             	sub    $0xc,%esp
  104a7e:	68 57 66 10 00       	push   $0x106657
  104a83:	e8 98 bf ff ff       	call   100a20 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104a88:	83 ec 0c             	sub    $0xc,%esp
  104a8b:	68 33 66 10 00       	push   $0x106633
  104a90:	e8 8b bf ff ff       	call   100a20 <panic>
  104a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104aa0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104aa0:	57                   	push   %edi
  104aa1:	56                   	push   %esi
  104aa2:	53                   	push   %ebx
  104aa3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104aa6:	8d 44 24 10          	lea    0x10(%esp),%eax
  104aaa:	50                   	push   %eax
  104aab:	6a 00                	push   $0x0
  104aad:	e8 1e f8 ff ff       	call   1042d0 <argstr>
  104ab2:	83 c4 10             	add    $0x10,%esp
  104ab5:	85 c0                	test   %eax,%eax
  104ab7:	0f 88 8b 00 00 00    	js     104b48 <sys_open+0xa8>
  104abd:	83 ec 08             	sub    $0x8,%esp
  104ac0:	8d 44 24 14          	lea    0x14(%esp),%eax
  104ac4:	50                   	push   %eax
  104ac5:	6a 01                	push   $0x1
  104ac7:	e8 64 f7 ff ff       	call   104230 <argint>
  104acc:	83 c4 10             	add    $0x10,%esp
  104acf:	85 c0                	test   %eax,%eax
  104ad1:	78 75                	js     104b48 <sys_open+0xa8>
    return -1;

  if(omode & O_CREATE){
  104ad3:	f6 44 24 0d 02       	testb  $0x2,0xd(%esp)
  104ad8:	75 7e                	jne    104b58 <sys_open+0xb8>
    if((ip = create(path, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104ada:	83 ec 0c             	sub    $0xc,%esp
  104add:	ff 74 24 14          	pushl  0x14(%esp)
  104ae1:	e8 3a d4 ff ff       	call   101f20 <namei>
  104ae6:	83 c4 10             	add    $0x10,%esp
  104ae9:	85 c0                	test   %eax,%eax
  104aeb:	89 c7                	mov    %eax,%edi
  104aed:	74 59                	je     104b48 <sys_open+0xa8>
      return -1;
    ilock(ip);
  104aef:	83 ec 0c             	sub    $0xc,%esp
  104af2:	50                   	push   %eax
  104af3:	e8 08 ca ff ff       	call   101500 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
  104af8:	83 c4 10             	add    $0x10,%esp
  104afb:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  104b00:	0f 84 ba 00 00 00    	je     104bc0 <sys_open+0x120>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104b06:	e8 85 c3 ff ff       	call   100e90 <filealloc>
  104b0b:	85 c0                	test   %eax,%eax
  104b0d:	89 c6                	mov    %eax,%esi
  104b0f:	74 2b                	je     104b3c <sys_open+0x9c>
  104b11:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  104b16:	31 db                	xor    %ebx,%ebx
  104b18:	65 8b 10             	mov    %gs:(%eax),%edx
  104b1b:	90                   	nop
  104b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
  104b20:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
  104b24:	85 c0                	test   %eax,%eax
  104b26:	74 58                	je     104b80 <sys_open+0xe0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104b28:	83 c3 01             	add    $0x1,%ebx
  104b2b:	83 fb 10             	cmp    $0x10,%ebx
  104b2e:	75 f0                	jne    104b20 <sys_open+0x80>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104b30:	83 ec 0c             	sub    $0xc,%esp
  104b33:	56                   	push   %esi
  104b34:	e8 17 c4 ff ff       	call   100f50 <fileclose>
  104b39:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
  104b3c:	83 ec 0c             	sub    $0xc,%esp
  104b3f:	57                   	push   %edi
  104b40:	e8 bb cd ff ff       	call   101900 <iunlockput>
    return -1;
  104b45:	83 c4 10             	add    $0x10,%esp
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
}
  104b48:	83 c4 10             	add    $0x10,%esp

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  104b4b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
}
  104b50:	5b                   	pop    %ebx
  104b51:	5e                   	pop    %esi
  104b52:	5f                   	pop    %edi
  104b53:	c3                   	ret    
  104b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  if(omode & O_CREATE){
    if((ip = create(path, T_FILE, 0, 0)) == 0)
  104b58:	83 ec 0c             	sub    $0xc,%esp
  104b5b:	31 c9                	xor    %ecx,%ecx
  104b5d:	ba 02 00 00 00       	mov    $0x2,%edx
  104b62:	6a 00                	push   $0x0
  104b64:	8b 44 24 18          	mov    0x18(%esp),%eax
  104b68:	e8 43 f8 ff ff       	call   1043b0 <create>
  104b6d:	83 c4 10             	add    $0x10,%esp
  104b70:	85 c0                	test   %eax,%eax
  104b72:	89 c7                	mov    %eax,%edi
  104b74:	75 90                	jne    104b06 <sys_open+0x66>
  104b76:	eb d0                	jmp    104b48 <sys_open+0xa8>
  104b78:	90                   	nop
  104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104b80:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  104b83:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104b87:	57                   	push   %edi
  104b88:	e8 83 ca ff ff       	call   101610 <iunlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104b8d:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104b91:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  104b94:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  104b9a:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
  104b9d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
  104ba4:	89 d0                	mov    %edx,%eax
  104ba6:	83 e0 01             	and    $0x1,%eax
  104ba9:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104bac:	83 e2 03             	and    $0x3,%edx
  iunlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104baf:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104bb2:	0f 95 46 09          	setne  0x9(%esi)

  return fd;
}
  104bb6:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
  104bb9:	89 d8                	mov    %ebx,%eax
}
  104bbb:	5b                   	pop    %ebx
  104bbc:	5e                   	pop    %esi
  104bbd:	5f                   	pop    %edi
  104bbe:	c3                   	ret    
  104bbf:	90                   	nop
      return -1;
  } else {
    if((ip = namei(path)) == 0)
      return -1;
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
  104bc0:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104bc4:	85 d2                	test   %edx,%edx
  104bc6:	0f 84 3a ff ff ff    	je     104b06 <sys_open+0x66>
  104bcc:	e9 6b ff ff ff       	jmp    104b3c <sys_open+0x9c>
  104bd1:	eb 0d                	jmp    104be0 <sys_mknod>
  104bd3:	90                   	nop
  104bd4:	90                   	nop
  104bd5:	90                   	nop
  104bd6:	90                   	nop
  104bd7:	90                   	nop
  104bd8:	90                   	nop
  104bd9:	90                   	nop
  104bda:	90                   	nop
  104bdb:	90                   	nop
  104bdc:	90                   	nop
  104bdd:	90                   	nop
  104bde:	90                   	nop
  104bdf:	90                   	nop

00104be0 <sys_mknod>:
  return fd;
}

int
sys_mknod(void)
{
  104be0:	83 ec 24             	sub    $0x24,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104be3:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104be7:	50                   	push   %eax
  104be8:	6a 00                	push   $0x0
  104bea:	e8 e1 f6 ff ff       	call   1042d0 <argstr>
  104bef:	83 c4 10             	add    $0x10,%esp
  104bf2:	85 c0                	test   %eax,%eax
  104bf4:	78 6a                	js     104c60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
  104bf6:	83 ec 08             	sub    $0x8,%esp
  104bf9:	8d 44 24 10          	lea    0x10(%esp),%eax
  104bfd:	50                   	push   %eax
  104bfe:	6a 01                	push   $0x1
  104c00:	e8 2b f6 ff ff       	call   104230 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104c05:	83 c4 10             	add    $0x10,%esp
  104c08:	85 c0                	test   %eax,%eax
  104c0a:	78 54                	js     104c60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104c0c:	83 ec 08             	sub    $0x8,%esp
  104c0f:	8d 44 24 14          	lea    0x14(%esp),%eax
  104c13:	50                   	push   %eax
  104c14:	6a 02                	push   $0x2
  104c16:	e8 15 f6 ff ff       	call   104230 <argint>
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  104c1b:	83 c4 10             	add    $0x10,%esp
  104c1e:	85 c0                	test   %eax,%eax
  104c20:	78 3e                	js     104c60 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
  104c22:	0f bf 4c 24 08       	movswl 0x8(%esp),%ecx
  104c27:	83 ec 0c             	sub    $0xc,%esp
  104c2a:	ba 03 00 00 00       	mov    $0x3,%edx
  104c2f:	0f bf 44 24 18       	movswl 0x18(%esp),%eax
  104c34:	50                   	push   %eax
  104c35:	8b 44 24 14          	mov    0x14(%esp),%eax
  104c39:	e8 72 f7 ff ff       	call   1043b0 <create>
  104c3e:	83 c4 10             	add    $0x10,%esp
  104c41:	85 c0                	test   %eax,%eax
  104c43:	74 1b                	je     104c60 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104c45:	83 ec 0c             	sub    $0xc,%esp
  104c48:	50                   	push   %eax
  104c49:	e8 b2 cc ff ff       	call   101900 <iunlockput>
  return 0;
  104c4e:	83 c4 10             	add    $0x10,%esp
  104c51:	31 c0                	xor    %eax,%eax
}
  104c53:	83 c4 1c             	add    $0x1c,%esp
  104c56:	c3                   	ret    
  104c57:	89 f6                	mov    %esi,%esi
  104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0)
    return -1;
  104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlockput(ip);
  return 0;
}
  104c65:	83 c4 1c             	add    $0x1c,%esp
  104c68:	c3                   	ret    
  104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c70 <sys_mkdir>:

int
sys_mkdir(void)
{
  104c70:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
  104c73:	8d 44 24 14          	lea    0x14(%esp),%eax
  104c77:	50                   	push   %eax
  104c78:	6a 00                	push   $0x0
  104c7a:	e8 51 f6 ff ff       	call   1042d0 <argstr>
  104c7f:	83 c4 10             	add    $0x10,%esp
  104c82:	85 c0                	test   %eax,%eax
  104c84:	78 32                	js     104cb8 <sys_mkdir+0x48>
  104c86:	83 ec 0c             	sub    $0xc,%esp
  104c89:	31 c9                	xor    %ecx,%ecx
  104c8b:	ba 01 00 00 00       	mov    $0x1,%edx
  104c90:	6a 00                	push   $0x0
  104c92:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  104c96:	e8 15 f7 ff ff       	call   1043b0 <create>
  104c9b:	83 c4 10             	add    $0x10,%esp
  104c9e:	85 c0                	test   %eax,%eax
  104ca0:	74 16                	je     104cb8 <sys_mkdir+0x48>
    return -1;
  iunlockput(ip);
  104ca2:	83 ec 0c             	sub    $0xc,%esp
  104ca5:	50                   	push   %eax
  104ca6:	e8 55 cc ff ff       	call   101900 <iunlockput>
  return 0;
  104cab:	83 c4 10             	add    $0x10,%esp
  104cae:	31 c0                	xor    %eax,%eax
}
  104cb0:	83 c4 1c             	add    $0x1c,%esp
  104cb3:	c3                   	ret    
  104cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0)
    return -1;
  104cb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104cbd:	eb f1                	jmp    104cb0 <sys_mkdir+0x40>
  104cbf:	90                   	nop

00104cc0 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  104cc0:	56                   	push   %esi
  104cc1:	53                   	push   %ebx
  104cc2:	83 ec 1c             	sub    $0x1c,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104cc5:	8d 44 24 14          	lea    0x14(%esp),%eax
  104cc9:	50                   	push   %eax
  104cca:	6a 00                	push   $0x0
  104ccc:	e8 ff f5 ff ff       	call   1042d0 <argstr>
  104cd1:	83 c4 10             	add    $0x10,%esp
  104cd4:	85 c0                	test   %eax,%eax
  104cd6:	78 64                	js     104d3c <sys_chdir+0x7c>
  104cd8:	83 ec 0c             	sub    $0xc,%esp
  104cdb:	ff 74 24 18          	pushl  0x18(%esp)
  104cdf:	e8 3c d2 ff ff       	call   101f20 <namei>
  104ce4:	83 c4 10             	add    $0x10,%esp
  104ce7:	85 c0                	test   %eax,%eax
  104ce9:	89 c3                	mov    %eax,%ebx
  104ceb:	74 4f                	je     104d3c <sys_chdir+0x7c>
    return -1;
  ilock(ip);
  104ced:	83 ec 0c             	sub    $0xc,%esp
  104cf0:	50                   	push   %eax
  104cf1:	e8 0a c8 ff ff       	call   101500 <ilock>
  if(ip->type != T_DIR){
  104cf6:	83 c4 10             	add    $0x10,%esp
  104cf9:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  104cfe:	75 30                	jne    104d30 <sys_chdir+0x70>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104d00:	83 ec 0c             	sub    $0xc,%esp
  104d03:	53                   	push   %ebx
  104d04:	e8 07 c9 ff ff       	call   101610 <iunlock>
  iput(cp->cwd);
  104d09:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  104d0f:	58                   	pop    %eax
  104d10:	65 8b 06             	mov    %gs:(%esi),%eax
  104d13:	ff 70 68             	pushl  0x68(%eax)
  104d16:	e8 85 ca ff ff       	call   1017a0 <iput>
  cp->cwd = ip;
  104d1b:	65 8b 06             	mov    %gs:(%esi),%eax
  return 0;
  104d1e:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  104d21:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
}
  104d24:	83 c4 14             	add    $0x14,%esp
    return -1;
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
  104d27:	31 c0                	xor    %eax,%eax
}
  104d29:	5b                   	pop    %ebx
  104d2a:	5e                   	pop    %esi
  104d2b:	c3                   	ret    
  104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104d30:	83 ec 0c             	sub    $0xc,%esp
  104d33:	53                   	push   %ebx
  104d34:	e8 c7 cb ff ff       	call   101900 <iunlockput>
    return -1;
  104d39:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
}
  104d3c:	83 c4 14             	add    $0x14,%esp
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    return -1;
  104d3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
}
  104d44:	5b                   	pop    %ebx
  104d45:	5e                   	pop    %esi
  104d46:	c3                   	ret    
  104d47:	89 f6                	mov    %esi,%esi
  104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104d50 <sys_exec>:

int
sys_exec(void)
{
  104d50:	55                   	push   %ebp
  104d51:	57                   	push   %edi
  104d52:	56                   	push   %esi
  104d53:	53                   	push   %ebx
  104d54:	83 ec 74             	sub    $0x74,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  104d57:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104d5b:	50                   	push   %eax
  104d5c:	6a 00                	push   $0x0
  104d5e:	e8 6d f5 ff ff       	call   1042d0 <argstr>
  104d63:	83 c4 10             	add    $0x10,%esp
  104d66:	85 c0                	test   %eax,%eax
  104d68:	0f 88 84 00 00 00    	js     104df2 <sys_exec+0xa2>
  104d6e:	83 ec 08             	sub    $0x8,%esp
  104d71:	8d 44 24 10          	lea    0x10(%esp),%eax
  104d75:	50                   	push   %eax
  104d76:	6a 01                	push   $0x1
  104d78:	e8 b3 f4 ff ff       	call   104230 <argint>
  104d7d:	83 c4 10             	add    $0x10,%esp
  104d80:	85 c0                	test   %eax,%eax
  104d82:	78 6e                	js     104df2 <sys_exec+0xa2>
    return -1;
  memset(argv, 0, sizeof(argv));
  104d84:	83 ec 04             	sub    $0x4,%esp
  104d87:	31 db                	xor    %ebx,%ebx
  104d89:	6a 50                	push   $0x50
  104d8b:	6a 00                	push   $0x0
  104d8d:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  104d91:	50                   	push   %eax
  104d92:	e8 d9 f1 ff ff       	call   103f70 <memset>
  104d97:	8d 74 24 20          	lea    0x20(%esp),%esi
  104d9b:	c7 c7 f8 ff ff ff    	mov    $0xfffffff8,%edi
  104da1:	83 c4 10             	add    $0x10,%esp
  104da4:	8d 6c 24 0c          	lea    0xc(%esp),%ebp
  104da8:	90                   	nop
  104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
  104db0:	83 ec 04             	sub    $0x4,%esp
  104db3:	55                   	push   %ebp
  104db4:	8b 44 24 10          	mov    0x10(%esp),%eax
  104db8:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  104dbb:	50                   	push   %eax
  104dbc:	65 ff 37             	pushl  %gs:(%edi)
  104dbf:	e8 dc f3 ff ff       	call   1041a0 <fetchint>
  104dc4:	83 c4 10             	add    $0x10,%esp
  104dc7:	85 c0                	test   %eax,%eax
  104dc9:	78 27                	js     104df2 <sys_exec+0xa2>
      return -1;
    if(uarg == 0){
  104dcb:	8b 44 24 0c          	mov    0xc(%esp),%eax
  104dcf:	85 c0                	test   %eax,%eax
  104dd1:	74 2d                	je     104e00 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
  104dd3:	83 ec 04             	sub    $0x4,%esp
  104dd6:	56                   	push   %esi
  104dd7:	50                   	push   %eax
  104dd8:	65 ff 37             	pushl  %gs:(%edi)
  104ddb:	e8 00 f4 ff ff       	call   1041e0 <fetchstr>
  104de0:	83 c4 10             	add    $0x10,%esp
  104de3:	85 c0                	test   %eax,%eax
  104de5:	78 0b                	js     104df2 <sys_exec+0xa2>
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104de7:	83 c3 01             	add    $0x1,%ebx
  104dea:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
  104ded:	83 fb 14             	cmp    $0x14,%ebx
  104df0:	75 be                	jne    104db0 <sys_exec+0x60>
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  104df2:	83 c4 6c             	add    $0x6c,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  104df5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  104dfa:	5b                   	pop    %ebx
  104dfb:	5e                   	pop    %esi
  104dfc:	5f                   	pop    %edi
  104dfd:	5d                   	pop    %ebp
  104dfe:	c3                   	ret    
  104dff:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  104e00:	c7 44 9c 10 00 00 00 	movl   $0x0,0x10(%esp,%ebx,4)
  104e07:	00 
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104e08:	83 ec 08             	sub    $0x8,%esp
  104e0b:	8d 44 24 18          	lea    0x18(%esp),%eax
  104e0f:	50                   	push   %eax
  104e10:	ff 74 24 10          	pushl  0x10(%esp)
  104e14:	e8 87 bc ff ff       	call   100aa0 <exec>
  104e19:	83 c4 10             	add    $0x10,%esp
}
  104e1c:	83 c4 6c             	add    $0x6c,%esp
  104e1f:	5b                   	pop    %ebx
  104e20:	5e                   	pop    %esi
  104e21:	5f                   	pop    %edi
  104e22:	5d                   	pop    %ebp
  104e23:	c3                   	ret    
  104e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104e30 <sys_pipe>:

int
sys_pipe(void)
{
  104e30:	57                   	push   %edi
  104e31:	56                   	push   %esi
  104e32:	53                   	push   %ebx
  104e33:	83 ec 14             	sub    $0x14,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  104e36:	6a 08                	push   $0x8
  104e38:	8d 44 24 0c          	lea    0xc(%esp),%eax
  104e3c:	50                   	push   %eax
  104e3d:	6a 00                	push   $0x0
  104e3f:	e8 3c f4 ff ff       	call   104280 <argptr>
  104e44:	83 c4 10             	add    $0x10,%esp
  104e47:	85 c0                	test   %eax,%eax
  104e49:	78 53                	js     104e9e <sys_pipe+0x6e>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  104e4b:	83 ec 08             	sub    $0x8,%esp
  104e4e:	8d 44 24 14          	lea    0x14(%esp),%eax
  104e52:	50                   	push   %eax
  104e53:	8d 44 24 14          	lea    0x14(%esp),%eax
  104e57:	50                   	push   %eax
  104e58:	e8 f3 de ff ff       	call   102d50 <pipealloc>
  104e5d:	83 c4 10             	add    $0x10,%esp
  104e60:	85 c0                	test   %eax,%eax
  104e62:	78 3a                	js     104e9e <sys_pipe+0x6e>
  104e64:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  104e69:	8b 5c 24 08          	mov    0x8(%esp),%ebx
  104e6d:	65 8b 08             	mov    %gs:(%eax),%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104e70:	31 c0                	xor    %eax,%eax
  104e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(cp->ofile[fd] == 0){
  104e78:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
  104e7c:	85 d2                	test   %edx,%edx
  104e7e:	74 28                	je     104ea8 <sys_pipe+0x78>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104e80:	83 c0 01             	add    $0x1,%eax
  104e83:	83 f8 10             	cmp    $0x10,%eax
  104e86:	75 f0                	jne    104e78 <sys_pipe+0x48>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
    fileclose(rf);
  104e88:	83 ec 0c             	sub    $0xc,%esp
  104e8b:	53                   	push   %ebx
  104e8c:	e8 bf c0 ff ff       	call   100f50 <fileclose>
    fileclose(wf);
  104e91:	58                   	pop    %eax
  104e92:	ff 74 24 18          	pushl  0x18(%esp)
  104e96:	e8 b5 c0 ff ff       	call   100f50 <fileclose>
    return -1;
  104e9b:	83 c4 10             	add    $0x10,%esp
  104e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104ea3:	eb 3a                	jmp    104edf <sys_pipe+0xaf>
  104ea5:	8d 76 00             	lea    0x0(%esi),%esi
  104ea8:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  104eab:	8b 7c 24 0c          	mov    0xc(%esp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104eaf:	31 d2                	xor    %edx,%edx
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  104eb1:	89 5e 28             	mov    %ebx,0x28(%esi)
  104eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
  104eb8:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
  104ebd:	74 11                	je     104ed0 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  104ebf:	83 c2 01             	add    $0x1,%edx
  104ec2:	83 fa 10             	cmp    $0x10,%edx
  104ec5:	75 f1                	jne    104eb8 <sys_pipe+0x88>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
  104ec7:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
  104ece:	eb b8                	jmp    104e88 <sys_pipe+0x58>
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  104ed0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  104ed4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104ed8:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
  104eda:	89 51 04             	mov    %edx,0x4(%ecx)
  return 0;
  104edd:	31 c0                	xor    %eax,%eax
}
  104edf:	83 c4 10             	add    $0x10,%esp
  104ee2:	5b                   	pop    %ebx
  104ee3:	5e                   	pop    %esi
  104ee4:	5f                   	pop    %edi
  104ee5:	c3                   	ret    
  104ee6:	66 90                	xchg   %ax,%ax
  104ee8:	66 90                	xchg   %ax,%ax
  104eea:	66 90                	xchg   %ax,%ax
  104eec:	66 90                	xchg   %ax,%ax
  104eee:	66 90                	xchg   %ax,%ax

00104ef0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
  104ef0:	e9 7b e6 ff ff       	jmp    103570 <fork>
  104ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f00 <sys_exit>:
}

int
sys_exit(void)
{
  104f00:	83 ec 0c             	sub    $0xc,%esp
  exit();
  104f03:	e8 38 eb ff ff       	call   103a40 <exit>
  return 0;  // not reached
}
  104f08:	31 c0                	xor    %eax,%eax
  104f0a:	83 c4 0c             	add    $0xc,%esp
  104f0d:	c3                   	ret    
  104f0e:	66 90                	xchg   %ax,%ax

00104f10 <sys_wait>:

int
sys_wait(void)
{
  return wait();
  104f10:	e9 5b ec ff ff       	jmp    103b70 <wait>
  104f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f20 <sys_kill>:
}

int
sys_kill(void)
{
  104f20:	83 ec 24             	sub    $0x24,%esp
  int pid;

  if(argint(0, &pid) < 0)
  104f23:	8d 44 24 14          	lea    0x14(%esp),%eax
  104f27:	50                   	push   %eax
  104f28:	6a 00                	push   $0x0
  104f2a:	e8 01 f3 ff ff       	call   104230 <argint>
  104f2f:	83 c4 10             	add    $0x10,%esp
  104f32:	85 c0                	test   %eax,%eax
  104f34:	78 1a                	js     104f50 <sys_kill+0x30>
    return -1;
  return kill(pid);
  104f36:	83 ec 0c             	sub    $0xc,%esp
  104f39:	ff 74 24 18          	pushl  0x18(%esp)
  104f3d:	e8 6e ea ff ff       	call   1039b0 <kill>
  104f42:	83 c4 10             	add    $0x10,%esp
}
  104f45:	83 c4 1c             	add    $0x1c,%esp
  104f48:	c3                   	ret    
  104f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  104f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104f55:	eb ee                	jmp    104f45 <sys_kill+0x25>
  104f57:	89 f6                	mov    %esi,%esi
  104f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f60 <sys_getpid>:
}

int
sys_getpid(void)
{
  return cp->pid;
  104f60:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  104f65:	65 8b 00             	mov    %gs:(%eax),%eax
  104f68:	8b 40 10             	mov    0x10(%eax),%eax
}
  104f6b:	c3                   	ret    
  104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104f70 <sys_sbrk>:

int
sys_sbrk(void)
{
  104f70:	53                   	push   %ebx
  104f71:	83 ec 20             	sub    $0x20,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  104f74:	8d 44 24 14          	lea    0x14(%esp),%eax
  104f78:	50                   	push   %eax
  104f79:	6a 00                	push   $0x0
  104f7b:	e8 b0 f2 ff ff       	call   104230 <argint>
  104f80:	83 c4 10             	add    $0x10,%esp
  104f83:	85 c0                	test   %eax,%eax
  104f85:	78 29                	js     104fb0 <sys_sbrk+0x40>
    return -1;
  addr = cp->sz;
  104f87:	b8 f8 ff ff ff       	mov    $0xfffffff8,%eax
  if(growproc(n) < 0)
  104f8c:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = cp->sz;
  104f8f:	65 8b 00             	mov    %gs:(%eax),%eax
  104f92:	8b 58 04             	mov    0x4(%eax),%ebx
  if(growproc(n) < 0)
  104f95:	ff 74 24 18          	pushl  0x18(%esp)
  104f99:	e8 52 e5 ff ff       	call   1034f0 <growproc>
  104f9e:	83 c4 10             	add    $0x10,%esp
  104fa1:	85 c0                	test   %eax,%eax
  104fa3:	78 0b                	js     104fb0 <sys_sbrk+0x40>
    return -1;
  return addr;
  104fa5:	89 d8                	mov    %ebx,%eax
}
  104fa7:	83 c4 18             	add    $0x18,%esp
  104faa:	5b                   	pop    %ebx
  104fab:	c3                   	ret    
  104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  104fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104fb5:	eb f0                	jmp    104fa7 <sys_sbrk+0x37>
  104fb7:	89 f6                	mov    %esi,%esi
  104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104fc0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  104fc0:	56                   	push   %esi
  104fc1:	53                   	push   %ebx
  104fc2:	83 ec 1c             	sub    $0x1c,%esp
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  104fc5:	8d 44 24 14          	lea    0x14(%esp),%eax
  104fc9:	50                   	push   %eax
  104fca:	6a 00                	push   $0x0
  104fcc:	e8 5f f2 ff ff       	call   104230 <argint>
  104fd1:	83 c4 10             	add    $0x10,%esp
  104fd4:	85 c0                	test   %eax,%eax
  104fd6:	0f 88 8c 00 00 00    	js     105068 <sys_sleep+0xa8>
    return -1;
  acquire(&tickslock);
  104fdc:	83 ec 0c             	sub    $0xc,%esp
  104fdf:	68 40 f0 10 00       	push   $0x10f040
  104fe4:	e8 57 ed ff ff       	call   103d40 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  104fe9:	83 c4 10             	add    $0x10,%esp
  104fec:	8b 54 24 0c          	mov    0xc(%esp),%edx
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  104ff0:	8b 35 80 f8 10 00    	mov    0x10f880,%esi
  while(ticks - ticks0 < n){
  104ff6:	85 d2                	test   %edx,%edx
  104ff8:	7e 56                	jle    105050 <sys_sleep+0x90>
    if(cp->killed){
  104ffa:	c7 c3 f8 ff ff ff    	mov    $0xfffffff8,%ebx
  105000:	eb 28                	jmp    10502a <sys_sleep+0x6a>
  105002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  105008:	83 ec 08             	sub    $0x8,%esp
  10500b:	68 40 f0 10 00       	push   $0x10f040
  105010:	68 80 f8 10 00       	push   $0x10f880
  105015:	e8 86 e8 ff ff       	call   1038a0 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  10501a:	a1 80 f8 10 00       	mov    0x10f880,%eax
  10501f:	83 c4 10             	add    $0x10,%esp
  105022:	29 f0                	sub    %esi,%eax
  105024:	3b 44 24 0c          	cmp    0xc(%esp),%eax
  105028:	7d 26                	jge    105050 <sys_sleep+0x90>
    if(cp->killed){
  10502a:	65 8b 03             	mov    %gs:(%ebx),%eax
  10502d:	8b 40 24             	mov    0x24(%eax),%eax
  105030:	85 c0                	test   %eax,%eax
  105032:	74 d4                	je     105008 <sys_sleep+0x48>
      release(&tickslock);
  105034:	83 ec 0c             	sub    $0xc,%esp
  105037:	68 40 f0 10 00       	push   $0x10f040
  10503c:	e8 df ee ff ff       	call   103f20 <release>
      return -1;
  105041:	83 c4 10             	add    $0x10,%esp
  105044:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  105049:	83 c4 14             	add    $0x14,%esp
  10504c:	5b                   	pop    %ebx
  10504d:	5e                   	pop    %esi
  10504e:	c3                   	ret    
  10504f:	90                   	nop
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  105050:	83 ec 0c             	sub    $0xc,%esp
  105053:	68 40 f0 10 00       	push   $0x10f040
  105058:	e8 c3 ee ff ff       	call   103f20 <release>
  return 0;
  10505d:	83 c4 10             	add    $0x10,%esp
  105060:	31 c0                	xor    %eax,%eax
}
  105062:	83 c4 14             	add    $0x14,%esp
  105065:	5b                   	pop    %ebx
  105066:	5e                   	pop    %esi
  105067:	c3                   	ret    
sys_sleep(void)
{
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  105068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10506d:	eb da                	jmp    105049 <sys_sleep+0x89>
  10506f:	90                   	nop

00105070 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
  105070:	83 ec 18             	sub    $0x18,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105073:	ba 43 00 00 00       	mov    $0x43,%edx
  105078:	b8 34 00 00 00       	mov    $0x34,%eax
  10507d:	ee                   	out    %al,(%dx)
  10507e:	ba 40 00 00 00       	mov    $0x40,%edx
  105083:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  105088:	ee                   	out    %al,(%dx)
  105089:	b8 2e 00 00 00       	mov    $0x2e,%eax
  10508e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
  10508f:	6a 00                	push   $0x0
  105091:	e8 ea db ff ff       	call   102c80 <picenable>
}
  105096:	83 c4 1c             	add    $0x1c,%esp
  105099:	c3                   	ret    

0010509a <alltraps>:
  10509a:	1e                   	push   %ds
  10509b:	06                   	push   %es
  10509c:	0f a0                	push   %fs
  10509e:	0f a8                	push   %gs
  1050a0:	60                   	pusha  
  1050a1:	66 b8 10 00          	mov    $0x10,%ax
  1050a5:	8e d8                	mov    %eax,%ds
  1050a7:	8e c0                	mov    %eax,%es
  1050a9:	66 b8 18 00          	mov    $0x18,%ax
  1050ad:	8e e0                	mov    %eax,%fs
  1050af:	8e e8                	mov    %eax,%gs
  1050b1:	54                   	push   %esp
  1050b2:	e8 d9 00 00 00       	call   105190 <trap>
  1050b7:	83 c4 04             	add    $0x4,%esp

001050ba <trapret>:
  1050ba:	61                   	popa   
  1050bb:	0f a9                	pop    %gs
  1050bd:	0f a1                	pop    %fs
  1050bf:	07                   	pop    %es
  1050c0:	1f                   	pop    %ds
  1050c1:	83 c4 08             	add    $0x8,%esp
  1050c4:	cf                   	iret   

001050c5 <forkret1>:
  1050c5:	8b 64 24 04          	mov    0x4(%esp),%esp
  1050c9:	eb ef                	jmp    1050ba <trapret>
  1050cb:	66 90                	xchg   %ax,%ax
  1050cd:	66 90                	xchg   %ax,%ax
  1050cf:	90                   	nop

001050d0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  1050d0:	31 c0                	xor    %eax,%eax
  1050d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  1050d8:	8b 14 85 28 93 10 00 	mov    0x109328(,%eax,4),%edx
  1050df:	b9 08 00 00 00       	mov    $0x8,%ecx
  1050e4:	c6 04 c5 84 f0 10 00 	movb   $0x0,0x10f084(,%eax,8)
  1050eb:	00 
  1050ec:	66 89 0c c5 82 f0 10 	mov    %cx,0x10f082(,%eax,8)
  1050f3:	00 
  1050f4:	c6 04 c5 85 f0 10 00 	movb   $0x8e,0x10f085(,%eax,8)
  1050fb:	8e 
  1050fc:	66 89 14 c5 80 f0 10 	mov    %dx,0x10f080(,%eax,8)
  105103:	00 
  105104:	c1 ea 10             	shr    $0x10,%edx
  105107:	66 89 14 c5 86 f0 10 	mov    %dx,0x10f086(,%eax,8)
  10510e:	00 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  10510f:	83 c0 01             	add    $0x1,%eax
  105112:	3d 00 01 00 00       	cmp    $0x100,%eax
  105117:	75 bf                	jne    1050d8 <tvinit+0x8>
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  105119:	83 ec 14             	sub    $0x14,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  10511c:	a1 28 94 10 00       	mov    0x109428,%eax
  105121:	ba 08 00 00 00       	mov    $0x8,%edx
  
  initlock(&tickslock, "time");
  105126:	68 66 66 10 00       	push   $0x106666
  10512b:	68 40 f0 10 00       	push   $0x10f040
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  105130:	66 89 15 82 f2 10 00 	mov    %dx,0x10f282
  105137:	c6 05 84 f2 10 00 00 	movb   $0x0,0x10f284
  10513e:	66 a3 80 f2 10 00    	mov    %ax,0x10f280
  105144:	c1 e8 10             	shr    $0x10,%eax
  105147:	c6 05 85 f2 10 00 ef 	movb   $0xef,0x10f285
  10514e:	66 a3 86 f2 10 00    	mov    %ax,0x10f286
  
  initlock(&tickslock, "time");
  105154:	e8 c7 eb ff ff       	call   103d20 <initlock>
}
  105159:	83 c4 1c             	add    $0x1c,%esp
  10515c:	c3                   	ret    
  10515d:	8d 76 00             	lea    0x0(%esi),%esi

00105160 <idtinit>:

void
idtinit(void)
{
  105160:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  105163:	b8 ff 07 00 00       	mov    $0x7ff,%eax
  105168:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
  pd[1] = (uint)p;
  10516d:	b8 80 f0 10 00       	mov    $0x10f080,%eax
  105172:	66 89 44 24 0c       	mov    %ax,0xc(%esp)
  pd[2] = (uint)p >> 16;
  105177:	c1 e8 10             	shr    $0x10,%eax
  10517a:	66 89 44 24 0e       	mov    %ax,0xe(%esp)

  asm volatile("lidt (%0)" : : "r" (pd));
  10517f:	8d 44 24 0a          	lea    0xa(%esp),%eax
  105183:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  105186:	83 c4 10             	add    $0x10,%esp
  105189:	c3                   	ret    
  10518a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105190 <trap>:

void
trap(struct trapframe *tf)
{
  105190:	57                   	push   %edi
  105191:	56                   	push   %esi
  105192:	53                   	push   %ebx
  105193:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  if(tf->trapno == T_SYSCALL){
  105197:	8b 43 30             	mov    0x30(%ebx),%eax
  10519a:	83 f8 40             	cmp    $0x40,%eax
  10519d:	74 19                	je     1051b8 <trap+0x28>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  10519f:	83 e8 20             	sub    $0x20,%eax
  1051a2:	83 f8 1f             	cmp    $0x1f,%eax
  1051a5:	0f 87 05 01 00 00    	ja     1052b0 <trap+0x120>
  1051ab:	ff 24 85 f8 66 10 00 	jmp    *0x1066f8(,%eax,4)
  1051b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
  1051b8:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  1051be:	65 8b 06             	mov    %gs:(%esi),%eax
  1051c1:	8b 78 24             	mov    0x24(%eax),%edi
  1051c4:	85 ff                	test   %edi,%edi
  1051c6:	0f 85 d4 00 00 00    	jne    1052a0 <trap+0x110>
      exit();
    cp->tf = tf;
  1051cc:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
  1051cf:	e8 7c f1 ff ff       	call   104350 <syscall>
    if(cp->killed)
  1051d4:	65 8b 06             	mov    %gs:(%esi),%eax
  1051d7:	8b 58 24             	mov    0x24(%eax),%ebx
  1051da:	85 db                	test   %ebx,%ebx
  1051dc:	75 4d                	jne    10522b <trap+0x9b>
    yield();

  // Check if the process has been killed since we yielded
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
}
  1051de:	5b                   	pop    %ebx
  1051df:	5e                   	pop    %esi
  1051e0:	5f                   	pop    %edi
  1051e1:	c3                   	ret    
  1051e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
  1051e8:	e8 c3 ce ff ff       	call   1020b0 <ideintr>
    lapiceoi();
  1051ed:	e8 ae d5 ff ff       	call   1027a0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  1051f2:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  1051f8:	65 8b 06             	mov    %gs:(%esi),%eax
  1051fb:	85 c0                	test   %eax,%eax
  1051fd:	74 df                	je     1051de <trap+0x4e>
  1051ff:	8b 50 24             	mov    0x24(%eax),%edx
  105202:	85 d2                	test   %edx,%edx
  105204:	0f 85 f6 00 00 00    	jne    105300 <trap+0x170>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  10520a:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  10520e:	0f 84 06 01 00 00    	je     10531a <trap+0x18a>
    yield();

  // Check if the process has been killed since we yielded
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  105214:	65 8b 06             	mov    %gs:(%esi),%eax
  105217:	8b 40 24             	mov    0x24(%eax),%eax
  10521a:	85 c0                	test   %eax,%eax
  10521c:	74 c0                	je     1051de <trap+0x4e>
  10521e:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  105222:	83 e0 03             	and    $0x3,%eax
  105225:	66 83 f8 03          	cmp    $0x3,%ax
  105229:	75 b3                	jne    1051de <trap+0x4e>
    exit();
}
  10522b:	5b                   	pop    %ebx
  10522c:	5e                   	pop    %esi
  10522d:	5f                   	pop    %edi
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
  10522e:	e9 0d e8 ff ff       	jmp    103a40 <exit>
  105233:	90                   	nop
  105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu() == 0){
  105238:	e8 03 d5 ff ff       	call   102740 <cpu>
  10523d:	85 c0                	test   %eax,%eax
  10523f:	0f 84 13 01 00 00    	je     105358 <trap+0x1c8>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
  105245:	e8 56 d5 ff ff       	call   1027a0 <lapiceoi>
    break;
  10524a:	eb a6                	jmp    1051f2 <trap+0x62>
  10524c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
  105250:	e8 db d3 ff ff       	call   102630 <kbdintr>
    lapiceoi();
  105255:	e8 46 d5 ff ff       	call   1027a0 <lapiceoi>
    break;
  10525a:	eb 96                	jmp    1051f2 <trap+0x62>
  10525c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_COM1:
    uartintr();
  105260:	e8 9b 02 00 00       	call   105500 <uartintr>
  105265:	eb de                	jmp    105245 <trap+0xb5>
  105267:	89 f6                	mov    %esi,%esi
  105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  105270:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
  105274:	8b 7b 38             	mov    0x38(%ebx),%edi
  105277:	e8 c4 d4 ff ff       	call   102740 <cpu>
  10527c:	57                   	push   %edi
  10527d:	56                   	push   %esi
  10527e:	50                   	push   %eax
  10527f:	68 70 66 10 00       	push   $0x106670
  105284:	e8 17 b4 ff ff       	call   1006a0 <cprintf>
            cpu(), tf->cs, tf->eip);
    lapiceoi();
  105289:	e8 12 d5 ff ff       	call   1027a0 <lapiceoi>
    break;
  10528e:	83 c4 10             	add    $0x10,%esp
  105291:	e9 5c ff ff ff       	jmp    1051f2 <trap+0x62>
  105296:	8d 76 00             	lea    0x0(%esi),%esi
  105299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
  1052a0:	e8 9b e7 ff ff       	call   103a40 <exit>
  1052a5:	65 8b 06             	mov    %gs:(%esi),%eax
  1052a8:	e9 1f ff ff ff       	jmp    1051cc <trap+0x3c>
  1052ad:	8d 76 00             	lea    0x0(%esi),%esi
            cpu(), tf->cs, tf->eip);
    lapiceoi();
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
  1052b0:	c7 c6 f8 ff ff ff    	mov    $0xfffffff8,%esi
  1052b6:	65 8b 0e             	mov    %gs:(%esi),%ecx
  1052b9:	85 c9                	test   %ecx,%ecx
  1052bb:	0f 84 cb 00 00 00    	je     10538c <trap+0x1fc>
  1052c1:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
  1052c5:	0f 84 c1 00 00 00    	je     10538c <trap+0x1fc>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1052cb:	8b 7b 38             	mov    0x38(%ebx),%edi
  1052ce:	e8 6d d4 ff ff       	call   102740 <cpu>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1052d3:	65 8b 16             	mov    %gs:(%esi),%edx
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1052d6:	83 ec 04             	sub    $0x4,%esp
  1052d9:	8b 4a 10             	mov    0x10(%edx),%ecx
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1052dc:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1052df:	57                   	push   %edi
  1052e0:	50                   	push   %eax
  1052e1:	ff 73 34             	pushl  0x34(%ebx)
  1052e4:	ff 73 30             	pushl  0x30(%ebx)
  1052e7:	52                   	push   %edx
  1052e8:	51                   	push   %ecx
  1052e9:	68 bc 66 10 00       	push   $0x1066bc
  1052ee:	e8 ad b3 ff ff       	call   1006a0 <cprintf>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
    cp->killed = 1;
  1052f3:	65 8b 06             	mov    %gs:(%esi),%eax
  1052f6:	83 c4 20             	add    $0x20,%esp
  1052f9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  105300:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
  105304:	83 e0 03             	and    $0x3,%eax
  105307:	66 83 f8 03          	cmp    $0x3,%ax
  10530b:	74 33                	je     105340 <trap+0x1b0>
  10530d:	65 8b 06             	mov    %gs:(%esi),%eax
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  105310:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  105314:	0f 85 fa fe ff ff    	jne    105214 <trap+0x84>
  10531a:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
  10531e:	0f 85 f0 fe ff ff    	jne    105214 <trap+0x84>
    yield();
  105324:	e8 37 e5 ff ff       	call   103860 <yield>
  105329:	65 8b 06             	mov    %gs:(%esi),%eax

  // Check if the process has been killed since we yielded
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  10532c:	85 c0                	test   %eax,%eax
  10532e:	0f 85 e3 fe ff ff    	jne    105217 <trap+0x87>
  105334:	e9 a5 fe ff ff       	jmp    1051de <trap+0x4e>
  105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
  105340:	e8 fb e6 ff ff       	call   103a40 <exit>
  105345:	65 8b 06             	mov    %gs:(%esi),%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
  105348:	85 c0                	test   %eax,%eax
  10534a:	0f 85 ba fe ff ff    	jne    10520a <trap+0x7a>
  105350:	e9 89 fe ff ff       	jmp    1051de <trap+0x4e>
  105355:	8d 76 00             	lea    0x0(%esi),%esi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
  105358:	83 ec 0c             	sub    $0xc,%esp
  10535b:	68 40 f0 10 00       	push   $0x10f040
  105360:	e8 db e9 ff ff       	call   103d40 <acquire>
      ticks++;
      wakeup(&ticks);
  105365:	c7 04 24 80 f8 10 00 	movl   $0x10f880,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
      ticks++;
  10536c:	83 05 80 f8 10 00 01 	addl   $0x1,0x10f880
      wakeup(&ticks);
  105373:	e8 d8 e5 ff ff       	call   103950 <wakeup>
      release(&tickslock);
  105378:	c7 04 24 40 f0 10 00 	movl   $0x10f040,(%esp)
  10537f:	e8 9c eb ff ff       	call   103f20 <release>
  105384:	83 c4 10             	add    $0x10,%esp
  105387:	e9 b9 fe ff ff       	jmp    105245 <trap+0xb5>
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  10538c:	8b 73 38             	mov    0x38(%ebx),%esi
  10538f:	e8 ac d3 ff ff       	call   102740 <cpu>
  105394:	56                   	push   %esi
  105395:	50                   	push   %eax
  105396:	ff 73 30             	pushl  0x30(%ebx)
  105399:	68 94 66 10 00       	push   $0x106694
  10539e:	e8 fd b2 ff ff       	call   1006a0 <cprintf>
              tf->trapno, cpu(), tf->eip);
      panic("trap");
  1053a3:	c7 04 24 6b 66 10 00 	movl   $0x10666b,(%esp)
  1053aa:	e8 71 b6 ff ff       	call   100a20 <panic>
  1053af:	90                   	nop

001053b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
  1053b0:	a1 84 98 10 00       	mov    0x109884,%eax
  1053b5:	85 c0                	test   %eax,%eax
  1053b7:	74 17                	je     1053d0 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1053b9:	ba fd 03 00 00       	mov    $0x3fd,%edx
  1053be:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
  1053bf:	a8 01                	test   $0x1,%al
  1053c1:	74 0d                	je     1053d0 <uartgetc+0x20>
  1053c3:	ba f8 03 00 00       	mov    $0x3f8,%edx
  1053c8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
  1053c9:	0f b6 c0             	movzbl %al,%eax
  1053cc:	c3                   	ret    
  1053cd:	8d 76 00             	lea    0x0(%esi),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
  1053d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
  1053d5:	c3                   	ret    
  1053d6:	8d 76 00             	lea    0x0(%esi),%esi
  1053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001053e0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
  1053e0:	57                   	push   %edi
  1053e1:	89 c7                	mov    %eax,%edi
  1053e3:	56                   	push   %esi
  1053e4:	be fd 03 00 00       	mov    $0x3fd,%esi
  1053e9:	53                   	push   %ebx
  1053ea:	bb 80 00 00 00       	mov    $0x80,%ebx
  1053ef:	eb 19                	jmp    10540a <uartputc.part.0+0x2a>
  1053f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  1053f8:	83 ec 0c             	sub    $0xc,%esp
  1053fb:	6a 0a                	push   $0xa
  1053fd:	e8 be d3 ff ff       	call   1027c0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
  105402:	83 c4 10             	add    $0x10,%esp
  105405:	83 eb 01             	sub    $0x1,%ebx
  105408:	74 07                	je     105411 <uartputc.part.0+0x31>
  10540a:	89 f2                	mov    %esi,%edx
  10540c:	ec                   	in     (%dx),%al
  10540d:	a8 20                	test   $0x20,%al
  10540f:	74 e7                	je     1053f8 <uartputc.part.0+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105411:	ba f8 03 00 00       	mov    $0x3f8,%edx
  105416:	89 f8                	mov    %edi,%eax
  105418:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
  105419:	5b                   	pop    %ebx
  10541a:	5e                   	pop    %esi
  10541b:	5f                   	pop    %edi
  10541c:	c3                   	ret    
  10541d:	8d 76 00             	lea    0x0(%esi),%esi

00105420 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
  105420:	55                   	push   %ebp
  105421:	57                   	push   %edi
  105422:	31 c9                	xor    %ecx,%ecx
  105424:	56                   	push   %esi
  105425:	53                   	push   %ebx
  105426:	be fa 03 00 00       	mov    $0x3fa,%esi
  10542b:	89 c8                	mov    %ecx,%eax
  10542d:	89 f2                	mov    %esi,%edx
  10542f:	83 ec 0c             	sub    $0xc,%esp
  105432:	ee                   	out    %al,(%dx)
  105433:	bd fb 03 00 00       	mov    $0x3fb,%ebp
  105438:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
  10543d:	89 ea                	mov    %ebp,%edx
  10543f:	ee                   	out    %al,(%dx)
  105440:	bb f8 03 00 00       	mov    $0x3f8,%ebx
  105445:	b8 0c 00 00 00       	mov    $0xc,%eax
  10544a:	89 da                	mov    %ebx,%edx
  10544c:	ee                   	out    %al,(%dx)
  10544d:	bf f9 03 00 00       	mov    $0x3f9,%edi
  105452:	89 c8                	mov    %ecx,%eax
  105454:	89 fa                	mov    %edi,%edx
  105456:	ee                   	out    %al,(%dx)
  105457:	b8 03 00 00 00       	mov    $0x3,%eax
  10545c:	89 ea                	mov    %ebp,%edx
  10545e:	ee                   	out    %al,(%dx)
  10545f:	ba fc 03 00 00       	mov    $0x3fc,%edx
  105464:	89 c8                	mov    %ecx,%eax
  105466:	ee                   	out    %al,(%dx)
  105467:	b8 01 00 00 00       	mov    $0x1,%eax
  10546c:	89 fa                	mov    %edi,%edx
  10546e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  10546f:	ba fd 03 00 00       	mov    $0x3fd,%edx
  105474:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
  105475:	3c ff                	cmp    $0xff,%al
  105477:	74 5a                	je     1054d3 <uartinit+0xb3>
    return;
  uart = 1;
  105479:	c7 05 84 98 10 00 01 	movl   $0x1,0x109884
  105480:	00 00 00 
  105483:	89 f2                	mov    %esi,%edx
  105485:	ec                   	in     (%dx),%al
  105486:	89 da                	mov    %ebx,%edx
  105488:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
  105489:	83 ec 0c             	sub    $0xc,%esp
  10548c:	6a 04                	push   $0x4
  10548e:	e8 ed d7 ff ff       	call   102c80 <picenable>
  ioapicenable(IRQ_COM1, 0);
  105493:	59                   	pop    %ecx
  105494:	5b                   	pop    %ebx
  105495:	6a 00                	push   $0x0
  105497:	6a 04                	push   $0x4
  105499:	bb 78 67 10 00       	mov    $0x106778,%ebx
  10549e:	e8 6d ce ff ff       	call   102310 <ioapicenable>
  1054a3:	83 c4 10             	add    $0x10,%esp
  1054a6:	b8 78 00 00 00       	mov    $0x78,%eax
  1054ab:	eb 0d                	jmp    1054ba <uartinit+0x9a>
  1054ad:	8d 76 00             	lea    0x0(%esi),%esi
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  1054b0:	83 c3 01             	add    $0x1,%ebx
  1054b3:	0f be 03             	movsbl (%ebx),%eax
  1054b6:	84 c0                	test   %al,%al
  1054b8:	74 19                	je     1054d3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
  1054ba:	8b 15 84 98 10 00    	mov    0x109884,%edx
  1054c0:	85 d2                	test   %edx,%edx
  1054c2:	74 ec                	je     1054b0 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
  1054c4:	83 c3 01             	add    $0x1,%ebx
  1054c7:	e8 14 ff ff ff       	call   1053e0 <uartputc.part.0>
  1054cc:	0f be 03             	movsbl (%ebx),%eax
  1054cf:	84 c0                	test   %al,%al
  1054d1:	75 e7                	jne    1054ba <uartinit+0x9a>
    uartputc(*p);
}
  1054d3:	83 c4 0c             	add    $0xc,%esp
  1054d6:	5b                   	pop    %ebx
  1054d7:	5e                   	pop    %esi
  1054d8:	5f                   	pop    %edi
  1054d9:	5d                   	pop    %ebp
  1054da:	c3                   	ret    
  1054db:	90                   	nop
  1054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001054e0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
  1054e0:	8b 15 84 98 10 00    	mov    0x109884,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
  1054e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  int i;

  if(!uart)
  1054ea:	85 d2                	test   %edx,%edx
  1054ec:	74 0a                	je     1054f8 <uartputc+0x18>
  1054ee:	e9 ed fe ff ff       	jmp    1053e0 <uartputc.part.0>
  1054f3:	90                   	nop
  1054f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1054f8:	f3 c3                	repz ret 
  1054fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105500 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
  105500:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
  105503:	68 b0 53 10 00       	push   $0x1053b0
  105508:	e8 43 b3 ff ff       	call   100850 <consoleintr>
}
  10550d:	83 c4 1c             	add    $0x1c,%esp
  105510:	c3                   	ret    

00105511 <vector0>:
  105511:	6a 00                	push   $0x0
  105513:	6a 00                	push   $0x0
  105515:	e9 80 fb ff ff       	jmp    10509a <alltraps>

0010551a <vector1>:
  10551a:	6a 00                	push   $0x0
  10551c:	6a 01                	push   $0x1
  10551e:	e9 77 fb ff ff       	jmp    10509a <alltraps>

00105523 <vector2>:
  105523:	6a 00                	push   $0x0
  105525:	6a 02                	push   $0x2
  105527:	e9 6e fb ff ff       	jmp    10509a <alltraps>

0010552c <vector3>:
  10552c:	6a 00                	push   $0x0
  10552e:	6a 03                	push   $0x3
  105530:	e9 65 fb ff ff       	jmp    10509a <alltraps>

00105535 <vector4>:
  105535:	6a 00                	push   $0x0
  105537:	6a 04                	push   $0x4
  105539:	e9 5c fb ff ff       	jmp    10509a <alltraps>

0010553e <vector5>:
  10553e:	6a 00                	push   $0x0
  105540:	6a 05                	push   $0x5
  105542:	e9 53 fb ff ff       	jmp    10509a <alltraps>

00105547 <vector6>:
  105547:	6a 00                	push   $0x0
  105549:	6a 06                	push   $0x6
  10554b:	e9 4a fb ff ff       	jmp    10509a <alltraps>

00105550 <vector7>:
  105550:	6a 00                	push   $0x0
  105552:	6a 07                	push   $0x7
  105554:	e9 41 fb ff ff       	jmp    10509a <alltraps>

00105559 <vector8>:
  105559:	6a 08                	push   $0x8
  10555b:	e9 3a fb ff ff       	jmp    10509a <alltraps>

00105560 <vector9>:
  105560:	6a 00                	push   $0x0
  105562:	6a 09                	push   $0x9
  105564:	e9 31 fb ff ff       	jmp    10509a <alltraps>

00105569 <vector10>:
  105569:	6a 0a                	push   $0xa
  10556b:	e9 2a fb ff ff       	jmp    10509a <alltraps>

00105570 <vector11>:
  105570:	6a 0b                	push   $0xb
  105572:	e9 23 fb ff ff       	jmp    10509a <alltraps>

00105577 <vector12>:
  105577:	6a 0c                	push   $0xc
  105579:	e9 1c fb ff ff       	jmp    10509a <alltraps>

0010557e <vector13>:
  10557e:	6a 0d                	push   $0xd
  105580:	e9 15 fb ff ff       	jmp    10509a <alltraps>

00105585 <vector14>:
  105585:	6a 0e                	push   $0xe
  105587:	e9 0e fb ff ff       	jmp    10509a <alltraps>

0010558c <vector15>:
  10558c:	6a 00                	push   $0x0
  10558e:	6a 0f                	push   $0xf
  105590:	e9 05 fb ff ff       	jmp    10509a <alltraps>

00105595 <vector16>:
  105595:	6a 00                	push   $0x0
  105597:	6a 10                	push   $0x10
  105599:	e9 fc fa ff ff       	jmp    10509a <alltraps>

0010559e <vector17>:
  10559e:	6a 11                	push   $0x11
  1055a0:	e9 f5 fa ff ff       	jmp    10509a <alltraps>

001055a5 <vector18>:
  1055a5:	6a 00                	push   $0x0
  1055a7:	6a 12                	push   $0x12
  1055a9:	e9 ec fa ff ff       	jmp    10509a <alltraps>

001055ae <vector19>:
  1055ae:	6a 00                	push   $0x0
  1055b0:	6a 13                	push   $0x13
  1055b2:	e9 e3 fa ff ff       	jmp    10509a <alltraps>

001055b7 <vector20>:
  1055b7:	6a 00                	push   $0x0
  1055b9:	6a 14                	push   $0x14
  1055bb:	e9 da fa ff ff       	jmp    10509a <alltraps>

001055c0 <vector21>:
  1055c0:	6a 00                	push   $0x0
  1055c2:	6a 15                	push   $0x15
  1055c4:	e9 d1 fa ff ff       	jmp    10509a <alltraps>

001055c9 <vector22>:
  1055c9:	6a 00                	push   $0x0
  1055cb:	6a 16                	push   $0x16
  1055cd:	e9 c8 fa ff ff       	jmp    10509a <alltraps>

001055d2 <vector23>:
  1055d2:	6a 00                	push   $0x0
  1055d4:	6a 17                	push   $0x17
  1055d6:	e9 bf fa ff ff       	jmp    10509a <alltraps>

001055db <vector24>:
  1055db:	6a 00                	push   $0x0
  1055dd:	6a 18                	push   $0x18
  1055df:	e9 b6 fa ff ff       	jmp    10509a <alltraps>

001055e4 <vector25>:
  1055e4:	6a 00                	push   $0x0
  1055e6:	6a 19                	push   $0x19
  1055e8:	e9 ad fa ff ff       	jmp    10509a <alltraps>

001055ed <vector26>:
  1055ed:	6a 00                	push   $0x0
  1055ef:	6a 1a                	push   $0x1a
  1055f1:	e9 a4 fa ff ff       	jmp    10509a <alltraps>

001055f6 <vector27>:
  1055f6:	6a 00                	push   $0x0
  1055f8:	6a 1b                	push   $0x1b
  1055fa:	e9 9b fa ff ff       	jmp    10509a <alltraps>

001055ff <vector28>:
  1055ff:	6a 00                	push   $0x0
  105601:	6a 1c                	push   $0x1c
  105603:	e9 92 fa ff ff       	jmp    10509a <alltraps>

00105608 <vector29>:
  105608:	6a 00                	push   $0x0
  10560a:	6a 1d                	push   $0x1d
  10560c:	e9 89 fa ff ff       	jmp    10509a <alltraps>

00105611 <vector30>:
  105611:	6a 00                	push   $0x0
  105613:	6a 1e                	push   $0x1e
  105615:	e9 80 fa ff ff       	jmp    10509a <alltraps>

0010561a <vector31>:
  10561a:	6a 00                	push   $0x0
  10561c:	6a 1f                	push   $0x1f
  10561e:	e9 77 fa ff ff       	jmp    10509a <alltraps>

00105623 <vector32>:
  105623:	6a 00                	push   $0x0
  105625:	6a 20                	push   $0x20
  105627:	e9 6e fa ff ff       	jmp    10509a <alltraps>

0010562c <vector33>:
  10562c:	6a 00                	push   $0x0
  10562e:	6a 21                	push   $0x21
  105630:	e9 65 fa ff ff       	jmp    10509a <alltraps>

00105635 <vector34>:
  105635:	6a 00                	push   $0x0
  105637:	6a 22                	push   $0x22
  105639:	e9 5c fa ff ff       	jmp    10509a <alltraps>

0010563e <vector35>:
  10563e:	6a 00                	push   $0x0
  105640:	6a 23                	push   $0x23
  105642:	e9 53 fa ff ff       	jmp    10509a <alltraps>

00105647 <vector36>:
  105647:	6a 00                	push   $0x0
  105649:	6a 24                	push   $0x24
  10564b:	e9 4a fa ff ff       	jmp    10509a <alltraps>

00105650 <vector37>:
  105650:	6a 00                	push   $0x0
  105652:	6a 25                	push   $0x25
  105654:	e9 41 fa ff ff       	jmp    10509a <alltraps>

00105659 <vector38>:
  105659:	6a 00                	push   $0x0
  10565b:	6a 26                	push   $0x26
  10565d:	e9 38 fa ff ff       	jmp    10509a <alltraps>

00105662 <vector39>:
  105662:	6a 00                	push   $0x0
  105664:	6a 27                	push   $0x27
  105666:	e9 2f fa ff ff       	jmp    10509a <alltraps>

0010566b <vector40>:
  10566b:	6a 00                	push   $0x0
  10566d:	6a 28                	push   $0x28
  10566f:	e9 26 fa ff ff       	jmp    10509a <alltraps>

00105674 <vector41>:
  105674:	6a 00                	push   $0x0
  105676:	6a 29                	push   $0x29
  105678:	e9 1d fa ff ff       	jmp    10509a <alltraps>

0010567d <vector42>:
  10567d:	6a 00                	push   $0x0
  10567f:	6a 2a                	push   $0x2a
  105681:	e9 14 fa ff ff       	jmp    10509a <alltraps>

00105686 <vector43>:
  105686:	6a 00                	push   $0x0
  105688:	6a 2b                	push   $0x2b
  10568a:	e9 0b fa ff ff       	jmp    10509a <alltraps>

0010568f <vector44>:
  10568f:	6a 00                	push   $0x0
  105691:	6a 2c                	push   $0x2c
  105693:	e9 02 fa ff ff       	jmp    10509a <alltraps>

00105698 <vector45>:
  105698:	6a 00                	push   $0x0
  10569a:	6a 2d                	push   $0x2d
  10569c:	e9 f9 f9 ff ff       	jmp    10509a <alltraps>

001056a1 <vector46>:
  1056a1:	6a 00                	push   $0x0
  1056a3:	6a 2e                	push   $0x2e
  1056a5:	e9 f0 f9 ff ff       	jmp    10509a <alltraps>

001056aa <vector47>:
  1056aa:	6a 00                	push   $0x0
  1056ac:	6a 2f                	push   $0x2f
  1056ae:	e9 e7 f9 ff ff       	jmp    10509a <alltraps>

001056b3 <vector48>:
  1056b3:	6a 00                	push   $0x0
  1056b5:	6a 30                	push   $0x30
  1056b7:	e9 de f9 ff ff       	jmp    10509a <alltraps>

001056bc <vector49>:
  1056bc:	6a 00                	push   $0x0
  1056be:	6a 31                	push   $0x31
  1056c0:	e9 d5 f9 ff ff       	jmp    10509a <alltraps>

001056c5 <vector50>:
  1056c5:	6a 00                	push   $0x0
  1056c7:	6a 32                	push   $0x32
  1056c9:	e9 cc f9 ff ff       	jmp    10509a <alltraps>

001056ce <vector51>:
  1056ce:	6a 00                	push   $0x0
  1056d0:	6a 33                	push   $0x33
  1056d2:	e9 c3 f9 ff ff       	jmp    10509a <alltraps>

001056d7 <vector52>:
  1056d7:	6a 00                	push   $0x0
  1056d9:	6a 34                	push   $0x34
  1056db:	e9 ba f9 ff ff       	jmp    10509a <alltraps>

001056e0 <vector53>:
  1056e0:	6a 00                	push   $0x0
  1056e2:	6a 35                	push   $0x35
  1056e4:	e9 b1 f9 ff ff       	jmp    10509a <alltraps>

001056e9 <vector54>:
  1056e9:	6a 00                	push   $0x0
  1056eb:	6a 36                	push   $0x36
  1056ed:	e9 a8 f9 ff ff       	jmp    10509a <alltraps>

001056f2 <vector55>:
  1056f2:	6a 00                	push   $0x0
  1056f4:	6a 37                	push   $0x37
  1056f6:	e9 9f f9 ff ff       	jmp    10509a <alltraps>

001056fb <vector56>:
  1056fb:	6a 00                	push   $0x0
  1056fd:	6a 38                	push   $0x38
  1056ff:	e9 96 f9 ff ff       	jmp    10509a <alltraps>

00105704 <vector57>:
  105704:	6a 00                	push   $0x0
  105706:	6a 39                	push   $0x39
  105708:	e9 8d f9 ff ff       	jmp    10509a <alltraps>

0010570d <vector58>:
  10570d:	6a 00                	push   $0x0
  10570f:	6a 3a                	push   $0x3a
  105711:	e9 84 f9 ff ff       	jmp    10509a <alltraps>

00105716 <vector59>:
  105716:	6a 00                	push   $0x0
  105718:	6a 3b                	push   $0x3b
  10571a:	e9 7b f9 ff ff       	jmp    10509a <alltraps>

0010571f <vector60>:
  10571f:	6a 00                	push   $0x0
  105721:	6a 3c                	push   $0x3c
  105723:	e9 72 f9 ff ff       	jmp    10509a <alltraps>

00105728 <vector61>:
  105728:	6a 00                	push   $0x0
  10572a:	6a 3d                	push   $0x3d
  10572c:	e9 69 f9 ff ff       	jmp    10509a <alltraps>

00105731 <vector62>:
  105731:	6a 00                	push   $0x0
  105733:	6a 3e                	push   $0x3e
  105735:	e9 60 f9 ff ff       	jmp    10509a <alltraps>

0010573a <vector63>:
  10573a:	6a 00                	push   $0x0
  10573c:	6a 3f                	push   $0x3f
  10573e:	e9 57 f9 ff ff       	jmp    10509a <alltraps>

00105743 <vector64>:
  105743:	6a 00                	push   $0x0
  105745:	6a 40                	push   $0x40
  105747:	e9 4e f9 ff ff       	jmp    10509a <alltraps>

0010574c <vector65>:
  10574c:	6a 00                	push   $0x0
  10574e:	6a 41                	push   $0x41
  105750:	e9 45 f9 ff ff       	jmp    10509a <alltraps>

00105755 <vector66>:
  105755:	6a 00                	push   $0x0
  105757:	6a 42                	push   $0x42
  105759:	e9 3c f9 ff ff       	jmp    10509a <alltraps>

0010575e <vector67>:
  10575e:	6a 00                	push   $0x0
  105760:	6a 43                	push   $0x43
  105762:	e9 33 f9 ff ff       	jmp    10509a <alltraps>

00105767 <vector68>:
  105767:	6a 00                	push   $0x0
  105769:	6a 44                	push   $0x44
  10576b:	e9 2a f9 ff ff       	jmp    10509a <alltraps>

00105770 <vector69>:
  105770:	6a 00                	push   $0x0
  105772:	6a 45                	push   $0x45
  105774:	e9 21 f9 ff ff       	jmp    10509a <alltraps>

00105779 <vector70>:
  105779:	6a 00                	push   $0x0
  10577b:	6a 46                	push   $0x46
  10577d:	e9 18 f9 ff ff       	jmp    10509a <alltraps>

00105782 <vector71>:
  105782:	6a 00                	push   $0x0
  105784:	6a 47                	push   $0x47
  105786:	e9 0f f9 ff ff       	jmp    10509a <alltraps>

0010578b <vector72>:
  10578b:	6a 00                	push   $0x0
  10578d:	6a 48                	push   $0x48
  10578f:	e9 06 f9 ff ff       	jmp    10509a <alltraps>

00105794 <vector73>:
  105794:	6a 00                	push   $0x0
  105796:	6a 49                	push   $0x49
  105798:	e9 fd f8 ff ff       	jmp    10509a <alltraps>

0010579d <vector74>:
  10579d:	6a 00                	push   $0x0
  10579f:	6a 4a                	push   $0x4a
  1057a1:	e9 f4 f8 ff ff       	jmp    10509a <alltraps>

001057a6 <vector75>:
  1057a6:	6a 00                	push   $0x0
  1057a8:	6a 4b                	push   $0x4b
  1057aa:	e9 eb f8 ff ff       	jmp    10509a <alltraps>

001057af <vector76>:
  1057af:	6a 00                	push   $0x0
  1057b1:	6a 4c                	push   $0x4c
  1057b3:	e9 e2 f8 ff ff       	jmp    10509a <alltraps>

001057b8 <vector77>:
  1057b8:	6a 00                	push   $0x0
  1057ba:	6a 4d                	push   $0x4d
  1057bc:	e9 d9 f8 ff ff       	jmp    10509a <alltraps>

001057c1 <vector78>:
  1057c1:	6a 00                	push   $0x0
  1057c3:	6a 4e                	push   $0x4e
  1057c5:	e9 d0 f8 ff ff       	jmp    10509a <alltraps>

001057ca <vector79>:
  1057ca:	6a 00                	push   $0x0
  1057cc:	6a 4f                	push   $0x4f
  1057ce:	e9 c7 f8 ff ff       	jmp    10509a <alltraps>

001057d3 <vector80>:
  1057d3:	6a 00                	push   $0x0
  1057d5:	6a 50                	push   $0x50
  1057d7:	e9 be f8 ff ff       	jmp    10509a <alltraps>

001057dc <vector81>:
  1057dc:	6a 00                	push   $0x0
  1057de:	6a 51                	push   $0x51
  1057e0:	e9 b5 f8 ff ff       	jmp    10509a <alltraps>

001057e5 <vector82>:
  1057e5:	6a 00                	push   $0x0
  1057e7:	6a 52                	push   $0x52
  1057e9:	e9 ac f8 ff ff       	jmp    10509a <alltraps>

001057ee <vector83>:
  1057ee:	6a 00                	push   $0x0
  1057f0:	6a 53                	push   $0x53
  1057f2:	e9 a3 f8 ff ff       	jmp    10509a <alltraps>

001057f7 <vector84>:
  1057f7:	6a 00                	push   $0x0
  1057f9:	6a 54                	push   $0x54
  1057fb:	e9 9a f8 ff ff       	jmp    10509a <alltraps>

00105800 <vector85>:
  105800:	6a 00                	push   $0x0
  105802:	6a 55                	push   $0x55
  105804:	e9 91 f8 ff ff       	jmp    10509a <alltraps>

00105809 <vector86>:
  105809:	6a 00                	push   $0x0
  10580b:	6a 56                	push   $0x56
  10580d:	e9 88 f8 ff ff       	jmp    10509a <alltraps>

00105812 <vector87>:
  105812:	6a 00                	push   $0x0
  105814:	6a 57                	push   $0x57
  105816:	e9 7f f8 ff ff       	jmp    10509a <alltraps>

0010581b <vector88>:
  10581b:	6a 00                	push   $0x0
  10581d:	6a 58                	push   $0x58
  10581f:	e9 76 f8 ff ff       	jmp    10509a <alltraps>

00105824 <vector89>:
  105824:	6a 00                	push   $0x0
  105826:	6a 59                	push   $0x59
  105828:	e9 6d f8 ff ff       	jmp    10509a <alltraps>

0010582d <vector90>:
  10582d:	6a 00                	push   $0x0
  10582f:	6a 5a                	push   $0x5a
  105831:	e9 64 f8 ff ff       	jmp    10509a <alltraps>

00105836 <vector91>:
  105836:	6a 00                	push   $0x0
  105838:	6a 5b                	push   $0x5b
  10583a:	e9 5b f8 ff ff       	jmp    10509a <alltraps>

0010583f <vector92>:
  10583f:	6a 00                	push   $0x0
  105841:	6a 5c                	push   $0x5c
  105843:	e9 52 f8 ff ff       	jmp    10509a <alltraps>

00105848 <vector93>:
  105848:	6a 00                	push   $0x0
  10584a:	6a 5d                	push   $0x5d
  10584c:	e9 49 f8 ff ff       	jmp    10509a <alltraps>

00105851 <vector94>:
  105851:	6a 00                	push   $0x0
  105853:	6a 5e                	push   $0x5e
  105855:	e9 40 f8 ff ff       	jmp    10509a <alltraps>

0010585a <vector95>:
  10585a:	6a 00                	push   $0x0
  10585c:	6a 5f                	push   $0x5f
  10585e:	e9 37 f8 ff ff       	jmp    10509a <alltraps>

00105863 <vector96>:
  105863:	6a 00                	push   $0x0
  105865:	6a 60                	push   $0x60
  105867:	e9 2e f8 ff ff       	jmp    10509a <alltraps>

0010586c <vector97>:
  10586c:	6a 00                	push   $0x0
  10586e:	6a 61                	push   $0x61
  105870:	e9 25 f8 ff ff       	jmp    10509a <alltraps>

00105875 <vector98>:
  105875:	6a 00                	push   $0x0
  105877:	6a 62                	push   $0x62
  105879:	e9 1c f8 ff ff       	jmp    10509a <alltraps>

0010587e <vector99>:
  10587e:	6a 00                	push   $0x0
  105880:	6a 63                	push   $0x63
  105882:	e9 13 f8 ff ff       	jmp    10509a <alltraps>

00105887 <vector100>:
  105887:	6a 00                	push   $0x0
  105889:	6a 64                	push   $0x64
  10588b:	e9 0a f8 ff ff       	jmp    10509a <alltraps>

00105890 <vector101>:
  105890:	6a 00                	push   $0x0
  105892:	6a 65                	push   $0x65
  105894:	e9 01 f8 ff ff       	jmp    10509a <alltraps>

00105899 <vector102>:
  105899:	6a 00                	push   $0x0
  10589b:	6a 66                	push   $0x66
  10589d:	e9 f8 f7 ff ff       	jmp    10509a <alltraps>

001058a2 <vector103>:
  1058a2:	6a 00                	push   $0x0
  1058a4:	6a 67                	push   $0x67
  1058a6:	e9 ef f7 ff ff       	jmp    10509a <alltraps>

001058ab <vector104>:
  1058ab:	6a 00                	push   $0x0
  1058ad:	6a 68                	push   $0x68
  1058af:	e9 e6 f7 ff ff       	jmp    10509a <alltraps>

001058b4 <vector105>:
  1058b4:	6a 00                	push   $0x0
  1058b6:	6a 69                	push   $0x69
  1058b8:	e9 dd f7 ff ff       	jmp    10509a <alltraps>

001058bd <vector106>:
  1058bd:	6a 00                	push   $0x0
  1058bf:	6a 6a                	push   $0x6a
  1058c1:	e9 d4 f7 ff ff       	jmp    10509a <alltraps>

001058c6 <vector107>:
  1058c6:	6a 00                	push   $0x0
  1058c8:	6a 6b                	push   $0x6b
  1058ca:	e9 cb f7 ff ff       	jmp    10509a <alltraps>

001058cf <vector108>:
  1058cf:	6a 00                	push   $0x0
  1058d1:	6a 6c                	push   $0x6c
  1058d3:	e9 c2 f7 ff ff       	jmp    10509a <alltraps>

001058d8 <vector109>:
  1058d8:	6a 00                	push   $0x0
  1058da:	6a 6d                	push   $0x6d
  1058dc:	e9 b9 f7 ff ff       	jmp    10509a <alltraps>

001058e1 <vector110>:
  1058e1:	6a 00                	push   $0x0
  1058e3:	6a 6e                	push   $0x6e
  1058e5:	e9 b0 f7 ff ff       	jmp    10509a <alltraps>

001058ea <vector111>:
  1058ea:	6a 00                	push   $0x0
  1058ec:	6a 6f                	push   $0x6f
  1058ee:	e9 a7 f7 ff ff       	jmp    10509a <alltraps>

001058f3 <vector112>:
  1058f3:	6a 00                	push   $0x0
  1058f5:	6a 70                	push   $0x70
  1058f7:	e9 9e f7 ff ff       	jmp    10509a <alltraps>

001058fc <vector113>:
  1058fc:	6a 00                	push   $0x0
  1058fe:	6a 71                	push   $0x71
  105900:	e9 95 f7 ff ff       	jmp    10509a <alltraps>

00105905 <vector114>:
  105905:	6a 00                	push   $0x0
  105907:	6a 72                	push   $0x72
  105909:	e9 8c f7 ff ff       	jmp    10509a <alltraps>

0010590e <vector115>:
  10590e:	6a 00                	push   $0x0
  105910:	6a 73                	push   $0x73
  105912:	e9 83 f7 ff ff       	jmp    10509a <alltraps>

00105917 <vector116>:
  105917:	6a 00                	push   $0x0
  105919:	6a 74                	push   $0x74
  10591b:	e9 7a f7 ff ff       	jmp    10509a <alltraps>

00105920 <vector117>:
  105920:	6a 00                	push   $0x0
  105922:	6a 75                	push   $0x75
  105924:	e9 71 f7 ff ff       	jmp    10509a <alltraps>

00105929 <vector118>:
  105929:	6a 00                	push   $0x0
  10592b:	6a 76                	push   $0x76
  10592d:	e9 68 f7 ff ff       	jmp    10509a <alltraps>

00105932 <vector119>:
  105932:	6a 00                	push   $0x0
  105934:	6a 77                	push   $0x77
  105936:	e9 5f f7 ff ff       	jmp    10509a <alltraps>

0010593b <vector120>:
  10593b:	6a 00                	push   $0x0
  10593d:	6a 78                	push   $0x78
  10593f:	e9 56 f7 ff ff       	jmp    10509a <alltraps>

00105944 <vector121>:
  105944:	6a 00                	push   $0x0
  105946:	6a 79                	push   $0x79
  105948:	e9 4d f7 ff ff       	jmp    10509a <alltraps>

0010594d <vector122>:
  10594d:	6a 00                	push   $0x0
  10594f:	6a 7a                	push   $0x7a
  105951:	e9 44 f7 ff ff       	jmp    10509a <alltraps>

00105956 <vector123>:
  105956:	6a 00                	push   $0x0
  105958:	6a 7b                	push   $0x7b
  10595a:	e9 3b f7 ff ff       	jmp    10509a <alltraps>

0010595f <vector124>:
  10595f:	6a 00                	push   $0x0
  105961:	6a 7c                	push   $0x7c
  105963:	e9 32 f7 ff ff       	jmp    10509a <alltraps>

00105968 <vector125>:
  105968:	6a 00                	push   $0x0
  10596a:	6a 7d                	push   $0x7d
  10596c:	e9 29 f7 ff ff       	jmp    10509a <alltraps>

00105971 <vector126>:
  105971:	6a 00                	push   $0x0
  105973:	6a 7e                	push   $0x7e
  105975:	e9 20 f7 ff ff       	jmp    10509a <alltraps>

0010597a <vector127>:
  10597a:	6a 00                	push   $0x0
  10597c:	6a 7f                	push   $0x7f
  10597e:	e9 17 f7 ff ff       	jmp    10509a <alltraps>

00105983 <vector128>:
  105983:	6a 00                	push   $0x0
  105985:	68 80 00 00 00       	push   $0x80
  10598a:	e9 0b f7 ff ff       	jmp    10509a <alltraps>

0010598f <vector129>:
  10598f:	6a 00                	push   $0x0
  105991:	68 81 00 00 00       	push   $0x81
  105996:	e9 ff f6 ff ff       	jmp    10509a <alltraps>

0010599b <vector130>:
  10599b:	6a 00                	push   $0x0
  10599d:	68 82 00 00 00       	push   $0x82
  1059a2:	e9 f3 f6 ff ff       	jmp    10509a <alltraps>

001059a7 <vector131>:
  1059a7:	6a 00                	push   $0x0
  1059a9:	68 83 00 00 00       	push   $0x83
  1059ae:	e9 e7 f6 ff ff       	jmp    10509a <alltraps>

001059b3 <vector132>:
  1059b3:	6a 00                	push   $0x0
  1059b5:	68 84 00 00 00       	push   $0x84
  1059ba:	e9 db f6 ff ff       	jmp    10509a <alltraps>

001059bf <vector133>:
  1059bf:	6a 00                	push   $0x0
  1059c1:	68 85 00 00 00       	push   $0x85
  1059c6:	e9 cf f6 ff ff       	jmp    10509a <alltraps>

001059cb <vector134>:
  1059cb:	6a 00                	push   $0x0
  1059cd:	68 86 00 00 00       	push   $0x86
  1059d2:	e9 c3 f6 ff ff       	jmp    10509a <alltraps>

001059d7 <vector135>:
  1059d7:	6a 00                	push   $0x0
  1059d9:	68 87 00 00 00       	push   $0x87
  1059de:	e9 b7 f6 ff ff       	jmp    10509a <alltraps>

001059e3 <vector136>:
  1059e3:	6a 00                	push   $0x0
  1059e5:	68 88 00 00 00       	push   $0x88
  1059ea:	e9 ab f6 ff ff       	jmp    10509a <alltraps>

001059ef <vector137>:
  1059ef:	6a 00                	push   $0x0
  1059f1:	68 89 00 00 00       	push   $0x89
  1059f6:	e9 9f f6 ff ff       	jmp    10509a <alltraps>

001059fb <vector138>:
  1059fb:	6a 00                	push   $0x0
  1059fd:	68 8a 00 00 00       	push   $0x8a
  105a02:	e9 93 f6 ff ff       	jmp    10509a <alltraps>

00105a07 <vector139>:
  105a07:	6a 00                	push   $0x0
  105a09:	68 8b 00 00 00       	push   $0x8b
  105a0e:	e9 87 f6 ff ff       	jmp    10509a <alltraps>

00105a13 <vector140>:
  105a13:	6a 00                	push   $0x0
  105a15:	68 8c 00 00 00       	push   $0x8c
  105a1a:	e9 7b f6 ff ff       	jmp    10509a <alltraps>

00105a1f <vector141>:
  105a1f:	6a 00                	push   $0x0
  105a21:	68 8d 00 00 00       	push   $0x8d
  105a26:	e9 6f f6 ff ff       	jmp    10509a <alltraps>

00105a2b <vector142>:
  105a2b:	6a 00                	push   $0x0
  105a2d:	68 8e 00 00 00       	push   $0x8e
  105a32:	e9 63 f6 ff ff       	jmp    10509a <alltraps>

00105a37 <vector143>:
  105a37:	6a 00                	push   $0x0
  105a39:	68 8f 00 00 00       	push   $0x8f
  105a3e:	e9 57 f6 ff ff       	jmp    10509a <alltraps>

00105a43 <vector144>:
  105a43:	6a 00                	push   $0x0
  105a45:	68 90 00 00 00       	push   $0x90
  105a4a:	e9 4b f6 ff ff       	jmp    10509a <alltraps>

00105a4f <vector145>:
  105a4f:	6a 00                	push   $0x0
  105a51:	68 91 00 00 00       	push   $0x91
  105a56:	e9 3f f6 ff ff       	jmp    10509a <alltraps>

00105a5b <vector146>:
  105a5b:	6a 00                	push   $0x0
  105a5d:	68 92 00 00 00       	push   $0x92
  105a62:	e9 33 f6 ff ff       	jmp    10509a <alltraps>

00105a67 <vector147>:
  105a67:	6a 00                	push   $0x0
  105a69:	68 93 00 00 00       	push   $0x93
  105a6e:	e9 27 f6 ff ff       	jmp    10509a <alltraps>

00105a73 <vector148>:
  105a73:	6a 00                	push   $0x0
  105a75:	68 94 00 00 00       	push   $0x94
  105a7a:	e9 1b f6 ff ff       	jmp    10509a <alltraps>

00105a7f <vector149>:
  105a7f:	6a 00                	push   $0x0
  105a81:	68 95 00 00 00       	push   $0x95
  105a86:	e9 0f f6 ff ff       	jmp    10509a <alltraps>

00105a8b <vector150>:
  105a8b:	6a 00                	push   $0x0
  105a8d:	68 96 00 00 00       	push   $0x96
  105a92:	e9 03 f6 ff ff       	jmp    10509a <alltraps>

00105a97 <vector151>:
  105a97:	6a 00                	push   $0x0
  105a99:	68 97 00 00 00       	push   $0x97
  105a9e:	e9 f7 f5 ff ff       	jmp    10509a <alltraps>

00105aa3 <vector152>:
  105aa3:	6a 00                	push   $0x0
  105aa5:	68 98 00 00 00       	push   $0x98
  105aaa:	e9 eb f5 ff ff       	jmp    10509a <alltraps>

00105aaf <vector153>:
  105aaf:	6a 00                	push   $0x0
  105ab1:	68 99 00 00 00       	push   $0x99
  105ab6:	e9 df f5 ff ff       	jmp    10509a <alltraps>

00105abb <vector154>:
  105abb:	6a 00                	push   $0x0
  105abd:	68 9a 00 00 00       	push   $0x9a
  105ac2:	e9 d3 f5 ff ff       	jmp    10509a <alltraps>

00105ac7 <vector155>:
  105ac7:	6a 00                	push   $0x0
  105ac9:	68 9b 00 00 00       	push   $0x9b
  105ace:	e9 c7 f5 ff ff       	jmp    10509a <alltraps>

00105ad3 <vector156>:
  105ad3:	6a 00                	push   $0x0
  105ad5:	68 9c 00 00 00       	push   $0x9c
  105ada:	e9 bb f5 ff ff       	jmp    10509a <alltraps>

00105adf <vector157>:
  105adf:	6a 00                	push   $0x0
  105ae1:	68 9d 00 00 00       	push   $0x9d
  105ae6:	e9 af f5 ff ff       	jmp    10509a <alltraps>

00105aeb <vector158>:
  105aeb:	6a 00                	push   $0x0
  105aed:	68 9e 00 00 00       	push   $0x9e
  105af2:	e9 a3 f5 ff ff       	jmp    10509a <alltraps>

00105af7 <vector159>:
  105af7:	6a 00                	push   $0x0
  105af9:	68 9f 00 00 00       	push   $0x9f
  105afe:	e9 97 f5 ff ff       	jmp    10509a <alltraps>

00105b03 <vector160>:
  105b03:	6a 00                	push   $0x0
  105b05:	68 a0 00 00 00       	push   $0xa0
  105b0a:	e9 8b f5 ff ff       	jmp    10509a <alltraps>

00105b0f <vector161>:
  105b0f:	6a 00                	push   $0x0
  105b11:	68 a1 00 00 00       	push   $0xa1
  105b16:	e9 7f f5 ff ff       	jmp    10509a <alltraps>

00105b1b <vector162>:
  105b1b:	6a 00                	push   $0x0
  105b1d:	68 a2 00 00 00       	push   $0xa2
  105b22:	e9 73 f5 ff ff       	jmp    10509a <alltraps>

00105b27 <vector163>:
  105b27:	6a 00                	push   $0x0
  105b29:	68 a3 00 00 00       	push   $0xa3
  105b2e:	e9 67 f5 ff ff       	jmp    10509a <alltraps>

00105b33 <vector164>:
  105b33:	6a 00                	push   $0x0
  105b35:	68 a4 00 00 00       	push   $0xa4
  105b3a:	e9 5b f5 ff ff       	jmp    10509a <alltraps>

00105b3f <vector165>:
  105b3f:	6a 00                	push   $0x0
  105b41:	68 a5 00 00 00       	push   $0xa5
  105b46:	e9 4f f5 ff ff       	jmp    10509a <alltraps>

00105b4b <vector166>:
  105b4b:	6a 00                	push   $0x0
  105b4d:	68 a6 00 00 00       	push   $0xa6
  105b52:	e9 43 f5 ff ff       	jmp    10509a <alltraps>

00105b57 <vector167>:
  105b57:	6a 00                	push   $0x0
  105b59:	68 a7 00 00 00       	push   $0xa7
  105b5e:	e9 37 f5 ff ff       	jmp    10509a <alltraps>

00105b63 <vector168>:
  105b63:	6a 00                	push   $0x0
  105b65:	68 a8 00 00 00       	push   $0xa8
  105b6a:	e9 2b f5 ff ff       	jmp    10509a <alltraps>

00105b6f <vector169>:
  105b6f:	6a 00                	push   $0x0
  105b71:	68 a9 00 00 00       	push   $0xa9
  105b76:	e9 1f f5 ff ff       	jmp    10509a <alltraps>

00105b7b <vector170>:
  105b7b:	6a 00                	push   $0x0
  105b7d:	68 aa 00 00 00       	push   $0xaa
  105b82:	e9 13 f5 ff ff       	jmp    10509a <alltraps>

00105b87 <vector171>:
  105b87:	6a 00                	push   $0x0
  105b89:	68 ab 00 00 00       	push   $0xab
  105b8e:	e9 07 f5 ff ff       	jmp    10509a <alltraps>

00105b93 <vector172>:
  105b93:	6a 00                	push   $0x0
  105b95:	68 ac 00 00 00       	push   $0xac
  105b9a:	e9 fb f4 ff ff       	jmp    10509a <alltraps>

00105b9f <vector173>:
  105b9f:	6a 00                	push   $0x0
  105ba1:	68 ad 00 00 00       	push   $0xad
  105ba6:	e9 ef f4 ff ff       	jmp    10509a <alltraps>

00105bab <vector174>:
  105bab:	6a 00                	push   $0x0
  105bad:	68 ae 00 00 00       	push   $0xae
  105bb2:	e9 e3 f4 ff ff       	jmp    10509a <alltraps>

00105bb7 <vector175>:
  105bb7:	6a 00                	push   $0x0
  105bb9:	68 af 00 00 00       	push   $0xaf
  105bbe:	e9 d7 f4 ff ff       	jmp    10509a <alltraps>

00105bc3 <vector176>:
  105bc3:	6a 00                	push   $0x0
  105bc5:	68 b0 00 00 00       	push   $0xb0
  105bca:	e9 cb f4 ff ff       	jmp    10509a <alltraps>

00105bcf <vector177>:
  105bcf:	6a 00                	push   $0x0
  105bd1:	68 b1 00 00 00       	push   $0xb1
  105bd6:	e9 bf f4 ff ff       	jmp    10509a <alltraps>

00105bdb <vector178>:
  105bdb:	6a 00                	push   $0x0
  105bdd:	68 b2 00 00 00       	push   $0xb2
  105be2:	e9 b3 f4 ff ff       	jmp    10509a <alltraps>

00105be7 <vector179>:
  105be7:	6a 00                	push   $0x0
  105be9:	68 b3 00 00 00       	push   $0xb3
  105bee:	e9 a7 f4 ff ff       	jmp    10509a <alltraps>

00105bf3 <vector180>:
  105bf3:	6a 00                	push   $0x0
  105bf5:	68 b4 00 00 00       	push   $0xb4
  105bfa:	e9 9b f4 ff ff       	jmp    10509a <alltraps>

00105bff <vector181>:
  105bff:	6a 00                	push   $0x0
  105c01:	68 b5 00 00 00       	push   $0xb5
  105c06:	e9 8f f4 ff ff       	jmp    10509a <alltraps>

00105c0b <vector182>:
  105c0b:	6a 00                	push   $0x0
  105c0d:	68 b6 00 00 00       	push   $0xb6
  105c12:	e9 83 f4 ff ff       	jmp    10509a <alltraps>

00105c17 <vector183>:
  105c17:	6a 00                	push   $0x0
  105c19:	68 b7 00 00 00       	push   $0xb7
  105c1e:	e9 77 f4 ff ff       	jmp    10509a <alltraps>

00105c23 <vector184>:
  105c23:	6a 00                	push   $0x0
  105c25:	68 b8 00 00 00       	push   $0xb8
  105c2a:	e9 6b f4 ff ff       	jmp    10509a <alltraps>

00105c2f <vector185>:
  105c2f:	6a 00                	push   $0x0
  105c31:	68 b9 00 00 00       	push   $0xb9
  105c36:	e9 5f f4 ff ff       	jmp    10509a <alltraps>

00105c3b <vector186>:
  105c3b:	6a 00                	push   $0x0
  105c3d:	68 ba 00 00 00       	push   $0xba
  105c42:	e9 53 f4 ff ff       	jmp    10509a <alltraps>

00105c47 <vector187>:
  105c47:	6a 00                	push   $0x0
  105c49:	68 bb 00 00 00       	push   $0xbb
  105c4e:	e9 47 f4 ff ff       	jmp    10509a <alltraps>

00105c53 <vector188>:
  105c53:	6a 00                	push   $0x0
  105c55:	68 bc 00 00 00       	push   $0xbc
  105c5a:	e9 3b f4 ff ff       	jmp    10509a <alltraps>

00105c5f <vector189>:
  105c5f:	6a 00                	push   $0x0
  105c61:	68 bd 00 00 00       	push   $0xbd
  105c66:	e9 2f f4 ff ff       	jmp    10509a <alltraps>

00105c6b <vector190>:
  105c6b:	6a 00                	push   $0x0
  105c6d:	68 be 00 00 00       	push   $0xbe
  105c72:	e9 23 f4 ff ff       	jmp    10509a <alltraps>

00105c77 <vector191>:
  105c77:	6a 00                	push   $0x0
  105c79:	68 bf 00 00 00       	push   $0xbf
  105c7e:	e9 17 f4 ff ff       	jmp    10509a <alltraps>

00105c83 <vector192>:
  105c83:	6a 00                	push   $0x0
  105c85:	68 c0 00 00 00       	push   $0xc0
  105c8a:	e9 0b f4 ff ff       	jmp    10509a <alltraps>

00105c8f <vector193>:
  105c8f:	6a 00                	push   $0x0
  105c91:	68 c1 00 00 00       	push   $0xc1
  105c96:	e9 ff f3 ff ff       	jmp    10509a <alltraps>

00105c9b <vector194>:
  105c9b:	6a 00                	push   $0x0
  105c9d:	68 c2 00 00 00       	push   $0xc2
  105ca2:	e9 f3 f3 ff ff       	jmp    10509a <alltraps>

00105ca7 <vector195>:
  105ca7:	6a 00                	push   $0x0
  105ca9:	68 c3 00 00 00       	push   $0xc3
  105cae:	e9 e7 f3 ff ff       	jmp    10509a <alltraps>

00105cb3 <vector196>:
  105cb3:	6a 00                	push   $0x0
  105cb5:	68 c4 00 00 00       	push   $0xc4
  105cba:	e9 db f3 ff ff       	jmp    10509a <alltraps>

00105cbf <vector197>:
  105cbf:	6a 00                	push   $0x0
  105cc1:	68 c5 00 00 00       	push   $0xc5
  105cc6:	e9 cf f3 ff ff       	jmp    10509a <alltraps>

00105ccb <vector198>:
  105ccb:	6a 00                	push   $0x0
  105ccd:	68 c6 00 00 00       	push   $0xc6
  105cd2:	e9 c3 f3 ff ff       	jmp    10509a <alltraps>

00105cd7 <vector199>:
  105cd7:	6a 00                	push   $0x0
  105cd9:	68 c7 00 00 00       	push   $0xc7
  105cde:	e9 b7 f3 ff ff       	jmp    10509a <alltraps>

00105ce3 <vector200>:
  105ce3:	6a 00                	push   $0x0
  105ce5:	68 c8 00 00 00       	push   $0xc8
  105cea:	e9 ab f3 ff ff       	jmp    10509a <alltraps>

00105cef <vector201>:
  105cef:	6a 00                	push   $0x0
  105cf1:	68 c9 00 00 00       	push   $0xc9
  105cf6:	e9 9f f3 ff ff       	jmp    10509a <alltraps>

00105cfb <vector202>:
  105cfb:	6a 00                	push   $0x0
  105cfd:	68 ca 00 00 00       	push   $0xca
  105d02:	e9 93 f3 ff ff       	jmp    10509a <alltraps>

00105d07 <vector203>:
  105d07:	6a 00                	push   $0x0
  105d09:	68 cb 00 00 00       	push   $0xcb
  105d0e:	e9 87 f3 ff ff       	jmp    10509a <alltraps>

00105d13 <vector204>:
  105d13:	6a 00                	push   $0x0
  105d15:	68 cc 00 00 00       	push   $0xcc
  105d1a:	e9 7b f3 ff ff       	jmp    10509a <alltraps>

00105d1f <vector205>:
  105d1f:	6a 00                	push   $0x0
  105d21:	68 cd 00 00 00       	push   $0xcd
  105d26:	e9 6f f3 ff ff       	jmp    10509a <alltraps>

00105d2b <vector206>:
  105d2b:	6a 00                	push   $0x0
  105d2d:	68 ce 00 00 00       	push   $0xce
  105d32:	e9 63 f3 ff ff       	jmp    10509a <alltraps>

00105d37 <vector207>:
  105d37:	6a 00                	push   $0x0
  105d39:	68 cf 00 00 00       	push   $0xcf
  105d3e:	e9 57 f3 ff ff       	jmp    10509a <alltraps>

00105d43 <vector208>:
  105d43:	6a 00                	push   $0x0
  105d45:	68 d0 00 00 00       	push   $0xd0
  105d4a:	e9 4b f3 ff ff       	jmp    10509a <alltraps>

00105d4f <vector209>:
  105d4f:	6a 00                	push   $0x0
  105d51:	68 d1 00 00 00       	push   $0xd1
  105d56:	e9 3f f3 ff ff       	jmp    10509a <alltraps>

00105d5b <vector210>:
  105d5b:	6a 00                	push   $0x0
  105d5d:	68 d2 00 00 00       	push   $0xd2
  105d62:	e9 33 f3 ff ff       	jmp    10509a <alltraps>

00105d67 <vector211>:
  105d67:	6a 00                	push   $0x0
  105d69:	68 d3 00 00 00       	push   $0xd3
  105d6e:	e9 27 f3 ff ff       	jmp    10509a <alltraps>

00105d73 <vector212>:
  105d73:	6a 00                	push   $0x0
  105d75:	68 d4 00 00 00       	push   $0xd4
  105d7a:	e9 1b f3 ff ff       	jmp    10509a <alltraps>

00105d7f <vector213>:
  105d7f:	6a 00                	push   $0x0
  105d81:	68 d5 00 00 00       	push   $0xd5
  105d86:	e9 0f f3 ff ff       	jmp    10509a <alltraps>

00105d8b <vector214>:
  105d8b:	6a 00                	push   $0x0
  105d8d:	68 d6 00 00 00       	push   $0xd6
  105d92:	e9 03 f3 ff ff       	jmp    10509a <alltraps>

00105d97 <vector215>:
  105d97:	6a 00                	push   $0x0
  105d99:	68 d7 00 00 00       	push   $0xd7
  105d9e:	e9 f7 f2 ff ff       	jmp    10509a <alltraps>

00105da3 <vector216>:
  105da3:	6a 00                	push   $0x0
  105da5:	68 d8 00 00 00       	push   $0xd8
  105daa:	e9 eb f2 ff ff       	jmp    10509a <alltraps>

00105daf <vector217>:
  105daf:	6a 00                	push   $0x0
  105db1:	68 d9 00 00 00       	push   $0xd9
  105db6:	e9 df f2 ff ff       	jmp    10509a <alltraps>

00105dbb <vector218>:
  105dbb:	6a 00                	push   $0x0
  105dbd:	68 da 00 00 00       	push   $0xda
  105dc2:	e9 d3 f2 ff ff       	jmp    10509a <alltraps>

00105dc7 <vector219>:
  105dc7:	6a 00                	push   $0x0
  105dc9:	68 db 00 00 00       	push   $0xdb
  105dce:	e9 c7 f2 ff ff       	jmp    10509a <alltraps>

00105dd3 <vector220>:
  105dd3:	6a 00                	push   $0x0
  105dd5:	68 dc 00 00 00       	push   $0xdc
  105dda:	e9 bb f2 ff ff       	jmp    10509a <alltraps>

00105ddf <vector221>:
  105ddf:	6a 00                	push   $0x0
  105de1:	68 dd 00 00 00       	push   $0xdd
  105de6:	e9 af f2 ff ff       	jmp    10509a <alltraps>

00105deb <vector222>:
  105deb:	6a 00                	push   $0x0
  105ded:	68 de 00 00 00       	push   $0xde
  105df2:	e9 a3 f2 ff ff       	jmp    10509a <alltraps>

00105df7 <vector223>:
  105df7:	6a 00                	push   $0x0
  105df9:	68 df 00 00 00       	push   $0xdf
  105dfe:	e9 97 f2 ff ff       	jmp    10509a <alltraps>

00105e03 <vector224>:
  105e03:	6a 00                	push   $0x0
  105e05:	68 e0 00 00 00       	push   $0xe0
  105e0a:	e9 8b f2 ff ff       	jmp    10509a <alltraps>

00105e0f <vector225>:
  105e0f:	6a 00                	push   $0x0
  105e11:	68 e1 00 00 00       	push   $0xe1
  105e16:	e9 7f f2 ff ff       	jmp    10509a <alltraps>

00105e1b <vector226>:
  105e1b:	6a 00                	push   $0x0
  105e1d:	68 e2 00 00 00       	push   $0xe2
  105e22:	e9 73 f2 ff ff       	jmp    10509a <alltraps>

00105e27 <vector227>:
  105e27:	6a 00                	push   $0x0
  105e29:	68 e3 00 00 00       	push   $0xe3
  105e2e:	e9 67 f2 ff ff       	jmp    10509a <alltraps>

00105e33 <vector228>:
  105e33:	6a 00                	push   $0x0
  105e35:	68 e4 00 00 00       	push   $0xe4
  105e3a:	e9 5b f2 ff ff       	jmp    10509a <alltraps>

00105e3f <vector229>:
  105e3f:	6a 00                	push   $0x0
  105e41:	68 e5 00 00 00       	push   $0xe5
  105e46:	e9 4f f2 ff ff       	jmp    10509a <alltraps>

00105e4b <vector230>:
  105e4b:	6a 00                	push   $0x0
  105e4d:	68 e6 00 00 00       	push   $0xe6
  105e52:	e9 43 f2 ff ff       	jmp    10509a <alltraps>

00105e57 <vector231>:
  105e57:	6a 00                	push   $0x0
  105e59:	68 e7 00 00 00       	push   $0xe7
  105e5e:	e9 37 f2 ff ff       	jmp    10509a <alltraps>

00105e63 <vector232>:
  105e63:	6a 00                	push   $0x0
  105e65:	68 e8 00 00 00       	push   $0xe8
  105e6a:	e9 2b f2 ff ff       	jmp    10509a <alltraps>

00105e6f <vector233>:
  105e6f:	6a 00                	push   $0x0
  105e71:	68 e9 00 00 00       	push   $0xe9
  105e76:	e9 1f f2 ff ff       	jmp    10509a <alltraps>

00105e7b <vector234>:
  105e7b:	6a 00                	push   $0x0
  105e7d:	68 ea 00 00 00       	push   $0xea
  105e82:	e9 13 f2 ff ff       	jmp    10509a <alltraps>

00105e87 <vector235>:
  105e87:	6a 00                	push   $0x0
  105e89:	68 eb 00 00 00       	push   $0xeb
  105e8e:	e9 07 f2 ff ff       	jmp    10509a <alltraps>

00105e93 <vector236>:
  105e93:	6a 00                	push   $0x0
  105e95:	68 ec 00 00 00       	push   $0xec
  105e9a:	e9 fb f1 ff ff       	jmp    10509a <alltraps>

00105e9f <vector237>:
  105e9f:	6a 00                	push   $0x0
  105ea1:	68 ed 00 00 00       	push   $0xed
  105ea6:	e9 ef f1 ff ff       	jmp    10509a <alltraps>

00105eab <vector238>:
  105eab:	6a 00                	push   $0x0
  105ead:	68 ee 00 00 00       	push   $0xee
  105eb2:	e9 e3 f1 ff ff       	jmp    10509a <alltraps>

00105eb7 <vector239>:
  105eb7:	6a 00                	push   $0x0
  105eb9:	68 ef 00 00 00       	push   $0xef
  105ebe:	e9 d7 f1 ff ff       	jmp    10509a <alltraps>

00105ec3 <vector240>:
  105ec3:	6a 00                	push   $0x0
  105ec5:	68 f0 00 00 00       	push   $0xf0
  105eca:	e9 cb f1 ff ff       	jmp    10509a <alltraps>

00105ecf <vector241>:
  105ecf:	6a 00                	push   $0x0
  105ed1:	68 f1 00 00 00       	push   $0xf1
  105ed6:	e9 bf f1 ff ff       	jmp    10509a <alltraps>

00105edb <vector242>:
  105edb:	6a 00                	push   $0x0
  105edd:	68 f2 00 00 00       	push   $0xf2
  105ee2:	e9 b3 f1 ff ff       	jmp    10509a <alltraps>

00105ee7 <vector243>:
  105ee7:	6a 00                	push   $0x0
  105ee9:	68 f3 00 00 00       	push   $0xf3
  105eee:	e9 a7 f1 ff ff       	jmp    10509a <alltraps>

00105ef3 <vector244>:
  105ef3:	6a 00                	push   $0x0
  105ef5:	68 f4 00 00 00       	push   $0xf4
  105efa:	e9 9b f1 ff ff       	jmp    10509a <alltraps>

00105eff <vector245>:
  105eff:	6a 00                	push   $0x0
  105f01:	68 f5 00 00 00       	push   $0xf5
  105f06:	e9 8f f1 ff ff       	jmp    10509a <alltraps>

00105f0b <vector246>:
  105f0b:	6a 00                	push   $0x0
  105f0d:	68 f6 00 00 00       	push   $0xf6
  105f12:	e9 83 f1 ff ff       	jmp    10509a <alltraps>

00105f17 <vector247>:
  105f17:	6a 00                	push   $0x0
  105f19:	68 f7 00 00 00       	push   $0xf7
  105f1e:	e9 77 f1 ff ff       	jmp    10509a <alltraps>

00105f23 <vector248>:
  105f23:	6a 00                	push   $0x0
  105f25:	68 f8 00 00 00       	push   $0xf8
  105f2a:	e9 6b f1 ff ff       	jmp    10509a <alltraps>

00105f2f <vector249>:
  105f2f:	6a 00                	push   $0x0
  105f31:	68 f9 00 00 00       	push   $0xf9
  105f36:	e9 5f f1 ff ff       	jmp    10509a <alltraps>

00105f3b <vector250>:
  105f3b:	6a 00                	push   $0x0
  105f3d:	68 fa 00 00 00       	push   $0xfa
  105f42:	e9 53 f1 ff ff       	jmp    10509a <alltraps>

00105f47 <vector251>:
  105f47:	6a 00                	push   $0x0
  105f49:	68 fb 00 00 00       	push   $0xfb
  105f4e:	e9 47 f1 ff ff       	jmp    10509a <alltraps>

00105f53 <vector252>:
  105f53:	6a 00                	push   $0x0
  105f55:	68 fc 00 00 00       	push   $0xfc
  105f5a:	e9 3b f1 ff ff       	jmp    10509a <alltraps>

00105f5f <vector253>:
  105f5f:	6a 00                	push   $0x0
  105f61:	68 fd 00 00 00       	push   $0xfd
  105f66:	e9 2f f1 ff ff       	jmp    10509a <alltraps>

00105f6b <vector254>:
  105f6b:	6a 00                	push   $0x0
  105f6d:	68 fe 00 00 00       	push   $0xfe
  105f72:	e9 23 f1 ff ff       	jmp    10509a <alltraps>

00105f77 <vector255>:
  105f77:	6a 00                	push   $0x0
  105f79:	68 ff 00 00 00       	push   $0xff
  105f7e:	e9 17 f1 ff ff       	jmp    10509a <alltraps>
