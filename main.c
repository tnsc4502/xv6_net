#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

__thread struct cpu *c;
__thread struct proc *cp;

static void bootothers(void);
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  mpinit(); // collect info about this machine
  lapicinit(mpbcpu());
  ksegment();
  picinit();       // interrupt controller
  ioapicinit();    // another interrupt controller
  consoleinit();   // I/O devices & their interrupts
  uartinit();      // serial port
  cprintf("\ncpu%d: starting xv6\n\n", cpu());

  kinit();         // physical memory allocator
  pinit();         // process table
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  iinit();         // inode cache
  ideinit();       // disk

  //ethinit();       // ethernet
  if(!ismp)
    timerinit();   // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
}

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  if(cpu() != mpbcpu())
    lapicinit(cpu());
  ksegment();
  cprintf("cpu%d: mpmain\n", cpu());
  idtinit();
  xchg(&c->booted, 1);

  cprintf("cpu%d: scheduling\n", cpu());
  scheduler();
}

static void
bootothers(void)
{
  extern uchar _binary_bootother_start[], _binary_bootother_size[];
  uchar *code;
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpu())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
    lapicstartap(c->apicid, (uint)code);

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
      ;
  }
}

