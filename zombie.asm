
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 33 02 00 00       	call   249 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 bd 02 00 00       	call   2e1 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 25 02 00 00       	call   251 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	53                   	push   %ebx
  31:	8b 44 24 08          	mov    0x8(%esp),%eax
  35:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  39:	89 c2                	mov    %eax,%edx
  3b:	90                   	nop
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	c3                   	ret    
  53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	56                   	push   %esi
  61:	53                   	push   %ebx
  62:	8b 54 24 0c          	mov    0xc(%esp),%edx
  66:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1f                	jne    93 <strcmp+0x33>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  89:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  8d:	84 c0                	test   %al,%al
  8f:	74 0f                	je     a0 <strcmp+0x40>
  91:	89 f1                	mov    %esi,%ecx
  93:	38 d8                	cmp    %bl,%al
  95:	74 e9                	je     80 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  97:	29 d8                	sub    %ebx,%eax
}
  99:	5b                   	pop    %ebx
  9a:	5e                   	pop    %esi
  9b:	c3                   	ret    
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  a0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5e                   	pop    %esi
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b4:	80 39 00             	cmpb   $0x0,(%ecx)
  b7:	74 14                	je     cd <strlen+0x1d>
  b9:	31 d2                	xor    %edx,%edx
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
  cb:	f3 c3                	repz ret 
  cd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  cf:	c3                   	ret    

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	57                   	push   %edi
  d1:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  d9:	8b 44 24 0c          	mov    0xc(%esp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	c3                   	ret    
  e6:	8d 76 00             	lea    0x0(%esi),%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	53                   	push   %ebx
  f1:	8b 44 24 08          	mov    0x8(%esp),%eax
  f5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
  f9:	0f b6 10             	movzbl (%eax),%edx
  fc:	84 d2                	test   %dl,%dl
  fe:	74 1e                	je     11e <strchr+0x2e>
    if(*s == c)
 100:	38 d3                	cmp    %dl,%bl
 102:	89 d9                	mov    %ebx,%ecx
 104:	75 0e                	jne    114 <strchr+0x24>
 106:	eb 18                	jmp    120 <strchr+0x30>
 108:	90                   	nop
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 110:	38 ca                	cmp    %cl,%dl
 112:	74 0c                	je     120 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 114:	83 c0 01             	add    $0x1,%eax
 117:	0f b6 10             	movzbl (%eax),%edx
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 11e:	31 c0                	xor    %eax,%eax
}
 120:	5b                   	pop    %ebx
 121:	c3                   	ret    
 122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 132:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 1c             	sub    $0x1c,%esp
 139:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 13d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 141:	eb 2c                	jmp    16f <gets+0x3f>
 143:	90                   	nop
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 148:	83 ec 04             	sub    $0x4,%esp
 14b:	6a 01                	push   $0x1
 14d:	55                   	push   %ebp
 14e:	6a 00                	push   $0x0
 150:	e8 14 01 00 00       	call   269 <read>
    if(cc < 1)
 155:	83 c4 10             	add    $0x10,%esp
 158:	85 c0                	test   %eax,%eax
 15a:	7e 1c                	jle    178 <gets+0x48>
      break;
    buf[i++] = c;
 15c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 161:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 163:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 165:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 169:	74 25                	je     190 <gets+0x60>
 16b:	3c 0d                	cmp    $0xd,%al
 16d:	74 21                	je     190 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16f:	8d 5f 01             	lea    0x1(%edi),%ebx
 172:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 176:	7c d0                	jl     148 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 178:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 17c:	83 c4 1c             	add    $0x1c,%esp
 17f:	89 f0                	mov    %esi,%eax
 181:	5b                   	pop    %ebx
 182:	5e                   	pop    %esi
 183:	5f                   	pop    %edi
 184:	5d                   	pop    %ebp
 185:	c3                   	ret    
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 192:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 194:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 198:	83 c4 1c             	add    $0x1c,%esp
 19b:	5b                   	pop    %ebx
 19c:	5e                   	pop    %esi
 19d:	5f                   	pop    %edi
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <stat>:

int
stat(char *n, struct statv6 *st)
{
 1a0:	56                   	push   %esi
 1a1:	53                   	push   %ebx
 1a2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a5:	6a 00                	push   $0x0
 1a7:	ff 74 24 1c          	pushl  0x1c(%esp)
 1ab:	e8 e1 00 00 00       	call   291 <open>
  if(fd < 0)
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	85 c0                	test   %eax,%eax
 1b5:	78 29                	js     1e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1b7:	83 ec 08             	sub    $0x8,%esp
 1ba:	89 c3                	mov    %eax,%ebx
 1bc:	ff 74 24 1c          	pushl  0x1c(%esp)
 1c0:	50                   	push   %eax
 1c1:	e8 e3 00 00 00       	call   2a9 <fstat>
 1c6:	89 c6                	mov    %eax,%esi
  close(fd);
 1c8:	89 1c 24             	mov    %ebx,(%esp)
 1cb:	e8 a9 00 00 00       	call   279 <close>
  return r;
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	89 f0                	mov    %esi,%eax
}
 1d5:	83 c4 04             	add    $0x4,%esp
 1d8:	5b                   	pop    %ebx
 1d9:	5e                   	pop    %esi
 1da:	c3                   	ret    
 1db:	90                   	nop
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1e5:	eb ee                	jmp    1d5 <stat+0x35>
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1f0:	53                   	push   %ebx
 1f1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f5:	0f be 11             	movsbl (%ecx),%edx
 1f8:	8d 42 d0             	lea    -0x30(%edx),%eax
 1fb:	3c 09                	cmp    $0x9,%al
 1fd:	b8 00 00 00 00       	mov    $0x0,%eax
 202:	77 19                	ja     21d <atoi+0x2d>
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 208:	8d 04 80             	lea    (%eax,%eax,4),%eax
 20b:	83 c1 01             	add    $0x1,%ecx
 20e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 212:	0f be 11             	movsbl (%ecx),%edx
 215:	8d 5a d0             	lea    -0x30(%edx),%ebx
 218:	80 fb 09             	cmp    $0x9,%bl
 21b:	76 eb                	jbe    208 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 21d:	5b                   	pop    %ebx
 21e:	c3                   	ret    
 21f:	90                   	nop

00000220 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 220:	56                   	push   %esi
 221:	53                   	push   %ebx
 222:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 226:	8b 44 24 0c          	mov    0xc(%esp),%eax
 22a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 db                	test   %ebx,%ebx
 230:	7e 14                	jle    246 <memmove+0x26>
 232:	31 d2                	xor    %edx,%edx
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 238:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 23c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 23f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 242:	39 da                	cmp    %ebx,%edx
 244:	75 f2                	jne    238 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 246:	5b                   	pop    %ebx
 247:	5e                   	pop    %esi
 248:	c3                   	ret    

00000249 <fork>:
 249:	b8 01 00 00 00       	mov    $0x1,%eax
 24e:	cd 40                	int    $0x40
 250:	c3                   	ret    

00000251 <exit>:
 251:	b8 02 00 00 00       	mov    $0x2,%eax
 256:	cd 40                	int    $0x40
 258:	c3                   	ret    

00000259 <wait>:
 259:	b8 03 00 00 00       	mov    $0x3,%eax
 25e:	cd 40                	int    $0x40
 260:	c3                   	ret    

00000261 <pipe>:
 261:	b8 04 00 00 00       	mov    $0x4,%eax
 266:	cd 40                	int    $0x40
 268:	c3                   	ret    

00000269 <read>:
 269:	b8 06 00 00 00       	mov    $0x6,%eax
 26e:	cd 40                	int    $0x40
 270:	c3                   	ret    

00000271 <write>:
 271:	b8 05 00 00 00       	mov    $0x5,%eax
 276:	cd 40                	int    $0x40
 278:	c3                   	ret    

00000279 <close>:
 279:	b8 07 00 00 00       	mov    $0x7,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <kill>:
 281:	b8 08 00 00 00       	mov    $0x8,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <exec>:
 289:	b8 09 00 00 00       	mov    $0x9,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <open>:
 291:	b8 0a 00 00 00       	mov    $0xa,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <mknod>:
 299:	b8 0b 00 00 00       	mov    $0xb,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <unlink>:
 2a1:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <fstat>:
 2a9:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <link>:
 2b1:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <mkdir>:
 2b9:	b8 0f 00 00 00       	mov    $0xf,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <chdir>:
 2c1:	b8 10 00 00 00       	mov    $0x10,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <dup>:
 2c9:	b8 11 00 00 00       	mov    $0x11,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <getpid>:
 2d1:	b8 12 00 00 00       	mov    $0x12,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <sbrk>:
 2d9:	b8 13 00 00 00       	mov    $0x13,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <sleep>:
 2e1:	b8 14 00 00 00       	mov    $0x14,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    
 2e9:	66 90                	xchg   %ax,%ax
 2eb:	66 90                	xchg   %ax,%ax
 2ed:	66 90                	xchg   %ax,%ax
 2ef:	90                   	nop

000002f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2f0:	55                   	push   %ebp
 2f1:	57                   	push   %edi
 2f2:	89 c7                	mov    %eax,%edi
 2f4:	56                   	push   %esi
 2f5:	53                   	push   %ebx
 2f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2f9:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 2fd:	85 db                	test   %ebx,%ebx
 2ff:	74 77                	je     378 <printint+0x88>
 301:	89 d0                	mov    %edx,%eax
 303:	c1 e8 1f             	shr    $0x1f,%eax
 306:	84 c0                	test   %al,%al
 308:	74 6e                	je     378 <printint+0x88>
    neg = 1;
    x = -xx;
 30a:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 30c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 313:	00 
    x = -xx;
 314:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 316:	31 ed                	xor    %ebp,%ebp
 318:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 31c:	eb 04                	jmp    322 <printint+0x32>
 31e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 320:	89 f5                	mov    %esi,%ebp
 322:	31 d2                	xor    %edx,%edx
 324:	8d 75 01             	lea    0x1(%ebp),%esi
 327:	f7 f1                	div    %ecx
 329:	0f b6 92 c0 06 00 00 	movzbl 0x6c0(%edx),%edx
  }while((x /= base) != 0);
 330:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 332:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 335:	75 e9                	jne    320 <printint+0x30>
  if(neg)
 337:	8b 44 24 0c          	mov    0xc(%esp),%eax
 33b:	85 c0                	test   %eax,%eax
 33d:	74 08                	je     347 <printint+0x57>
    buf[i++] = '-';
 33f:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 344:	8d 75 02             	lea    0x2(%ebp),%esi
 347:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 34b:	90                   	nop
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 350:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 353:	83 ec 04             	sub    $0x4,%esp
 356:	83 ee 01             	sub    $0x1,%esi
 359:	88 44 24 23          	mov    %al,0x23(%esp)
 35d:	6a 01                	push   $0x1
 35f:	53                   	push   %ebx
 360:	57                   	push   %edi
 361:	e8 0b ff ff ff       	call   271 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 366:	83 c4 10             	add    $0x10,%esp
 369:	39 de                	cmp    %ebx,%esi
 36b:	75 e3                	jne    350 <printint+0x60>
    putc(fd, buf[i]);
}
 36d:	83 c4 3c             	add    $0x3c,%esp
 370:	5b                   	pop    %ebx
 371:	5e                   	pop    %esi
 372:	5f                   	pop    %edi
 373:	5d                   	pop    %ebp
 374:	c3                   	ret    
 375:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 378:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 37a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 381:	00 
 382:	eb 92                	jmp    316 <printint+0x26>
 384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 38a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000390 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 390:	55                   	push   %ebp
 391:	57                   	push   %edi
 392:	56                   	push   %esi
 393:	53                   	push   %ebx
 394:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 397:	8b 74 24 44          	mov    0x44(%esp),%esi
 39b:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 39f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3a7:	0f b6 1e             	movzbl (%esi),%ebx
 3aa:	83 c6 01             	add    $0x1,%esi
 3ad:	84 db                	test   %bl,%bl
 3af:	0f 84 ad 00 00 00    	je     462 <printf+0xd2>
 3b5:	31 ed                	xor    %ebp,%ebp
 3b7:	eb 32                	jmp    3eb <printf+0x5b>
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3c0:	83 f8 25             	cmp    $0x25,%eax
 3c3:	0f 84 a7 00 00 00    	je     470 <printf+0xe0>
 3c9:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3cd:	83 ec 04             	sub    $0x4,%esp
 3d0:	6a 01                	push   $0x1
 3d2:	8d 44 24 22          	lea    0x22(%esp),%eax
 3d6:	50                   	push   %eax
 3d7:	57                   	push   %edi
 3d8:	e8 94 fe ff ff       	call   271 <write>
 3dd:	83 c4 10             	add    $0x10,%esp
 3e0:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3e7:	84 db                	test   %bl,%bl
 3e9:	74 77                	je     462 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 3eb:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 3ed:	0f be cb             	movsbl %bl,%ecx
 3f0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3f3:	74 cb                	je     3c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3f5:	83 fd 25             	cmp    $0x25,%ebp
 3f8:	75 e6                	jne    3e0 <printf+0x50>
      if(c == 'd'){
 3fa:	83 f8 64             	cmp    $0x64,%eax
 3fd:	0f 84 15 01 00 00    	je     518 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 403:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 409:	83 f9 70             	cmp    $0x70,%ecx
 40c:	74 72                	je     480 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 40e:	83 f8 73             	cmp    $0x73,%eax
 411:	0f 84 99 00 00 00    	je     4b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 417:	83 f8 63             	cmp    $0x63,%eax
 41a:	0f 84 07 01 00 00    	je     527 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 420:	83 f8 25             	cmp    $0x25,%eax
 423:	0f 84 d7 00 00 00    	je     500 <printf+0x170>
 429:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 42e:	83 ec 04             	sub    $0x4,%esp
 431:	6a 01                	push   $0x1
 433:	8d 44 24 27          	lea    0x27(%esp),%eax
 437:	50                   	push   %eax
 438:	57                   	push   %edi
 439:	e8 33 fe ff ff       	call   271 <write>
 43e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 442:	83 c4 0c             	add    $0xc,%esp
 445:	6a 01                	push   $0x1
 447:	8d 44 24 26          	lea    0x26(%esp),%eax
 44b:	50                   	push   %eax
 44c:	57                   	push   %edi
 44d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 450:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 452:	e8 1a fe ff ff       	call   271 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 457:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 45b:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 45e:	84 db                	test   %bl,%bl
 460:	75 89                	jne    3eb <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 462:	83 c4 2c             	add    $0x2c,%esp
 465:	5b                   	pop    %ebx
 466:	5e                   	pop    %esi
 467:	5f                   	pop    %edi
 468:	5d                   	pop    %ebp
 469:	c3                   	ret    
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 470:	bd 25 00 00 00       	mov    $0x25,%ebp
 475:	e9 66 ff ff ff       	jmp    3e0 <printf+0x50>
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	b9 10 00 00 00       	mov    $0x10,%ecx
 488:	6a 00                	push   $0x0
 48a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 48e:	89 f8                	mov    %edi,%eax
 490:	8b 13                	mov    (%ebx),%edx
 492:	e8 59 fe ff ff       	call   2f0 <printint>
        ap++;
 497:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 499:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 49b:	83 c0 04             	add    $0x4,%eax
 49e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 4a2:	83 c4 10             	add    $0x10,%esp
 4a5:	e9 36 ff ff ff       	jmp    3e0 <printf+0x50>
 4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4b0:	8b 44 24 0c          	mov    0xc(%esp),%eax
 4b4:	8b 28                	mov    (%eax),%ebp
        ap++;
 4b6:	83 c0 04             	add    $0x4,%eax
 4b9:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 4bd:	b8 b8 06 00 00       	mov    $0x6b8,%eax
 4c2:	85 ed                	test   %ebp,%ebp
 4c4:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 4c7:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 4cb:	84 c0                	test   %al,%al
 4cd:	74 27                	je     4f6 <printf+0x166>
 4cf:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 4d3:	90                   	nop
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4d8:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4dc:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4df:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e2:	6a 01                	push   $0x1
 4e4:	53                   	push   %ebx
 4e5:	57                   	push   %edi
 4e6:	e8 86 fd ff ff       	call   271 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4eb:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 4ef:	83 c4 10             	add    $0x10,%esp
 4f2:	84 c0                	test   %al,%al
 4f4:	75 e2                	jne    4d8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f6:	31 ed                	xor    %ebp,%ebp
 4f8:	e9 e3 fe ff ff       	jmp    3e0 <printf+0x50>
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 504:	83 ec 04             	sub    $0x4,%esp
 507:	6a 01                	push   $0x1
 509:	8d 44 24 25          	lea    0x25(%esp),%eax
 50d:	e9 39 ff ff ff       	jmp    44b <printf+0xbb>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 518:	83 ec 0c             	sub    $0xc,%esp
 51b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 520:	6a 01                	push   $0x1
 522:	e9 63 ff ff ff       	jmp    48a <printf+0xfa>
 527:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	8b 03                	mov    (%ebx),%eax
 530:	88 44 24 20          	mov    %al,0x20(%esp)
 534:	6a 01                	push   $0x1
 536:	8d 44 24 24          	lea    0x24(%esp),%eax
 53a:	50                   	push   %eax
 53b:	57                   	push   %edi
 53c:	e8 30 fd ff ff       	call   271 <write>
 541:	e9 51 ff ff ff       	jmp    497 <printf+0x107>
 546:	66 90                	xchg   %ax,%ax
 548:	66 90                	xchg   %ax,%ax
 54a:	66 90                	xchg   %ax,%ax
 54c:	66 90                	xchg   %ax,%ax
 54e:	66 90                	xchg   %ax,%ax

00000550 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 550:	57                   	push   %edi
 551:	56                   	push   %esi
 552:	53                   	push   %ebx
 553:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 557:	a1 fc 09 00 00       	mov    0x9fc,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 55c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55f:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	39 c8                	cmp    %ecx,%eax
 563:	73 13                	jae    578 <free+0x28>
 565:	8d 76 00             	lea    0x0(%esi),%esi
 568:	39 d1                	cmp    %edx,%ecx
 56a:	72 14                	jb     580 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56c:	39 d0                	cmp    %edx,%eax
 56e:	73 10                	jae    580 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 572:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 574:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 576:	72 f0                	jb     568 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 578:	39 d0                	cmp    %edx,%eax
 57a:	72 f4                	jb     570 <free+0x20>
 57c:	39 d1                	cmp    %edx,%ecx
 57e:	73 f0                	jae    570 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 580:	8b 73 fc             	mov    -0x4(%ebx),%esi
 583:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 586:	39 d7                	cmp    %edx,%edi
 588:	74 18                	je     5a2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 58a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 58d:	8b 50 04             	mov    0x4(%eax),%edx
 590:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 593:	39 f1                	cmp    %esi,%ecx
 595:	74 20                	je     5b7 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 597:	89 08                	mov    %ecx,(%eax)
  freep = p;
 599:	a3 fc 09 00 00       	mov    %eax,0x9fc
}
 59e:	5b                   	pop    %ebx
 59f:	5e                   	pop    %esi
 5a0:	5f                   	pop    %edi
 5a1:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5a2:	03 72 04             	add    0x4(%edx),%esi
 5a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a8:	8b 12                	mov    (%edx),%edx
 5aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5ad:	8b 50 04             	mov    0x4(%eax),%edx
 5b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5b3:	39 f1                	cmp    %esi,%ecx
 5b5:	75 e0                	jne    597 <free+0x47>
    p->s.size += bp->s.size;
 5b7:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5ba:	a3 fc 09 00 00       	mov    %eax,0x9fc
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 5bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5c5:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5c7:	5b                   	pop    %ebx
 5c8:	5e                   	pop    %esi
 5c9:	5f                   	pop    %edi
 5ca:	c3                   	ret    
 5cb:	90                   	nop
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5d0:	57                   	push   %edi
 5d1:	56                   	push   %esi
 5d2:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d3:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 5d7:	8b 15 fc 09 00 00    	mov    0x9fc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5dd:	8d 78 07             	lea    0x7(%eax),%edi
 5e0:	c1 ef 03             	shr    $0x3,%edi
 5e3:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 5e6:	85 d2                	test   %edx,%edx
 5e8:	0f 84 a0 00 00 00    	je     68e <malloc+0xbe>
 5ee:	8b 02                	mov    (%edx),%eax
 5f0:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5f3:	39 cf                	cmp    %ecx,%edi
 5f5:	76 71                	jbe    668 <malloc+0x98>
 5f7:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 5fd:	be 00 10 00 00       	mov    $0x1000,%esi
 602:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 609:	0f 43 f7             	cmovae %edi,%esi
 60c:	ba 00 80 00 00       	mov    $0x8000,%edx
 611:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 617:	0f 46 da             	cmovbe %edx,%ebx
 61a:	eb 0d                	jmp    629 <malloc+0x59>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 620:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 622:	8b 48 04             	mov    0x4(%eax),%ecx
 625:	39 cf                	cmp    %ecx,%edi
 627:	76 3f                	jbe    668 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 629:	39 05 fc 09 00 00    	cmp    %eax,0x9fc
 62f:	89 c2                	mov    %eax,%edx
 631:	75 ed                	jne    620 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 633:	83 ec 0c             	sub    $0xc,%esp
 636:	53                   	push   %ebx
 637:	e8 9d fc ff ff       	call   2d9 <sbrk>
  if(p == (char*) -1)
 63c:	83 c4 10             	add    $0x10,%esp
 63f:	83 f8 ff             	cmp    $0xffffffff,%eax
 642:	74 1c                	je     660 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 644:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 647:	83 ec 0c             	sub    $0xc,%esp
 64a:	83 c0 08             	add    $0x8,%eax
 64d:	50                   	push   %eax
 64e:	e8 fd fe ff ff       	call   550 <free>
  return freep;
 653:	8b 15 fc 09 00 00    	mov    0x9fc,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 659:	83 c4 10             	add    $0x10,%esp
 65c:	85 d2                	test   %edx,%edx
 65e:	75 c0                	jne    620 <malloc+0x50>
        return 0;
 660:	31 c0                	xor    %eax,%eax
 662:	eb 1c                	jmp    680 <malloc+0xb0>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 668:	39 cf                	cmp    %ecx,%edi
 66a:	74 1c                	je     688 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 66c:	29 f9                	sub    %edi,%ecx
 66e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 671:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 674:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 677:	89 15 fc 09 00 00    	mov    %edx,0x9fc
      return (void*) (p + 1);
 67d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 680:	5b                   	pop    %ebx
 681:	5e                   	pop    %esi
 682:	5f                   	pop    %edi
 683:	c3                   	ret    
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 688:	8b 08                	mov    (%eax),%ecx
 68a:	89 0a                	mov    %ecx,(%edx)
 68c:	eb e9                	jmp    677 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 68e:	c7 05 fc 09 00 00 00 	movl   $0xa00,0x9fc
 695:	0a 00 00 
 698:	c7 05 00 0a 00 00 00 	movl   $0xa00,0xa00
 69f:	0a 00 00 
    base.s.size = 0;
 6a2:	b8 00 0a 00 00       	mov    $0xa00,%eax
 6a7:	c7 05 04 0a 00 00 00 	movl   $0x0,0xa04
 6ae:	00 00 00 
 6b1:	e9 41 ff ff ff       	jmp    5f7 <malloc+0x27>
