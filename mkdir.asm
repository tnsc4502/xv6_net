
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	bf 01 00 00 00       	mov    $0x1,%edi
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int i;

  if(argc < 2){
  21:	83 fe 01             	cmp    $0x1,%esi
  24:	7e 3e                	jle    64 <main+0x64>
  26:	8d 76 00             	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	e8 cf 02 00 00       	call   309 <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	78 0f                	js     50 <main+0x50>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  41:	83 c7 01             	add    $0x1,%edi
  44:	83 c3 04             	add    $0x4,%ebx
  47:	39 fe                	cmp    %edi,%esi
  49:	75 e5                	jne    30 <main+0x30>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  4b:	e8 51 02 00 00       	call   2a1 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  50:	50                   	push   %eax
  51:	ff 33                	pushl  (%ebx)
  53:	68 1f 07 00 00       	push   $0x71f
  58:	6a 02                	push   $0x2
  5a:	e8 81 03 00 00       	call   3e0 <printf>
      break;
  5f:	83 c4 10             	add    $0x10,%esp
  62:	eb e7                	jmp    4b <main+0x4b>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
  64:	52                   	push   %edx
  65:	52                   	push   %edx
  66:	68 08 07 00 00       	push   $0x708
  6b:	6a 02                	push   $0x2
  6d:	e8 6e 03 00 00       	call   3e0 <printf>
    exit();
  72:	e8 2a 02 00 00       	call   2a1 <exit>
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  80:	53                   	push   %ebx
  81:	8b 44 24 08          	mov    0x8(%esp),%eax
  85:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  89:	89 c2                	mov    %eax,%edx
  8b:	90                   	nop
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	c3                   	ret    
  a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	56                   	push   %esi
  b1:	53                   	push   %ebx
  b2:	8b 54 24 0c          	mov    0xc(%esp),%edx
  b6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	0f b6 19             	movzbl (%ecx),%ebx
  c0:	84 c0                	test   %al,%al
  c2:	75 1f                	jne    e3 <strcmp+0x33>
  c4:	eb 2a                	jmp    f0 <strcmp+0x40>
  c6:	8d 76 00             	lea    0x0(%esi),%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  dd:	84 c0                	test   %al,%al
  df:	74 0f                	je     f0 <strcmp+0x40>
  e1:	89 f1                	mov    %esi,%ecx
  e3:	38 d8                	cmp    %bl,%al
  e5:	74 e9                	je     d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e7:	29 d8                	sub    %ebx,%eax
}
  e9:	5b                   	pop    %ebx
  ea:	5e                   	pop    %esi
  eb:	c3                   	ret    
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f2:	29 d8                	sub    %ebx,%eax
}
  f4:	5b                   	pop    %ebx
  f5:	5e                   	pop    %esi
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 104:	80 39 00             	cmpb   $0x0,(%ecx)
 107:	74 14                	je     11d <strlen+0x1d>
 109:	31 d2                	xor    %edx,%edx
 10b:	90                   	nop
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
 11b:	f3 c3                	repz ret 
 11d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 11f:	c3                   	ret    

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	57                   	push   %edi
 121:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 125:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 129:	8b 44 24 0c          	mov    0xc(%esp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	c3                   	ret    
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	53                   	push   %ebx
 141:	8b 44 24 08          	mov    0x8(%esp),%eax
 145:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 149:	0f b6 10             	movzbl (%eax),%edx
 14c:	84 d2                	test   %dl,%dl
 14e:	74 1e                	je     16e <strchr+0x2e>
    if(*s == c)
 150:	38 d3                	cmp    %dl,%bl
 152:	89 d9                	mov    %ebx,%ecx
 154:	75 0e                	jne    164 <strchr+0x24>
 156:	eb 18                	jmp    170 <strchr+0x30>
 158:	90                   	nop
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 16e:	31 c0                	xor    %eax,%eax
}
 170:	5b                   	pop    %ebx
 171:	c3                   	ret    
 172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 182:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 184:	56                   	push   %esi
 185:	53                   	push   %ebx
 186:	83 ec 1c             	sub    $0x1c,%esp
 189:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 18d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 191:	eb 2c                	jmp    1bf <gets+0x3f>
 193:	90                   	nop
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 198:	83 ec 04             	sub    $0x4,%esp
 19b:	6a 01                	push   $0x1
 19d:	55                   	push   %ebp
 19e:	6a 00                	push   $0x0
 1a0:	e8 14 01 00 00       	call   2b9 <read>
    if(cc < 1)
 1a5:	83 c4 10             	add    $0x10,%esp
 1a8:	85 c0                	test   %eax,%eax
 1aa:	7e 1c                	jle    1c8 <gets+0x48>
      break;
    buf[i++] = c;
 1ac:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 1b1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 1b3:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1b5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 1b9:	74 25                	je     1e0 <gets+0x60>
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	74 21                	je     1e0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bf:	8d 5f 01             	lea    0x1(%edi),%ebx
 1c2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 1c6:	7c d0                	jl     198 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 1cc:	83 c4 1c             	add    $0x1c,%esp
 1cf:	89 f0                	mov    %esi,%eax
 1d1:	5b                   	pop    %ebx
 1d2:	5e                   	pop    %esi
 1d3:	5f                   	pop    %edi
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret    
 1d6:	8d 76 00             	lea    0x0(%esi),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e0:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1e2:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 1e8:	83 c4 1c             	add    $0x1c,%esp
 1eb:	5b                   	pop    %ebx
 1ec:	5e                   	pop    %esi
 1ed:	5f                   	pop    %edi
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret    

000001f0 <stat>:

int
stat(char *n, struct statv6 *st)
{
 1f0:	56                   	push   %esi
 1f1:	53                   	push   %ebx
 1f2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	6a 00                	push   $0x0
 1f7:	ff 74 24 1c          	pushl  0x1c(%esp)
 1fb:	e8 e1 00 00 00       	call   2e1 <open>
  if(fd < 0)
 200:	83 c4 10             	add    $0x10,%esp
 203:	85 c0                	test   %eax,%eax
 205:	78 29                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 207:	83 ec 08             	sub    $0x8,%esp
 20a:	89 c3                	mov    %eax,%ebx
 20c:	ff 74 24 1c          	pushl  0x1c(%esp)
 210:	50                   	push   %eax
 211:	e8 e3 00 00 00       	call   2f9 <fstat>
 216:	89 c6                	mov    %eax,%esi
  close(fd);
 218:	89 1c 24             	mov    %ebx,(%esp)
 21b:	e8 a9 00 00 00       	call   2c9 <close>
  return r;
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 f0                	mov    %esi,%eax
}
 225:	83 c4 04             	add    $0x4,%esp
 228:	5b                   	pop    %ebx
 229:	5e                   	pop    %esi
 22a:	c3                   	ret    
 22b:	90                   	nop
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 235:	eb ee                	jmp    225 <stat+0x35>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 240:	53                   	push   %ebx
 241:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 245:	0f be 11             	movsbl (%ecx),%edx
 248:	8d 42 d0             	lea    -0x30(%edx),%eax
 24b:	3c 09                	cmp    $0x9,%al
 24d:	b8 00 00 00 00       	mov    $0x0,%eax
 252:	77 19                	ja     26d <atoi+0x2d>
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 258:	8d 04 80             	lea    (%eax,%eax,4),%eax
 25b:	83 c1 01             	add    $0x1,%ecx
 25e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	0f be 11             	movsbl (%ecx),%edx
 265:	8d 5a d0             	lea    -0x30(%edx),%ebx
 268:	80 fb 09             	cmp    $0x9,%bl
 26b:	76 eb                	jbe    258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 26d:	5b                   	pop    %ebx
 26e:	c3                   	ret    
 26f:	90                   	nop

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	56                   	push   %esi
 271:	53                   	push   %ebx
 272:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 276:	8b 44 24 0c          	mov    0xc(%esp),%eax
 27a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 14                	jle    296 <memmove+0x26>
 282:	31 d2                	xor    %edx,%edx
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	c3                   	ret    

00000299 <fork>:
 299:	b8 01 00 00 00       	mov    $0x1,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <exit>:
 2a1:	b8 02 00 00 00       	mov    $0x2,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <wait>:
 2a9:	b8 03 00 00 00       	mov    $0x3,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <pipe>:
 2b1:	b8 04 00 00 00       	mov    $0x4,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <read>:
 2b9:	b8 06 00 00 00       	mov    $0x6,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <write>:
 2c1:	b8 05 00 00 00       	mov    $0x5,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <close>:
 2c9:	b8 07 00 00 00       	mov    $0x7,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <kill>:
 2d1:	b8 08 00 00 00       	mov    $0x8,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <exec>:
 2d9:	b8 09 00 00 00       	mov    $0x9,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <open>:
 2e1:	b8 0a 00 00 00       	mov    $0xa,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <mknod>:
 2e9:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <unlink>:
 2f1:	b8 0c 00 00 00       	mov    $0xc,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <fstat>:
 2f9:	b8 0d 00 00 00       	mov    $0xd,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <link>:
 301:	b8 0e 00 00 00       	mov    $0xe,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <mkdir>:
 309:	b8 0f 00 00 00       	mov    $0xf,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <chdir>:
 311:	b8 10 00 00 00       	mov    $0x10,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <dup>:
 319:	b8 11 00 00 00       	mov    $0x11,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <getpid>:
 321:	b8 12 00 00 00       	mov    $0x12,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <sbrk>:
 329:	b8 13 00 00 00       	mov    $0x13,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <sleep>:
 331:	b8 14 00 00 00       	mov    $0x14,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    
 339:	66 90                	xchg   %ax,%ax
 33b:	66 90                	xchg   %ax,%ax
 33d:	66 90                	xchg   %ax,%ax
 33f:	90                   	nop

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	57                   	push   %edi
 342:	89 c7                	mov    %eax,%edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 349:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 34d:	85 db                	test   %ebx,%ebx
 34f:	74 77                	je     3c8 <printint+0x88>
 351:	89 d0                	mov    %edx,%eax
 353:	c1 e8 1f             	shr    $0x1f,%eax
 356:	84 c0                	test   %al,%al
 358:	74 6e                	je     3c8 <printint+0x88>
    neg = 1;
    x = -xx;
 35a:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 35c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 363:	00 
    x = -xx;
 364:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 366:	31 ed                	xor    %ebp,%ebp
 368:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 36c:	eb 04                	jmp    372 <printint+0x32>
 36e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 370:	89 f5                	mov    %esi,%ebp
 372:	31 d2                	xor    %edx,%edx
 374:	8d 75 01             	lea    0x1(%ebp),%esi
 377:	f7 f1                	div    %ecx
 379:	0f b6 92 44 07 00 00 	movzbl 0x744(%edx),%edx
  }while((x /= base) != 0);
 380:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 382:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 385:	75 e9                	jne    370 <printint+0x30>
  if(neg)
 387:	8b 44 24 0c          	mov    0xc(%esp),%eax
 38b:	85 c0                	test   %eax,%eax
 38d:	74 08                	je     397 <printint+0x57>
    buf[i++] = '-';
 38f:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 394:	8d 75 02             	lea    0x2(%ebp),%esi
 397:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 39b:	90                   	nop
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3a0:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a3:	83 ec 04             	sub    $0x4,%esp
 3a6:	83 ee 01             	sub    $0x1,%esi
 3a9:	88 44 24 23          	mov    %al,0x23(%esp)
 3ad:	6a 01                	push   $0x1
 3af:	53                   	push   %ebx
 3b0:	57                   	push   %edi
 3b1:	e8 0b ff ff ff       	call   2c1 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3b6:	83 c4 10             	add    $0x10,%esp
 3b9:	39 de                	cmp    %ebx,%esi
 3bb:	75 e3                	jne    3a0 <printint+0x60>
    putc(fd, buf[i]);
}
 3bd:	83 c4 3c             	add    $0x3c,%esp
 3c0:	5b                   	pop    %ebx
 3c1:	5e                   	pop    %esi
 3c2:	5f                   	pop    %edi
 3c3:	5d                   	pop    %ebp
 3c4:	c3                   	ret    
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ca:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 3d1:	00 
 3d2:	eb 92                	jmp    366 <printint+0x26>
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	57                   	push   %edi
 3e2:	56                   	push   %esi
 3e3:	53                   	push   %ebx
 3e4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e7:	8b 74 24 44          	mov    0x44(%esp),%esi
 3eb:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3ef:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 3f7:	0f b6 1e             	movzbl (%esi),%ebx
 3fa:	83 c6 01             	add    $0x1,%esi
 3fd:	84 db                	test   %bl,%bl
 3ff:	0f 84 ad 00 00 00    	je     4b2 <printf+0xd2>
 405:	31 ed                	xor    %ebp,%ebp
 407:	eb 32                	jmp    43b <printf+0x5b>
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 410:	83 f8 25             	cmp    $0x25,%eax
 413:	0f 84 a7 00 00 00    	je     4c0 <printf+0xe0>
 419:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 41d:	83 ec 04             	sub    $0x4,%esp
 420:	6a 01                	push   $0x1
 422:	8d 44 24 22          	lea    0x22(%esp),%eax
 426:	50                   	push   %eax
 427:	57                   	push   %edi
 428:	e8 94 fe ff ff       	call   2c1 <write>
 42d:	83 c4 10             	add    $0x10,%esp
 430:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 433:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 437:	84 db                	test   %bl,%bl
 439:	74 77                	je     4b2 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 43b:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 43d:	0f be cb             	movsbl %bl,%ecx
 440:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 443:	74 cb                	je     410 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 445:	83 fd 25             	cmp    $0x25,%ebp
 448:	75 e6                	jne    430 <printf+0x50>
      if(c == 'd'){
 44a:	83 f8 64             	cmp    $0x64,%eax
 44d:	0f 84 15 01 00 00    	je     568 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 453:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 459:	83 f9 70             	cmp    $0x70,%ecx
 45c:	74 72                	je     4d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45e:	83 f8 73             	cmp    $0x73,%eax
 461:	0f 84 99 00 00 00    	je     500 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 467:	83 f8 63             	cmp    $0x63,%eax
 46a:	0f 84 07 01 00 00    	je     577 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 470:	83 f8 25             	cmp    $0x25,%eax
 473:	0f 84 d7 00 00 00    	je     550 <printf+0x170>
 479:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47e:	83 ec 04             	sub    $0x4,%esp
 481:	6a 01                	push   $0x1
 483:	8d 44 24 27          	lea    0x27(%esp),%eax
 487:	50                   	push   %eax
 488:	57                   	push   %edi
 489:	e8 33 fe ff ff       	call   2c1 <write>
 48e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 492:	83 c4 0c             	add    $0xc,%esp
 495:	6a 01                	push   $0x1
 497:	8d 44 24 26          	lea    0x26(%esp),%eax
 49b:	50                   	push   %eax
 49c:	57                   	push   %edi
 49d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a0:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a2:	e8 1a fe ff ff       	call   2c1 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ab:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4ae:	84 db                	test   %bl,%bl
 4b0:	75 89                	jne    43b <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b2:	83 c4 2c             	add    $0x2c,%esp
 4b5:	5b                   	pop    %ebx
 4b6:	5e                   	pop    %esi
 4b7:	5f                   	pop    %edi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c0:	bd 25 00 00 00       	mov    $0x25,%ebp
 4c5:	e9 66 ff ff ff       	jmp    430 <printf+0x50>
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4d0:	83 ec 0c             	sub    $0xc,%esp
 4d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4d8:	6a 00                	push   $0x0
 4da:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 4de:	89 f8                	mov    %edi,%eax
 4e0:	8b 13                	mov    (%ebx),%edx
 4e2:	e8 59 fe ff ff       	call   340 <printint>
        ap++;
 4e7:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e9:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4eb:	83 c0 04             	add    $0x4,%eax
 4ee:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 4f2:	83 c4 10             	add    $0x10,%esp
 4f5:	e9 36 ff ff ff       	jmp    430 <printf+0x50>
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 500:	8b 44 24 0c          	mov    0xc(%esp),%eax
 504:	8b 28                	mov    (%eax),%ebp
        ap++;
 506:	83 c0 04             	add    $0x4,%eax
 509:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 50d:	b8 3b 07 00 00       	mov    $0x73b,%eax
 512:	85 ed                	test   %ebp,%ebp
 514:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 517:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 51b:	84 c0                	test   %al,%al
 51d:	74 27                	je     546 <printf+0x166>
 51f:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 523:	90                   	nop
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 528:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52c:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 52f:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 532:	6a 01                	push   $0x1
 534:	53                   	push   %ebx
 535:	57                   	push   %edi
 536:	e8 86 fd ff ff       	call   2c1 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53b:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 53f:	83 c4 10             	add    $0x10,%esp
 542:	84 c0                	test   %al,%al
 544:	75 e2                	jne    528 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 546:	31 ed                	xor    %ebp,%ebp
 548:	e9 e3 fe ff ff       	jmp    430 <printf+0x50>
 54d:	8d 76 00             	lea    0x0(%esi),%esi
 550:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 554:	83 ec 04             	sub    $0x4,%esp
 557:	6a 01                	push   $0x1
 559:	8d 44 24 25          	lea    0x25(%esp),%eax
 55d:	e9 39 ff ff ff       	jmp    49b <printf+0xbb>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 570:	6a 01                	push   $0x1
 572:	e9 63 ff ff ff       	jmp    4da <printf+0xfa>
 577:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57b:	83 ec 04             	sub    $0x4,%esp
 57e:	8b 03                	mov    (%ebx),%eax
 580:	88 44 24 20          	mov    %al,0x20(%esp)
 584:	6a 01                	push   $0x1
 586:	8d 44 24 24          	lea    0x24(%esp),%eax
 58a:	50                   	push   %eax
 58b:	57                   	push   %edi
 58c:	e8 30 fd ff ff       	call   2c1 <write>
 591:	e9 51 ff ff ff       	jmp    4e7 <printf+0x107>
 596:	66 90                	xchg   %ax,%ax
 598:	66 90                	xchg   %ax,%ax
 59a:	66 90                	xchg   %ax,%ax
 59c:	66 90                	xchg   %ax,%ax
 59e:	66 90                	xchg   %ax,%ax

000005a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5a0:	57                   	push   %edi
 5a1:	56                   	push   %esi
 5a2:	53                   	push   %ebx
 5a3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a7:	a1 8c 0a 00 00       	mov    0xa8c,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5ac:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5af:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b1:	39 c8                	cmp    %ecx,%eax
 5b3:	73 13                	jae    5c8 <free+0x28>
 5b5:	8d 76 00             	lea    0x0(%esi),%esi
 5b8:	39 d1                	cmp    %edx,%ecx
 5ba:	72 14                	jb     5d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bc:	39 d0                	cmp    %edx,%eax
 5be:	73 10                	jae    5d0 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c4:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c6:	72 f0                	jb     5b8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c8:	39 d0                	cmp    %edx,%eax
 5ca:	72 f4                	jb     5c0 <free+0x20>
 5cc:	39 d1                	cmp    %edx,%ecx
 5ce:	73 f0                	jae    5c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5d6:	39 d7                	cmp    %edx,%edi
 5d8:	74 18                	je     5f2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5dd:	8b 50 04             	mov    0x4(%eax),%edx
 5e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e3:	39 f1                	cmp    %esi,%ecx
 5e5:	74 20                	je     607 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5e7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5e9:	a3 8c 0a 00 00       	mov    %eax,0xa8c
}
 5ee:	5b                   	pop    %ebx
 5ef:	5e                   	pop    %esi
 5f0:	5f                   	pop    %edi
 5f1:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5f2:	03 72 04             	add    0x4(%edx),%esi
 5f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5f8:	8b 12                	mov    (%edx),%edx
 5fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5fd:	8b 50 04             	mov    0x4(%eax),%edx
 600:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 603:	39 f1                	cmp    %esi,%ecx
 605:	75 e0                	jne    5e7 <free+0x47>
    p->s.size += bp->s.size;
 607:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 60a:	a3 8c 0a 00 00       	mov    %eax,0xa8c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 60f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 612:	8b 53 f8             	mov    -0x8(%ebx),%edx
 615:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	c3                   	ret    
 61b:	90                   	nop
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 620:	57                   	push   %edi
 621:	56                   	push   %esi
 622:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 623:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 627:	8b 15 8c 0a 00 00    	mov    0xa8c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 62d:	8d 78 07             	lea    0x7(%eax),%edi
 630:	c1 ef 03             	shr    $0x3,%edi
 633:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 636:	85 d2                	test   %edx,%edx
 638:	0f 84 a0 00 00 00    	je     6de <malloc+0xbe>
 63e:	8b 02                	mov    (%edx),%eax
 640:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 643:	39 cf                	cmp    %ecx,%edi
 645:	76 71                	jbe    6b8 <malloc+0x98>
 647:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 64d:	be 00 10 00 00       	mov    $0x1000,%esi
 652:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 659:	0f 43 f7             	cmovae %edi,%esi
 65c:	ba 00 80 00 00       	mov    $0x8000,%edx
 661:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 667:	0f 46 da             	cmovbe %edx,%ebx
 66a:	eb 0d                	jmp    679 <malloc+0x59>
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 670:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 672:	8b 48 04             	mov    0x4(%eax),%ecx
 675:	39 cf                	cmp    %ecx,%edi
 677:	76 3f                	jbe    6b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 679:	39 05 8c 0a 00 00    	cmp    %eax,0xa8c
 67f:	89 c2                	mov    %eax,%edx
 681:	75 ed                	jne    670 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 683:	83 ec 0c             	sub    $0xc,%esp
 686:	53                   	push   %ebx
 687:	e8 9d fc ff ff       	call   329 <sbrk>
  if(p == (char*) -1)
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	83 f8 ff             	cmp    $0xffffffff,%eax
 692:	74 1c                	je     6b0 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 694:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 697:	83 ec 0c             	sub    $0xc,%esp
 69a:	83 c0 08             	add    $0x8,%eax
 69d:	50                   	push   %eax
 69e:	e8 fd fe ff ff       	call   5a0 <free>
  return freep;
 6a3:	8b 15 8c 0a 00 00    	mov    0xa8c,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6a9:	83 c4 10             	add    $0x10,%esp
 6ac:	85 d2                	test   %edx,%edx
 6ae:	75 c0                	jne    670 <malloc+0x50>
        return 0;
 6b0:	31 c0                	xor    %eax,%eax
 6b2:	eb 1c                	jmp    6d0 <malloc+0xb0>
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6b8:	39 cf                	cmp    %ecx,%edi
 6ba:	74 1c                	je     6d8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6bc:	29 f9                	sub    %edi,%ecx
 6be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6c4:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 6c7:	89 15 8c 0a 00 00    	mov    %edx,0xa8c
      return (void*) (p + 1);
 6cd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6d0:	5b                   	pop    %ebx
 6d1:	5e                   	pop    %esi
 6d2:	5f                   	pop    %edi
 6d3:	c3                   	ret    
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6d8:	8b 08                	mov    (%eax),%ecx
 6da:	89 0a                	mov    %ecx,(%edx)
 6dc:	eb e9                	jmp    6c7 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6de:	c7 05 8c 0a 00 00 90 	movl   $0xa90,0xa8c
 6e5:	0a 00 00 
 6e8:	c7 05 90 0a 00 00 90 	movl   $0xa90,0xa90
 6ef:	0a 00 00 
    base.s.size = 0;
 6f2:	b8 90 0a 00 00       	mov    $0xa90,%eax
 6f7:	c7 05 94 0a 00 00 00 	movl   $0x0,0xa94
 6fe:	00 00 00 
 701:	e9 41 ff ff ff       	jmp    647 <malloc+0x27>
