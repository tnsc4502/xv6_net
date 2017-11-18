
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid, fd;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 b8 07 00 00       	push   $0x7b8
  19:	e8 73 03 00 00       	call   391 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 d6 00 00 00    	js     ff <main+0xff>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 96 03 00 00       	call   3c9 <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 8a 03 00 00       	call   3c9 <dup>
  fd = open("eth", O_RDWR);
  3f:	58                   	pop    %eax
  40:	5a                   	pop    %edx
  41:	6a 02                	push   $0x2
  43:	68 c0 07 00 00       	push   $0x7c0
  48:	e8 44 03 00 00       	call   391 <open>
  if (fd < 0)
  4d:	83 c4 10             	add    $0x10,%esp
  50:	85 c0                	test   %eax,%eax
  52:	0f 88 90 00 00 00    	js     e8 <main+0xe8>
    mknod("eth", 2, 0);
  else
    close(fd);
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	50                   	push   %eax
  5c:	e8 18 03 00 00       	call   379 <close>
  61:	83 c4 10             	add    $0x10,%esp
  64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  68:	83 ec 08             	sub    $0x8,%esp
  6b:	68 c4 07 00 00       	push   $0x7c4
  70:	6a 01                	push   $0x1
  72:	e8 19 04 00 00       	call   490 <printf>
    pid = fork();
  77:	e8 cd 02 00 00       	call   349 <fork>
    if(pid < 0){
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	85 c0                	test   %eax,%eax
  else
    close(fd);

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
  81:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  83:	78 2c                	js     b1 <main+0xb1>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  85:	74 3d                	je     c4 <main+0xc4>
  87:	89 f6                	mov    %esi,%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  90:	e8 c4 02 00 00       	call   359 <wait>
  95:	85 c0                	test   %eax,%eax
  97:	78 cf                	js     68 <main+0x68>
  99:	39 c3                	cmp    %eax,%ebx
  9b:	74 cb                	je     68 <main+0x68>
      printf(1, "zombie!\n");
  9d:	83 ec 08             	sub    $0x8,%esp
  a0:	68 03 08 00 00       	push   $0x803
  a5:	6a 01                	push   $0x1
  a7:	e8 e4 03 00 00       	call   490 <printf>
  ac:	83 c4 10             	add    $0x10,%esp
  af:	eb df                	jmp    90 <main+0x90>

  for(;;){
    printf(1, "init: starting sh\n");
    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
  b1:	53                   	push   %ebx
  b2:	53                   	push   %ebx
  b3:	68 d7 07 00 00       	push   $0x7d7
  b8:	6a 01                	push   $0x1
  ba:	e8 d1 03 00 00       	call   490 <printf>
      exit();
  bf:	e8 8d 02 00 00       	call   351 <exit>
    }
    if(pid == 0){
      exec("sh", argv);
  c4:	50                   	push   %eax
  c5:	50                   	push   %eax
  c6:	68 54 0b 00 00       	push   $0xb54
  cb:	68 ea 07 00 00       	push   $0x7ea
  d0:	e8 b4 02 00 00       	call   389 <exec>
      printf(1, "init: exec sh failed\n");
  d5:	5a                   	pop    %edx
  d6:	59                   	pop    %ecx
  d7:	68 ed 07 00 00       	push   $0x7ed
  dc:	6a 01                	push   $0x1
  de:	e8 ad 03 00 00       	call   490 <printf>
      exit();
  e3:	e8 69 02 00 00       	call   351 <exit>
  }
  dup(0);  // stdout
  dup(0);  // stderr
  fd = open("eth", O_RDWR);
  if (fd < 0)
    mknod("eth", 2, 0);
  e8:	50                   	push   %eax
  e9:	6a 00                	push   $0x0
  eb:	6a 02                	push   $0x2
  ed:	68 c0 07 00 00       	push   $0x7c0
  f2:	e8 a2 02 00 00       	call   399 <mknod>
  f7:	83 c4 10             	add    $0x10,%esp
  fa:	e9 69 ff ff ff       	jmp    68 <main+0x68>
main(void)
{
  int pid, wpid, fd;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
  ff:	51                   	push   %ecx
 100:	6a 01                	push   $0x1
 102:	6a 01                	push   $0x1
 104:	68 b8 07 00 00       	push   $0x7b8
 109:	e8 8b 02 00 00       	call   399 <mknod>
    open("console", O_RDWR);
 10e:	5b                   	pop    %ebx
 10f:	58                   	pop    %eax
 110:	6a 02                	push   $0x2
 112:	68 b8 07 00 00       	push   $0x7b8
 117:	e8 75 02 00 00       	call   391 <open>
 11c:	83 c4 10             	add    $0x10,%esp
 11f:	e9 05 ff ff ff       	jmp    29 <main+0x29>
 124:	66 90                	xchg   %ax,%ax
 126:	66 90                	xchg   %ax,%ax
 128:	66 90                	xchg   %ax,%ax
 12a:	66 90                	xchg   %ax,%ax
 12c:	66 90                	xchg   %ax,%ax
 12e:	66 90                	xchg   %ax,%ax

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 130:	53                   	push   %ebx
 131:	8b 44 24 08          	mov    0x8(%esp),%eax
 135:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 139:	89 c2                	mov    %eax,%edx
 13b:	90                   	nop
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 140:	83 c1 01             	add    $0x1,%ecx
 143:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 147:	83 c2 01             	add    $0x1,%edx
 14a:	84 db                	test   %bl,%bl
 14c:	88 5a ff             	mov    %bl,-0x1(%edx)
 14f:	75 ef                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 151:	5b                   	pop    %ebx
 152:	c3                   	ret    
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	56                   	push   %esi
 161:	53                   	push   %ebx
 162:	8b 54 24 0c          	mov    0xc(%esp),%edx
 166:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 16a:	0f b6 02             	movzbl (%edx),%eax
 16d:	0f b6 19             	movzbl (%ecx),%ebx
 170:	84 c0                	test   %al,%al
 172:	75 1f                	jne    193 <strcmp+0x33>
 174:	eb 2a                	jmp    1a0 <strcmp+0x40>
 176:	8d 76 00             	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 180:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 183:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 186:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 189:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 18d:	84 c0                	test   %al,%al
 18f:	74 0f                	je     1a0 <strcmp+0x40>
 191:	89 f1                	mov    %esi,%ecx
 193:	38 d8                	cmp    %bl,%al
 195:	74 e9                	je     180 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 197:	29 d8                	sub    %ebx,%eax
}
 199:	5b                   	pop    %ebx
 19a:	5e                   	pop    %esi
 19b:	c3                   	ret    
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1a2:	29 d8                	sub    %ebx,%eax
}
 1a4:	5b                   	pop    %ebx
 1a5:	5e                   	pop    %esi
 1a6:	c3                   	ret    
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <strlen>:

uint
strlen(char *s)
{
 1b0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b4:	80 39 00             	cmpb   $0x0,(%ecx)
 1b7:	74 14                	je     1cd <strlen+0x1d>
 1b9:	31 d2                	xor    %edx,%edx
 1bb:	90                   	nop
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
 1cb:	f3 c3                	repz ret 
 1cd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1cf:	c3                   	ret    

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	57                   	push   %edi
 1d1:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 1d9:	8b 44 24 0c          	mov    0xc(%esp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld    
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	89 d0                	mov    %edx,%eax
 1e4:	5f                   	pop    %edi
 1e5:	c3                   	ret    
 1e6:	8d 76 00             	lea    0x0(%esi),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	53                   	push   %ebx
 1f1:	8b 44 24 08          	mov    0x8(%esp),%eax
 1f5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 1f9:	0f b6 10             	movzbl (%eax),%edx
 1fc:	84 d2                	test   %dl,%dl
 1fe:	74 1e                	je     21e <strchr+0x2e>
    if(*s == c)
 200:	38 d3                	cmp    %dl,%bl
 202:	89 d9                	mov    %ebx,%ecx
 204:	75 0e                	jne    214 <strchr+0x24>
 206:	eb 18                	jmp    220 <strchr+0x30>
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 210:	38 ca                	cmp    %cl,%dl
 212:	74 0c                	je     220 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 214:	83 c0 01             	add    $0x1,%eax
 217:	0f b6 10             	movzbl (%eax),%edx
 21a:	84 d2                	test   %dl,%dl
 21c:	75 f2                	jne    210 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 21e:	31 c0                	xor    %eax,%eax
}
 220:	5b                   	pop    %ebx
 221:	c3                   	ret    
 222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 232:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
 236:	83 ec 1c             	sub    $0x1c,%esp
 239:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 23d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 241:	eb 2c                	jmp    26f <gets+0x3f>
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 248:	83 ec 04             	sub    $0x4,%esp
 24b:	6a 01                	push   $0x1
 24d:	55                   	push   %ebp
 24e:	6a 00                	push   $0x0
 250:	e8 14 01 00 00       	call   369 <read>
    if(cc < 1)
 255:	83 c4 10             	add    $0x10,%esp
 258:	85 c0                	test   %eax,%eax
 25a:	7e 1c                	jle    278 <gets+0x48>
      break;
    buf[i++] = c;
 25c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 261:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 263:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 265:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 269:	74 25                	je     290 <gets+0x60>
 26b:	3c 0d                	cmp    $0xd,%al
 26d:	74 21                	je     290 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26f:	8d 5f 01             	lea    0x1(%edi),%ebx
 272:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 276:	7c d0                	jl     248 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 278:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 27c:	83 c4 1c             	add    $0x1c,%esp
 27f:	89 f0                	mov    %esi,%eax
 281:	5b                   	pop    %ebx
 282:	5e                   	pop    %esi
 283:	5f                   	pop    %edi
 284:	5d                   	pop    %ebp
 285:	c3                   	ret    
 286:	8d 76 00             	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 290:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 292:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 294:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 298:	83 c4 1c             	add    $0x1c,%esp
 29b:	5b                   	pop    %ebx
 29c:	5e                   	pop    %esi
 29d:	5f                   	pop    %edi
 29e:	5d                   	pop    %ebp
 29f:	c3                   	ret    

000002a0 <stat>:

int
stat(char *n, struct statv6 *st)
{
 2a0:	56                   	push   %esi
 2a1:	53                   	push   %ebx
 2a2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	6a 00                	push   $0x0
 2a7:	ff 74 24 1c          	pushl  0x1c(%esp)
 2ab:	e8 e1 00 00 00       	call   391 <open>
  if(fd < 0)
 2b0:	83 c4 10             	add    $0x10,%esp
 2b3:	85 c0                	test   %eax,%eax
 2b5:	78 29                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b7:	83 ec 08             	sub    $0x8,%esp
 2ba:	89 c3                	mov    %eax,%ebx
 2bc:	ff 74 24 1c          	pushl  0x1c(%esp)
 2c0:	50                   	push   %eax
 2c1:	e8 e3 00 00 00       	call   3a9 <fstat>
 2c6:	89 c6                	mov    %eax,%esi
  close(fd);
 2c8:	89 1c 24             	mov    %ebx,(%esp)
 2cb:	e8 a9 00 00 00       	call   379 <close>
  return r;
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	89 f0                	mov    %esi,%eax
}
 2d5:	83 c4 04             	add    $0x4,%esp
 2d8:	5b                   	pop    %ebx
 2d9:	5e                   	pop    %esi
 2da:	c3                   	ret    
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2e5:	eb ee                	jmp    2d5 <stat+0x35>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2f0:	53                   	push   %ebx
 2f1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f5:	0f be 11             	movsbl (%ecx),%edx
 2f8:	8d 42 d0             	lea    -0x30(%edx),%eax
 2fb:	3c 09                	cmp    $0x9,%al
 2fd:	b8 00 00 00 00       	mov    $0x0,%eax
 302:	77 19                	ja     31d <atoi+0x2d>
 304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 308:	8d 04 80             	lea    (%eax,%eax,4),%eax
 30b:	83 c1 01             	add    $0x1,%ecx
 30e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 312:	0f be 11             	movsbl (%ecx),%edx
 315:	8d 5a d0             	lea    -0x30(%edx),%ebx
 318:	80 fb 09             	cmp    $0x9,%bl
 31b:	76 eb                	jbe    308 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 31d:	5b                   	pop    %ebx
 31e:	c3                   	ret    
 31f:	90                   	nop

00000320 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	56                   	push   %esi
 321:	53                   	push   %ebx
 322:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 326:	8b 44 24 0c          	mov    0xc(%esp),%eax
 32a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 db                	test   %ebx,%ebx
 330:	7e 14                	jle    346 <memmove+0x26>
 332:	31 d2                	xor    %edx,%edx
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 338:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 33c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 342:	39 da                	cmp    %ebx,%edx
 344:	75 f2                	jne    338 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	c3                   	ret    

00000349 <fork>:
 349:	b8 01 00 00 00       	mov    $0x1,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <exit>:
 351:	b8 02 00 00 00       	mov    $0x2,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <wait>:
 359:	b8 03 00 00 00       	mov    $0x3,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <pipe>:
 361:	b8 04 00 00 00       	mov    $0x4,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <read>:
 369:	b8 06 00 00 00       	mov    $0x6,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <write>:
 371:	b8 05 00 00 00       	mov    $0x5,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    

00000379 <close>:
 379:	b8 07 00 00 00       	mov    $0x7,%eax
 37e:	cd 40                	int    $0x40
 380:	c3                   	ret    

00000381 <kill>:
 381:	b8 08 00 00 00       	mov    $0x8,%eax
 386:	cd 40                	int    $0x40
 388:	c3                   	ret    

00000389 <exec>:
 389:	b8 09 00 00 00       	mov    $0x9,%eax
 38e:	cd 40                	int    $0x40
 390:	c3                   	ret    

00000391 <open>:
 391:	b8 0a 00 00 00       	mov    $0xa,%eax
 396:	cd 40                	int    $0x40
 398:	c3                   	ret    

00000399 <mknod>:
 399:	b8 0b 00 00 00       	mov    $0xb,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <unlink>:
 3a1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <fstat>:
 3a9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <link>:
 3b1:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <mkdir>:
 3b9:	b8 0f 00 00 00       	mov    $0xf,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <chdir>:
 3c1:	b8 10 00 00 00       	mov    $0x10,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <dup>:
 3c9:	b8 11 00 00 00       	mov    $0x11,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <getpid>:
 3d1:	b8 12 00 00 00       	mov    $0x12,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <sbrk>:
 3d9:	b8 13 00 00 00       	mov    $0x13,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <sleep>:
 3e1:	b8 14 00 00 00       	mov    $0x14,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    
 3e9:	66 90                	xchg   %ax,%ax
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	90                   	nop

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	57                   	push   %edi
 3f2:	89 c7                	mov    %eax,%edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3f9:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 3fd:	85 db                	test   %ebx,%ebx
 3ff:	74 77                	je     478 <printint+0x88>
 401:	89 d0                	mov    %edx,%eax
 403:	c1 e8 1f             	shr    $0x1f,%eax
 406:	84 c0                	test   %al,%al
 408:	74 6e                	je     478 <printint+0x88>
    neg = 1;
    x = -xx;
 40a:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 40c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 413:	00 
    x = -xx;
 414:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 416:	31 ed                	xor    %ebp,%ebp
 418:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 41c:	eb 04                	jmp    422 <printint+0x32>
 41e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 420:	89 f5                	mov    %esi,%ebp
 422:	31 d2                	xor    %edx,%edx
 424:	8d 75 01             	lea    0x1(%ebp),%esi
 427:	f7 f1                	div    %ecx
 429:	0f b6 92 14 08 00 00 	movzbl 0x814(%edx),%edx
  }while((x /= base) != 0);
 430:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 432:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 435:	75 e9                	jne    420 <printint+0x30>
  if(neg)
 437:	8b 44 24 0c          	mov    0xc(%esp),%eax
 43b:	85 c0                	test   %eax,%eax
 43d:	74 08                	je     447 <printint+0x57>
    buf[i++] = '-';
 43f:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 444:	8d 75 02             	lea    0x2(%ebp),%esi
 447:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 44b:	90                   	nop
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 450:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 453:	83 ec 04             	sub    $0x4,%esp
 456:	83 ee 01             	sub    $0x1,%esi
 459:	88 44 24 23          	mov    %al,0x23(%esp)
 45d:	6a 01                	push   $0x1
 45f:	53                   	push   %ebx
 460:	57                   	push   %edi
 461:	e8 0b ff ff ff       	call   371 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 466:	83 c4 10             	add    $0x10,%esp
 469:	39 de                	cmp    %ebx,%esi
 46b:	75 e3                	jne    450 <printint+0x60>
    putc(fd, buf[i]);
}
 46d:	83 c4 3c             	add    $0x3c,%esp
 470:	5b                   	pop    %ebx
 471:	5e                   	pop    %esi
 472:	5f                   	pop    %edi
 473:	5d                   	pop    %ebp
 474:	c3                   	ret    
 475:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 478:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 47a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 481:	00 
 482:	eb 92                	jmp    416 <printint+0x26>
 484:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 48a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000490 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	57                   	push   %edi
 492:	56                   	push   %esi
 493:	53                   	push   %ebx
 494:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 497:	8b 74 24 44          	mov    0x44(%esp),%esi
 49b:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 49f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4a7:	0f b6 1e             	movzbl (%esi),%ebx
 4aa:	83 c6 01             	add    $0x1,%esi
 4ad:	84 db                	test   %bl,%bl
 4af:	0f 84 ad 00 00 00    	je     562 <printf+0xd2>
 4b5:	31 ed                	xor    %ebp,%ebp
 4b7:	eb 32                	jmp    4eb <printf+0x5b>
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	0f 84 a7 00 00 00    	je     570 <printf+0xe0>
 4c9:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	6a 01                	push   $0x1
 4d2:	8d 44 24 22          	lea    0x22(%esp),%eax
 4d6:	50                   	push   %eax
 4d7:	57                   	push   %edi
 4d8:	e8 94 fe ff ff       	call   371 <write>
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4e7:	84 db                	test   %bl,%bl
 4e9:	74 77                	je     562 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 4eb:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4ed:	0f be cb             	movsbl %bl,%ecx
 4f0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4f3:	74 cb                	je     4c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f5:	83 fd 25             	cmp    $0x25,%ebp
 4f8:	75 e6                	jne    4e0 <printf+0x50>
      if(c == 'd'){
 4fa:	83 f8 64             	cmp    $0x64,%eax
 4fd:	0f 84 15 01 00 00    	je     618 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 503:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 509:	83 f9 70             	cmp    $0x70,%ecx
 50c:	74 72                	je     580 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 50e:	83 f8 73             	cmp    $0x73,%eax
 511:	0f 84 99 00 00 00    	je     5b0 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 517:	83 f8 63             	cmp    $0x63,%eax
 51a:	0f 84 07 01 00 00    	je     627 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 520:	83 f8 25             	cmp    $0x25,%eax
 523:	0f 84 d7 00 00 00    	je     600 <printf+0x170>
 529:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52e:	83 ec 04             	sub    $0x4,%esp
 531:	6a 01                	push   $0x1
 533:	8d 44 24 27          	lea    0x27(%esp),%eax
 537:	50                   	push   %eax
 538:	57                   	push   %edi
 539:	e8 33 fe ff ff       	call   371 <write>
 53e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 542:	83 c4 0c             	add    $0xc,%esp
 545:	6a 01                	push   $0x1
 547:	8d 44 24 26          	lea    0x26(%esp),%eax
 54b:	50                   	push   %eax
 54c:	57                   	push   %edi
 54d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 550:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 552:	e8 1a fe ff ff       	call   371 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 557:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55b:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 55e:	84 db                	test   %bl,%bl
 560:	75 89                	jne    4eb <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 562:	83 c4 2c             	add    $0x2c,%esp
 565:	5b                   	pop    %ebx
 566:	5e                   	pop    %esi
 567:	5f                   	pop    %edi
 568:	5d                   	pop    %ebp
 569:	c3                   	ret    
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 570:	bd 25 00 00 00       	mov    $0x25,%ebp
 575:	e9 66 ff ff ff       	jmp    4e0 <printf+0x50>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 10 00 00 00       	mov    $0x10,%ecx
 588:	6a 00                	push   $0x0
 58a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 58e:	89 f8                	mov    %edi,%eax
 590:	8b 13                	mov    (%ebx),%edx
 592:	e8 59 fe ff ff       	call   3f0 <printint>
        ap++;
 597:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 599:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 59b:	83 c0 04             	add    $0x4,%eax
 59e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 5a2:	83 c4 10             	add    $0x10,%esp
 5a5:	e9 36 ff ff ff       	jmp    4e0 <printf+0x50>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 5b0:	8b 44 24 0c          	mov    0xc(%esp),%eax
 5b4:	8b 28                	mov    (%eax),%ebp
        ap++;
 5b6:	83 c0 04             	add    $0x4,%eax
 5b9:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 5bd:	b8 0c 08 00 00       	mov    $0x80c,%eax
 5c2:	85 ed                	test   %ebp,%ebp
 5c4:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 5c7:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 5cb:	84 c0                	test   %al,%al
 5cd:	74 27                	je     5f6 <printf+0x166>
 5cf:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 5d3:	90                   	nop
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d8:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5dc:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5df:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5e2:	6a 01                	push   $0x1
 5e4:	53                   	push   %ebx
 5e5:	57                   	push   %edi
 5e6:	e8 86 fd ff ff       	call   371 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5eb:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 5ef:	83 c4 10             	add    $0x10,%esp
 5f2:	84 c0                	test   %al,%al
 5f4:	75 e2                	jne    5d8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5f6:	31 ed                	xor    %ebp,%ebp
 5f8:	e9 e3 fe ff ff       	jmp    4e0 <printf+0x50>
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 604:	83 ec 04             	sub    $0x4,%esp
 607:	6a 01                	push   $0x1
 609:	8d 44 24 25          	lea    0x25(%esp),%eax
 60d:	e9 39 ff ff ff       	jmp    54b <printf+0xbb>
 612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 618:	83 ec 0c             	sub    $0xc,%esp
 61b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 620:	6a 01                	push   $0x1
 622:	e9 63 ff ff ff       	jmp    58a <printf+0xfa>
 627:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62b:	83 ec 04             	sub    $0x4,%esp
 62e:	8b 03                	mov    (%ebx),%eax
 630:	88 44 24 20          	mov    %al,0x20(%esp)
 634:	6a 01                	push   $0x1
 636:	8d 44 24 24          	lea    0x24(%esp),%eax
 63a:	50                   	push   %eax
 63b:	57                   	push   %edi
 63c:	e8 30 fd ff ff       	call   371 <write>
 641:	e9 51 ff ff ff       	jmp    597 <printf+0x107>
 646:	66 90                	xchg   %ax,%ax
 648:	66 90                	xchg   %ax,%ax
 64a:	66 90                	xchg   %ax,%ax
 64c:	66 90                	xchg   %ax,%ax
 64e:	66 90                	xchg   %ax,%ax

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	57                   	push   %edi
 651:	56                   	push   %esi
 652:	53                   	push   %ebx
 653:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 657:	a1 5c 0b 00 00       	mov    0xb5c,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 65c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65f:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	39 c8                	cmp    %ecx,%eax
 663:	73 13                	jae    678 <free+0x28>
 665:	8d 76 00             	lea    0x0(%esi),%esi
 668:	39 d1                	cmp    %edx,%ecx
 66a:	72 14                	jb     680 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 d0                	cmp    %edx,%eax
 66e:	73 10                	jae    680 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 672:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 674:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 676:	72 f0                	jb     668 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 d0                	cmp    %edx,%eax
 67a:	72 f4                	jb     670 <free+0x20>
 67c:	39 d1                	cmp    %edx,%ecx
 67e:	73 f0                	jae    670 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 680:	8b 73 fc             	mov    -0x4(%ebx),%esi
 683:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 686:	39 d7                	cmp    %edx,%edi
 688:	74 18                	je     6a2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	74 20                	je     6b7 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 697:	89 08                	mov    %ecx,(%eax)
  freep = p;
 699:	a3 5c 0b 00 00       	mov    %eax,0xb5c
}
 69e:	5b                   	pop    %ebx
 69f:	5e                   	pop    %esi
 6a0:	5f                   	pop    %edi
 6a1:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6a2:	03 72 04             	add    0x4(%edx),%esi
 6a5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a8:	8b 12                	mov    (%edx),%edx
 6aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b3:	39 f1                	cmp    %esi,%ecx
 6b5:	75 e0                	jne    697 <free+0x47>
    p->s.size += bp->s.size;
 6b7:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ba:	a3 5c 0b 00 00       	mov    %eax,0xb5c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c5:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	c3                   	ret    
 6cb:	90                   	nop
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	57                   	push   %edi
 6d1:	56                   	push   %esi
 6d2:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d3:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 6d7:	8b 15 5c 0b 00 00    	mov    0xb5c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6dd:	8d 78 07             	lea    0x7(%eax),%edi
 6e0:	c1 ef 03             	shr    $0x3,%edi
 6e3:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6e6:	85 d2                	test   %edx,%edx
 6e8:	0f 84 a0 00 00 00    	je     78e <malloc+0xbe>
 6ee:	8b 02                	mov    (%edx),%eax
 6f0:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6f3:	39 cf                	cmp    %ecx,%edi
 6f5:	76 71                	jbe    768 <malloc+0x98>
 6f7:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6fd:	be 00 10 00 00       	mov    $0x1000,%esi
 702:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 709:	0f 43 f7             	cmovae %edi,%esi
 70c:	ba 00 80 00 00       	mov    $0x8000,%edx
 711:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 717:	0f 46 da             	cmovbe %edx,%ebx
 71a:	eb 0d                	jmp    729 <malloc+0x59>
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 722:	8b 48 04             	mov    0x4(%eax),%ecx
 725:	39 cf                	cmp    %ecx,%edi
 727:	76 3f                	jbe    768 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 729:	39 05 5c 0b 00 00    	cmp    %eax,0xb5c
 72f:	89 c2                	mov    %eax,%edx
 731:	75 ed                	jne    720 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	53                   	push   %ebx
 737:	e8 9d fc ff ff       	call   3d9 <sbrk>
  if(p == (char*) -1)
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	83 f8 ff             	cmp    $0xffffffff,%eax
 742:	74 1c                	je     760 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 744:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 747:	83 ec 0c             	sub    $0xc,%esp
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	50                   	push   %eax
 74e:	e8 fd fe ff ff       	call   650 <free>
  return freep;
 753:	8b 15 5c 0b 00 00    	mov    0xb5c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 759:	83 c4 10             	add    $0x10,%esp
 75c:	85 d2                	test   %edx,%edx
 75e:	75 c0                	jne    720 <malloc+0x50>
        return 0;
 760:	31 c0                	xor    %eax,%eax
 762:	eb 1c                	jmp    780 <malloc+0xb0>
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 768:	39 cf                	cmp    %ecx,%edi
 76a:	74 1c                	je     788 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 76c:	29 f9                	sub    %edi,%ecx
 76e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 771:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 774:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 777:	89 15 5c 0b 00 00    	mov    %edx,0xb5c
      return (void*) (p + 1);
 77d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 780:	5b                   	pop    %ebx
 781:	5e                   	pop    %esi
 782:	5f                   	pop    %edi
 783:	c3                   	ret    
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 788:	8b 08                	mov    (%eax),%ecx
 78a:	89 0a                	mov    %ecx,(%edx)
 78c:	eb e9                	jmp    777 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 78e:	c7 05 5c 0b 00 00 60 	movl   $0xb60,0xb5c
 795:	0b 00 00 
 798:	c7 05 60 0b 00 00 60 	movl   $0xb60,0xb60
 79f:	0b 00 00 
    base.s.size = 0;
 7a2:	b8 60 0b 00 00       	mov    $0xb60,%eax
 7a7:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7ae:	00 00 00 
 7b1:	e9 41 ff ff ff       	jmp    6f7 <malloc+0x27>
