
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

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
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;

  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 a5 03 00 00       	call   3e1 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 6b 03 00 00       	call   3c9 <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  66:	e8 36 03 00 00       	call   3a1 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 2b 08 00 00       	push   $0x82b
  73:	6a 01                	push   $0x1
  75:	e8 66 04 00 00       	call   4e0 <printf>
      exit();
  7a:	e8 22 03 00 00       	call   3a1 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 1d 08 00 00       	push   $0x81d
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 0f 03 00 00       	call   3a1 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  a0:	55                   	push   %ebp
  a1:	57                   	push   %edi
  a2:	56                   	push   %esi
  a3:	53                   	push   %ebx
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  a4:	31 f6                	xor    %esi,%esi
wc(int fd, char *name)
{
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx

char buf[512];

void
wc(int fd, char *name)
{
  a8:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  ab:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  b2:	00 
  b3:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  ba:	00 
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 40 0c 00 00       	push   $0xc40
  cd:	ff 74 24 3c          	pushl  0x3c(%esp)
  d1:	e8 e3 02 00 00       	call   3b9 <read>
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	83 f8 00             	cmp    $0x0,%eax
  dc:	89 c7                	mov    %eax,%edi
  de:	7e 5f                	jle    13f <wc+0x9f>
  e0:	31 ed                	xor    %ebp,%ebp
  e2:	eb 0d                	jmp    f1 <wc+0x51>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  ea:	83 c5 01             	add    $0x1,%ebp
  ed:	39 ef                	cmp    %ebp,%edi
  ef:	74 3a                	je     12b <wc+0x8b>
      c++;
      if(buf[i] == '\n')
  f1:	0f be 85 40 0c 00 00 	movsbl 0xc40(%ebp),%eax
        l++;
  f8:	31 c9                	xor    %ecx,%ecx
  fa:	3c 0a                	cmp    $0xa,%al
  fc:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
  ff:	83 ec 08             	sub    $0x8,%esp
 102:	50                   	push   %eax
 103:	68 08 08 00 00       	push   $0x808
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 108:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10a:	e8 31 01 00 00       	call   240 <strchr>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	85 c0                	test   %eax,%eax
 114:	75 d2                	jne    e8 <wc+0x48>
        inword = 0;
      else if(!inword){
 116:	85 f6                	test   %esi,%esi
 118:	75 1e                	jne    138 <wc+0x98>
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 11a:	83 c5 01             	add    $0x1,%ebp
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
 11d:	83 44 24 08 01       	addl   $0x1,0x8(%esp)
        inword = 1;
 122:	be 01 00 00 00       	mov    $0x1,%esi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 127:	39 ef                	cmp    %ebp,%edi
 129:	75 c6                	jne    f1 <wc+0x51>
 12b:	01 7c 24 0c          	add    %edi,0xc(%esp)
 12f:	eb 8f                	jmp    c0 <wc+0x20>
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 138:	be 01 00 00 00       	mov    $0x1,%esi
 13d:	eb ab                	jmp    ea <wc+0x4a>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 13f:	75 24                	jne    165 <wc+0xc5>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 141:	83 ec 08             	sub    $0x8,%esp
 144:	ff 74 24 3c          	pushl  0x3c(%esp)
 148:	ff 74 24 18          	pushl  0x18(%esp)
 14c:	ff 74 24 18          	pushl  0x18(%esp)
 150:	53                   	push   %ebx
 151:	68 1e 08 00 00       	push   $0x81e
 156:	6a 01                	push   $0x1
 158:	e8 83 03 00 00       	call   4e0 <printf>
}
 15d:	83 c4 3c             	add    $0x3c,%esp
 160:	5b                   	pop    %ebx
 161:	5e                   	pop    %esi
 162:	5f                   	pop    %edi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 165:	83 ec 08             	sub    $0x8,%esp
 168:	68 0e 08 00 00       	push   $0x80e
 16d:	6a 01                	push   $0x1
 16f:	e8 6c 03 00 00       	call   4e0 <printf>
    exit();
 174:	e8 28 02 00 00       	call   3a1 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	53                   	push   %ebx
 181:	8b 44 24 08          	mov    0x8(%esp),%eax
 185:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 189:	89 c2                	mov    %eax,%edx
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	c3                   	ret    
 1a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	56                   	push   %esi
 1b1:	53                   	push   %ebx
 1b2:	8b 54 24 0c          	mov    0xc(%esp),%edx
 1b6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	0f b6 19             	movzbl (%ecx),%ebx
 1c0:	84 c0                	test   %al,%al
 1c2:	75 1f                	jne    1e3 <strcmp+0x33>
 1c4:	eb 2a                	jmp    1f0 <strcmp+0x40>
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1dd:	84 c0                	test   %al,%al
 1df:	74 0f                	je     1f0 <strcmp+0x40>
 1e1:	89 f1                	mov    %esi,%ecx
 1e3:	38 d8                	cmp    %bl,%al
 1e5:	74 e9                	je     1d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1e7:	29 d8                	sub    %ebx,%eax
}
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	c3                   	ret    
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5e                   	pop    %esi
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 204:	80 39 00             	cmpb   $0x0,(%ecx)
 207:	74 14                	je     21d <strlen+0x1d>
 209:	31 d2                	xor    %edx,%edx
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
 21b:	f3 c3                	repz ret 
 21d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 21f:	c3                   	ret    

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	57                   	push   %edi
 221:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 225:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 229:	8b 44 24 0c          	mov    0xc(%esp),%eax
 22d:	89 d7                	mov    %edx,%edi
 22f:	fc                   	cld    
 230:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 232:	89 d0                	mov    %edx,%eax
 234:	5f                   	pop    %edi
 235:	c3                   	ret    
 236:	8d 76 00             	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	53                   	push   %ebx
 241:	8b 44 24 08          	mov    0x8(%esp),%eax
 245:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 249:	0f b6 10             	movzbl (%eax),%edx
 24c:	84 d2                	test   %dl,%dl
 24e:	74 1e                	je     26e <strchr+0x2e>
    if(*s == c)
 250:	38 d3                	cmp    %dl,%bl
 252:	89 d9                	mov    %ebx,%ecx
 254:	75 0e                	jne    264 <strchr+0x24>
 256:	eb 18                	jmp    270 <strchr+0x30>
 258:	90                   	nop
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 260:	38 ca                	cmp    %cl,%dl
 262:	74 0c                	je     270 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 264:	83 c0 01             	add    $0x1,%eax
 267:	0f b6 10             	movzbl (%eax),%edx
 26a:	84 d2                	test   %dl,%dl
 26c:	75 f2                	jne    260 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 26e:	31 c0                	xor    %eax,%eax
}
 270:	5b                   	pop    %ebx
 271:	c3                   	ret    
 272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 282:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 284:	56                   	push   %esi
 285:	53                   	push   %ebx
 286:	83 ec 1c             	sub    $0x1c,%esp
 289:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 28d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 291:	eb 2c                	jmp    2bf <gets+0x3f>
 293:	90                   	nop
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 298:	83 ec 04             	sub    $0x4,%esp
 29b:	6a 01                	push   $0x1
 29d:	55                   	push   %ebp
 29e:	6a 00                	push   $0x0
 2a0:	e8 14 01 00 00       	call   3b9 <read>
    if(cc < 1)
 2a5:	83 c4 10             	add    $0x10,%esp
 2a8:	85 c0                	test   %eax,%eax
 2aa:	7e 1c                	jle    2c8 <gets+0x48>
      break;
    buf[i++] = c;
 2ac:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 2b1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 2b3:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2b5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 2b9:	74 25                	je     2e0 <gets+0x60>
 2bb:	3c 0d                	cmp    $0xd,%al
 2bd:	74 21                	je     2e0 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2bf:	8d 5f 01             	lea    0x1(%edi),%ebx
 2c2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 2c6:	7c d0                	jl     298 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2c8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 2cc:	83 c4 1c             	add    $0x1c,%esp
 2cf:	89 f0                	mov    %esi,%eax
 2d1:	5b                   	pop    %ebx
 2d2:	5e                   	pop    %esi
 2d3:	5f                   	pop    %edi
 2d4:	5d                   	pop    %ebp
 2d5:	c3                   	ret    
 2d6:	8d 76 00             	lea    0x0(%esi),%esi
 2d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e0:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2e2:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e4:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 2e8:	83 c4 1c             	add    $0x1c,%esp
 2eb:	5b                   	pop    %ebx
 2ec:	5e                   	pop    %esi
 2ed:	5f                   	pop    %edi
 2ee:	5d                   	pop    %ebp
 2ef:	c3                   	ret    

000002f0 <stat>:

int
stat(char *n, struct statv6 *st)
{
 2f0:	56                   	push   %esi
 2f1:	53                   	push   %ebx
 2f2:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f5:	6a 00                	push   $0x0
 2f7:	ff 74 24 1c          	pushl  0x1c(%esp)
 2fb:	e8 e1 00 00 00       	call   3e1 <open>
  if(fd < 0)
 300:	83 c4 10             	add    $0x10,%esp
 303:	85 c0                	test   %eax,%eax
 305:	78 29                	js     330 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 307:	83 ec 08             	sub    $0x8,%esp
 30a:	89 c3                	mov    %eax,%ebx
 30c:	ff 74 24 1c          	pushl  0x1c(%esp)
 310:	50                   	push   %eax
 311:	e8 e3 00 00 00       	call   3f9 <fstat>
 316:	89 c6                	mov    %eax,%esi
  close(fd);
 318:	89 1c 24             	mov    %ebx,(%esp)
 31b:	e8 a9 00 00 00       	call   3c9 <close>
  return r;
 320:	83 c4 10             	add    $0x10,%esp
 323:	89 f0                	mov    %esi,%eax
}
 325:	83 c4 04             	add    $0x4,%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	c3                   	ret    
 32b:	90                   	nop
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 335:	eb ee                	jmp    325 <stat+0x35>
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 340:	53                   	push   %ebx
 341:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 345:	0f be 11             	movsbl (%ecx),%edx
 348:	8d 42 d0             	lea    -0x30(%edx),%eax
 34b:	3c 09                	cmp    $0x9,%al
 34d:	b8 00 00 00 00       	mov    $0x0,%eax
 352:	77 19                	ja     36d <atoi+0x2d>
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 358:	8d 04 80             	lea    (%eax,%eax,4),%eax
 35b:	83 c1 01             	add    $0x1,%ecx
 35e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 362:	0f be 11             	movsbl (%ecx),%edx
 365:	8d 5a d0             	lea    -0x30(%edx),%ebx
 368:	80 fb 09             	cmp    $0x9,%bl
 36b:	76 eb                	jbe    358 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 36d:	5b                   	pop    %ebx
 36e:	c3                   	ret    
 36f:	90                   	nop

00000370 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 370:	56                   	push   %esi
 371:	53                   	push   %ebx
 372:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 376:	8b 44 24 0c          	mov    0xc(%esp),%eax
 37a:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 37e:	85 db                	test   %ebx,%ebx
 380:	7e 14                	jle    396 <memmove+0x26>
 382:	31 d2                	xor    %edx,%edx
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 388:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 38c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 38f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 392:	39 da                	cmp    %ebx,%edx
 394:	75 f2                	jne    388 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 396:	5b                   	pop    %ebx
 397:	5e                   	pop    %esi
 398:	c3                   	ret    

00000399 <fork>:
 399:	b8 01 00 00 00       	mov    $0x1,%eax
 39e:	cd 40                	int    $0x40
 3a0:	c3                   	ret    

000003a1 <exit>:
 3a1:	b8 02 00 00 00       	mov    $0x2,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <wait>:
 3a9:	b8 03 00 00 00       	mov    $0x3,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <pipe>:
 3b1:	b8 04 00 00 00       	mov    $0x4,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <read>:
 3b9:	b8 06 00 00 00       	mov    $0x6,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <write>:
 3c1:	b8 05 00 00 00       	mov    $0x5,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <close>:
 3c9:	b8 07 00 00 00       	mov    $0x7,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <kill>:
 3d1:	b8 08 00 00 00       	mov    $0x8,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <exec>:
 3d9:	b8 09 00 00 00       	mov    $0x9,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <open>:
 3e1:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <mknod>:
 3e9:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <unlink>:
 3f1:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <fstat>:
 3f9:	b8 0d 00 00 00       	mov    $0xd,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <link>:
 401:	b8 0e 00 00 00       	mov    $0xe,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <mkdir>:
 409:	b8 0f 00 00 00       	mov    $0xf,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <chdir>:
 411:	b8 10 00 00 00       	mov    $0x10,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <dup>:
 419:	b8 11 00 00 00       	mov    $0x11,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <getpid>:
 421:	b8 12 00 00 00       	mov    $0x12,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <sbrk>:
 429:	b8 13 00 00 00       	mov    $0x13,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <sleep>:
 431:	b8 14 00 00 00       	mov    $0x14,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    
 439:	66 90                	xchg   %ax,%ax
 43b:	66 90                	xchg   %ax,%ax
 43d:	66 90                	xchg   %ax,%ax
 43f:	90                   	nop

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	57                   	push   %edi
 442:	89 c7                	mov    %eax,%edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 449:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 44d:	85 db                	test   %ebx,%ebx
 44f:	74 77                	je     4c8 <printint+0x88>
 451:	89 d0                	mov    %edx,%eax
 453:	c1 e8 1f             	shr    $0x1f,%eax
 456:	84 c0                	test   %al,%al
 458:	74 6e                	je     4c8 <printint+0x88>
    neg = 1;
    x = -xx;
 45a:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 45c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 463:	00 
    x = -xx;
 464:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 466:	31 ed                	xor    %ebp,%ebp
 468:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 46c:	eb 04                	jmp    472 <printint+0x32>
 46e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 470:	89 f5                	mov    %esi,%ebp
 472:	31 d2                	xor    %edx,%edx
 474:	8d 75 01             	lea    0x1(%ebp),%esi
 477:	f7 f1                	div    %ecx
 479:	0f b6 92 48 08 00 00 	movzbl 0x848(%edx),%edx
  }while((x /= base) != 0);
 480:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 482:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 485:	75 e9                	jne    470 <printint+0x30>
  if(neg)
 487:	8b 44 24 0c          	mov    0xc(%esp),%eax
 48b:	85 c0                	test   %eax,%eax
 48d:	74 08                	je     497 <printint+0x57>
    buf[i++] = '-';
 48f:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 494:	8d 75 02             	lea    0x2(%ebp),%esi
 497:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a3:	83 ec 04             	sub    $0x4,%esp
 4a6:	83 ee 01             	sub    $0x1,%esi
 4a9:	88 44 24 23          	mov    %al,0x23(%esp)
 4ad:	6a 01                	push   $0x1
 4af:	53                   	push   %ebx
 4b0:	57                   	push   %edi
 4b1:	e8 0b ff ff ff       	call   3c1 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b6:	83 c4 10             	add    $0x10,%esp
 4b9:	39 de                	cmp    %ebx,%esi
 4bb:	75 e3                	jne    4a0 <printint+0x60>
    putc(fd, buf[i]);
}
 4bd:	83 c4 3c             	add    $0x3c,%esp
 4c0:	5b                   	pop    %ebx
 4c1:	5e                   	pop    %esi
 4c2:	5f                   	pop    %edi
 4c3:	5d                   	pop    %ebp
 4c4:	c3                   	ret    
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4c8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4ca:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4d1:	00 
 4d2:	eb 92                	jmp    466 <printint+0x26>
 4d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	57                   	push   %edi
 4e2:	56                   	push   %esi
 4e3:	53                   	push   %ebx
 4e4:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e7:	8b 74 24 44          	mov    0x44(%esp),%esi
 4eb:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4ef:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f3:	89 44 24 0c          	mov    %eax,0xc(%esp)
 4f7:	0f b6 1e             	movzbl (%esi),%ebx
 4fa:	83 c6 01             	add    $0x1,%esi
 4fd:	84 db                	test   %bl,%bl
 4ff:	0f 84 ad 00 00 00    	je     5b2 <printf+0xd2>
 505:	31 ed                	xor    %ebp,%ebp
 507:	eb 32                	jmp    53b <printf+0x5b>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 510:	83 f8 25             	cmp    $0x25,%eax
 513:	0f 84 a7 00 00 00    	je     5c0 <printf+0xe0>
 519:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51d:	83 ec 04             	sub    $0x4,%esp
 520:	6a 01                	push   $0x1
 522:	8d 44 24 22          	lea    0x22(%esp),%eax
 526:	50                   	push   %eax
 527:	57                   	push   %edi
 528:	e8 94 fe ff ff       	call   3c1 <write>
 52d:	83 c4 10             	add    $0x10,%esp
 530:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 533:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 537:	84 db                	test   %bl,%bl
 539:	74 77                	je     5b2 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 53b:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 53d:	0f be cb             	movsbl %bl,%ecx
 540:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 543:	74 cb                	je     510 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 545:	83 fd 25             	cmp    $0x25,%ebp
 548:	75 e6                	jne    530 <printf+0x50>
      if(c == 'd'){
 54a:	83 f8 64             	cmp    $0x64,%eax
 54d:	0f 84 15 01 00 00    	je     668 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 553:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 559:	83 f9 70             	cmp    $0x70,%ecx
 55c:	74 72                	je     5d0 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 55e:	83 f8 73             	cmp    $0x73,%eax
 561:	0f 84 99 00 00 00    	je     600 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 567:	83 f8 63             	cmp    $0x63,%eax
 56a:	0f 84 07 01 00 00    	je     677 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 570:	83 f8 25             	cmp    $0x25,%eax
 573:	0f 84 d7 00 00 00    	je     650 <printf+0x170>
 579:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57e:	83 ec 04             	sub    $0x4,%esp
 581:	6a 01                	push   $0x1
 583:	8d 44 24 27          	lea    0x27(%esp),%eax
 587:	50                   	push   %eax
 588:	57                   	push   %edi
 589:	e8 33 fe ff ff       	call   3c1 <write>
 58e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 592:	83 c4 0c             	add    $0xc,%esp
 595:	6a 01                	push   $0x1
 597:	8d 44 24 26          	lea    0x26(%esp),%eax
 59b:	50                   	push   %eax
 59c:	57                   	push   %edi
 59d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a0:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a2:	e8 1a fe ff ff       	call   3c1 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ab:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ae:	84 db                	test   %bl,%bl
 5b0:	75 89                	jne    53b <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b2:	83 c4 2c             	add    $0x2c,%esp
 5b5:	5b                   	pop    %ebx
 5b6:	5e                   	pop    %esi
 5b7:	5f                   	pop    %edi
 5b8:	5d                   	pop    %ebp
 5b9:	c3                   	ret    
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5c0:	bd 25 00 00 00       	mov    $0x25,%ebp
 5c5:	e9 66 ff ff ff       	jmp    530 <printf+0x50>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d8:	6a 00                	push   $0x0
 5da:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 5de:	89 f8                	mov    %edi,%eax
 5e0:	8b 13                	mov    (%ebx),%edx
 5e2:	e8 59 fe ff ff       	call   440 <printint>
        ap++;
 5e7:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e9:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 5eb:	83 c0 04             	add    $0x4,%eax
 5ee:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 5f2:	83 c4 10             	add    $0x10,%esp
 5f5:	e9 36 ff ff ff       	jmp    530 <printf+0x50>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 600:	8b 44 24 0c          	mov    0xc(%esp),%eax
 604:	8b 28                	mov    (%eax),%ebp
        ap++;
 606:	83 c0 04             	add    $0x4,%eax
 609:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 60d:	b8 40 08 00 00       	mov    $0x840,%eax
 612:	85 ed                	test   %ebp,%ebp
 614:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 617:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 61b:	84 c0                	test   %al,%al
 61d:	74 27                	je     646 <printf+0x166>
 61f:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 623:	90                   	nop
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 628:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62c:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 62f:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 632:	6a 01                	push   $0x1
 634:	53                   	push   %ebx
 635:	57                   	push   %edi
 636:	e8 86 fd ff ff       	call   3c1 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63b:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 63f:	83 c4 10             	add    $0x10,%esp
 642:	84 c0                	test   %al,%al
 644:	75 e2                	jne    628 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 646:	31 ed                	xor    %ebp,%ebp
 648:	e9 e3 fe ff ff       	jmp    530 <printf+0x50>
 64d:	8d 76 00             	lea    0x0(%esi),%esi
 650:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 654:	83 ec 04             	sub    $0x4,%esp
 657:	6a 01                	push   $0x1
 659:	8d 44 24 25          	lea    0x25(%esp),%eax
 65d:	e9 39 ff ff ff       	jmp    59b <printf+0xbb>
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 668:	83 ec 0c             	sub    $0xc,%esp
 66b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 670:	6a 01                	push   $0x1
 672:	e9 63 ff ff ff       	jmp    5da <printf+0xfa>
 677:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 67b:	83 ec 04             	sub    $0x4,%esp
 67e:	8b 03                	mov    (%ebx),%eax
 680:	88 44 24 20          	mov    %al,0x20(%esp)
 684:	6a 01                	push   $0x1
 686:	8d 44 24 24          	lea    0x24(%esp),%eax
 68a:	50                   	push   %eax
 68b:	57                   	push   %edi
 68c:	e8 30 fd ff ff       	call   3c1 <write>
 691:	e9 51 ff ff ff       	jmp    5e7 <printf+0x107>
 696:	66 90                	xchg   %ax,%ax
 698:	66 90                	xchg   %ax,%ax
 69a:	66 90                	xchg   %ax,%ax
 69c:	66 90                	xchg   %ax,%ax
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	57                   	push   %edi
 6a1:	56                   	push   %esi
 6a2:	53                   	push   %ebx
 6a3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a7:	a1 20 0c 00 00       	mov    0xc20,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 6ac:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6af:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b1:	39 c8                	cmp    %ecx,%eax
 6b3:	73 13                	jae    6c8 <free+0x28>
 6b5:	8d 76 00             	lea    0x0(%esi),%esi
 6b8:	39 d1                	cmp    %edx,%ecx
 6ba:	72 14                	jb     6d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6bc:	39 d0                	cmp    %edx,%eax
 6be:	73 10                	jae    6d0 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c6:	72 f0                	jb     6b8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c8:	39 d0                	cmp    %edx,%eax
 6ca:	72 f4                	jb     6c0 <free+0x20>
 6cc:	39 d1                	cmp    %edx,%ecx
 6ce:	73 f0                	jae    6c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6d6:	39 d7                	cmp    %edx,%edi
 6d8:	74 18                	je     6f2 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 50 04             	mov    0x4(%eax),%edx
 6e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	74 20                	je     707 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6e7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6e9:	a3 20 0c 00 00       	mov    %eax,0xc20
}
 6ee:	5b                   	pop    %ebx
 6ef:	5e                   	pop    %esi
 6f0:	5f                   	pop    %edi
 6f1:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f2:	03 72 04             	add    0x4(%edx),%esi
 6f5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f8:	8b 12                	mov    (%edx),%edx
 6fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fd:	8b 50 04             	mov    0x4(%eax),%edx
 700:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 703:	39 f1                	cmp    %esi,%ecx
 705:	75 e0                	jne    6e7 <free+0x47>
    p->s.size += bp->s.size;
 707:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 70a:	a3 20 0c 00 00       	mov    %eax,0xc20
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 70f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 712:	8b 53 f8             	mov    -0x8(%ebx),%edx
 715:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 717:	5b                   	pop    %ebx
 718:	5e                   	pop    %esi
 719:	5f                   	pop    %edi
 71a:	c3                   	ret    
 71b:	90                   	nop
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	57                   	push   %edi
 721:	56                   	push   %esi
 722:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 723:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 727:	8b 15 20 0c 00 00    	mov    0xc20,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 72d:	8d 78 07             	lea    0x7(%eax),%edi
 730:	c1 ef 03             	shr    $0x3,%edi
 733:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 736:	85 d2                	test   %edx,%edx
 738:	0f 84 a0 00 00 00    	je     7de <malloc+0xbe>
 73e:	8b 02                	mov    (%edx),%eax
 740:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 743:	39 cf                	cmp    %ecx,%edi
 745:	76 71                	jbe    7b8 <malloc+0x98>
 747:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 74d:	be 00 10 00 00       	mov    $0x1000,%esi
 752:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 759:	0f 43 f7             	cmovae %edi,%esi
 75c:	ba 00 80 00 00       	mov    $0x8000,%edx
 761:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 767:	0f 46 da             	cmovbe %edx,%ebx
 76a:	eb 0d                	jmp    779 <malloc+0x59>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 772:	8b 48 04             	mov    0x4(%eax),%ecx
 775:	39 cf                	cmp    %ecx,%edi
 777:	76 3f                	jbe    7b8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 779:	39 05 20 0c 00 00    	cmp    %eax,0xc20
 77f:	89 c2                	mov    %eax,%edx
 781:	75 ed                	jne    770 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	53                   	push   %ebx
 787:	e8 9d fc ff ff       	call   429 <sbrk>
  if(p == (char*) -1)
 78c:	83 c4 10             	add    $0x10,%esp
 78f:	83 f8 ff             	cmp    $0xffffffff,%eax
 792:	74 1c                	je     7b0 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 794:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 797:	83 ec 0c             	sub    $0xc,%esp
 79a:	83 c0 08             	add    $0x8,%eax
 79d:	50                   	push   %eax
 79e:	e8 fd fe ff ff       	call   6a0 <free>
  return freep;
 7a3:	8b 15 20 0c 00 00    	mov    0xc20,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7a9:	83 c4 10             	add    $0x10,%esp
 7ac:	85 d2                	test   %edx,%edx
 7ae:	75 c0                	jne    770 <malloc+0x50>
        return 0;
 7b0:	31 c0                	xor    %eax,%eax
 7b2:	eb 1c                	jmp    7d0 <malloc+0xb0>
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7b8:	39 cf                	cmp    %ecx,%edi
 7ba:	74 1c                	je     7d8 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7bc:	29 f9                	sub    %edi,%ecx
 7be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7c4:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 7c7:	89 15 20 0c 00 00    	mov    %edx,0xc20
      return (void*) (p + 1);
 7cd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7d0:	5b                   	pop    %ebx
 7d1:	5e                   	pop    %esi
 7d2:	5f                   	pop    %edi
 7d3:	c3                   	ret    
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7d8:	8b 08                	mov    (%eax),%ecx
 7da:	89 0a                	mov    %ecx,(%edx)
 7dc:	eb e9                	jmp    7c7 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7de:	c7 05 20 0c 00 00 24 	movl   $0xc24,0xc20
 7e5:	0c 00 00 
 7e8:	c7 05 24 0c 00 00 24 	movl   $0xc24,0xc24
 7ef:	0c 00 00 
    base.s.size = 0;
 7f2:	b8 24 0c 00 00       	mov    $0xc24,%eax
 7f7:	c7 05 28 0c 00 00 00 	movl   $0x0,0xc28
 7fe:	00 00 00 
 801:	e9 41 ff ff ff       	jmp    747 <malloc+0x27>
