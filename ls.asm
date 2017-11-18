
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
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
  11:	bb 01 00 00 00       	mov    $0x1,%ebx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 1f                	jle    42 <main+0x42>
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 34 9f             	pushl  (%edi,%ebx,4)

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  2e:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  31:	e8 ca 00 00 00       	call   100 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  36:	83 c4 10             	add    $0x10,%esp
  39:	39 de                	cmp    %ebx,%esi
  3b:	75 eb                	jne    28 <main+0x28>
    ls(argv[i]);
  exit();
  3d:	e8 df 04 00 00       	call   521 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  42:	83 ec 0c             	sub    $0xc,%esp
  45:	68 d0 09 00 00       	push   $0x9d0
  4a:	e8 b1 00 00 00       	call   100 <ls>
    exit();
  4f:	e8 cd 04 00 00       	call   521 <exit>
  54:	66 90                	xchg   %ax,%ax
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  60:	56                   	push   %esi
  61:	53                   	push   %ebx
  62:	83 ec 10             	sub    $0x10,%esp
  65:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  69:	53                   	push   %ebx
  6a:	e8 11 03 00 00       	call   380 <strlen>
  6f:	83 c4 10             	add    $0x10,%esp
  72:	01 d8                	add    %ebx,%eax
  74:	73 11                	jae    87 <fmtname+0x27>
  76:	eb 14                	jmp    8c <fmtname+0x2c>
  78:	90                   	nop
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  80:	83 e8 01             	sub    $0x1,%eax
  83:	39 c3                	cmp    %eax,%ebx
  85:	77 05                	ja     8c <fmtname+0x2c>
  87:	80 38 2f             	cmpb   $0x2f,(%eax)
  8a:	75 f4                	jne    80 <fmtname+0x20>
    ;
  p++;
  8c:	8d 58 01             	lea    0x1(%eax),%ebx
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  8f:	83 ec 0c             	sub    $0xc,%esp
  92:	53                   	push   %ebx
  93:	e8 e8 02 00 00       	call   380 <strlen>
  98:	83 c4 10             	add    $0x10,%esp
  9b:	83 f8 0d             	cmp    $0xd,%eax
  9e:	77 4a                	ja     ea <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
  a0:	83 ec 0c             	sub    $0xc,%esp
  a3:	53                   	push   %ebx
  a4:	e8 d7 02 00 00       	call   380 <strlen>
  a9:	83 c4 0c             	add    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	53                   	push   %ebx
  ae:	68 f8 0e 00 00       	push   $0xef8
  b3:	e8 38 04 00 00       	call   4f0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 1c 24             	mov    %ebx,(%esp)
  bb:	e8 c0 02 00 00       	call   380 <strlen>
  c0:	89 1c 24             	mov    %ebx,(%esp)
  c3:	89 c6                	mov    %eax,%esi
  return buf;
  c5:	bb f8 0e 00 00       	mov    $0xef8,%ebx
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	e8 b1 02 00 00       	call   380 <strlen>
  cf:	ba 0e 00 00 00       	mov    $0xe,%edx
  d4:	83 c4 0c             	add    $0xc,%esp
  d7:	05 f8 0e 00 00       	add    $0xef8,%eax
  dc:	29 f2                	sub    %esi,%edx
  de:	52                   	push   %edx
  df:	6a 20                	push   $0x20
  e1:	50                   	push   %eax
  e2:	e8 b9 02 00 00       	call   3a0 <memset>
  return buf;
  e7:	83 c4 10             	add    $0x10,%esp
}
  ea:	83 c4 04             	add    $0x4,%esp
  ed:	89 d8                	mov    %ebx,%eax
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	c3                   	ret    
  f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <ls>:

void
ls(char *path)
{
 100:	55                   	push   %ebp
 101:	57                   	push   %edi
 102:	56                   	push   %esi
 103:	53                   	push   %ebx
 104:	81 ec 64 02 00 00    	sub    $0x264,%esp
 10a:	8b bc 24 78 02 00 00 	mov    0x278(%esp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct statv6 st;
  
  if((fd = open(path, 0)) < 0){
 111:	6a 00                	push   $0x0
 113:	57                   	push   %edi
 114:	e8 48 04 00 00       	call   561 <open>
 119:	83 c4 10             	add    $0x10,%esp
 11c:	85 c0                	test   %eax,%eax
 11e:	0f 88 54 01 00 00    	js     278 <ls+0x178>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
 124:	83 ec 08             	sub    $0x8,%esp
 127:	89 c3                	mov    %eax,%ebx
 129:	8d 74 24 44          	lea    0x44(%esp),%esi
 12d:	56                   	push   %esi
 12e:	50                   	push   %eax
 12f:	e8 45 04 00 00       	call   579 <fstat>
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	0f 88 81 01 00 00    	js     2c0 <ls+0x1c0>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  
  switch(st.type){
 13f:	0f b7 44 24 3c       	movzwl 0x3c(%esp),%eax
 144:	66 83 f8 01          	cmp    $0x1,%ax
 148:	74 46                	je     190 <ls+0x90>
 14a:	66 83 f8 02          	cmp    $0x2,%ax
 14e:	75 27                	jne    177 <ls+0x77>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 150:	8b 6c 24 4c          	mov    0x4c(%esp),%ebp
 154:	8b 74 24 44          	mov    0x44(%esp),%esi
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	57                   	push   %edi
 15c:	e8 ff fe ff ff       	call   60 <fmtname>
 161:	59                   	pop    %ecx
 162:	5f                   	pop    %edi
 163:	55                   	push   %ebp
 164:	56                   	push   %esi
 165:	6a 02                	push   $0x2
 167:	50                   	push   %eax
 168:	68 b0 09 00 00       	push   $0x9b0
 16d:	6a 01                	push   $0x1
 16f:	e8 ec 04 00 00       	call   660 <printf>
    break;
 174:	83 c4 20             	add    $0x20,%esp
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 177:	83 ec 0c             	sub    $0xc,%esp
 17a:	53                   	push   %ebx
 17b:	e8 c9 03 00 00       	call   549 <close>
 180:	83 c4 10             	add    $0x10,%esp
}
 183:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 189:	5b                   	pop    %ebx
 18a:	5e                   	pop    %esi
 18b:	5f                   	pop    %edi
 18c:	5d                   	pop    %ebp
 18d:	c3                   	ret    
 18e:	66 90                	xchg   %ax,%ax
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 190:	83 ec 0c             	sub    $0xc,%esp
 193:	57                   	push   %edi
 194:	e8 e7 01 00 00       	call   380 <strlen>
 199:	83 c0 10             	add    $0x10,%eax
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a4:	0f 87 f6 00 00 00    	ja     2a0 <ls+0x1a0>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 1aa:	83 ec 08             	sub    $0x8,%esp
 1ad:	57                   	push   %edi
 1ae:	8d 6c 24 5c          	lea    0x5c(%esp),%ebp
 1b2:	55                   	push   %ebp
 1b3:	e8 48 01 00 00       	call   300 <strcpy>
    p = buf+strlen(buf);
 1b8:	89 2c 24             	mov    %ebp,(%esp)
 1bb:	e8 c0 01 00 00       	call   380 <strlen>
 1c0:	8d 54 05 00          	lea    0x0(%ebp,%eax,1),%edx
    *p++ = '/';
 1c4:	8d 44 05 01          	lea    0x1(%ebp,%eax,1),%eax
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
 1c8:	89 54 24 28          	mov    %edx,0x28(%esp)
    *p++ = '/';
 1cc:	89 44 24 2c          	mov    %eax,0x2c(%esp)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	8d 7c 24 2c          	lea    0x2c(%esp),%edi
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
 1d7:	c6 02 2f             	movb   $0x2f,(%edx)
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e0:	83 ec 04             	sub    $0x4,%esp
 1e3:	6a 10                	push   $0x10
 1e5:	57                   	push   %edi
 1e6:	53                   	push   %ebx
 1e7:	e8 4d 03 00 00       	call   539 <read>
 1ec:	83 c4 10             	add    $0x10,%esp
 1ef:	83 f8 10             	cmp    $0x10,%eax
 1f2:	75 83                	jne    177 <ls+0x77>
      if(de.inum == 0)
 1f4:	66 83 7c 24 2c 00    	cmpw   $0x0,0x2c(%esp)
 1fa:	74 e4                	je     1e0 <ls+0xe0>
        continue;
      memmove(p, de.name, DIRSIZ);
 1fc:	83 ec 04             	sub    $0x4,%esp
 1ff:	6a 0e                	push   $0xe
 201:	8d 44 24 36          	lea    0x36(%esp),%eax
 205:	50                   	push   %eax
 206:	ff 74 24 28          	pushl  0x28(%esp)
 20a:	e8 e1 02 00 00       	call   4f0 <memmove>
      p[DIRSIZ] = 0;
 20f:	8b 44 24 28          	mov    0x28(%esp),%eax
 213:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 217:	58                   	pop    %eax
 218:	5a                   	pop    %edx
 219:	56                   	push   %esi
 21a:	55                   	push   %ebp
 21b:	e8 50 02 00 00       	call   470 <stat>
 220:	83 c4 10             	add    $0x10,%esp
 223:	85 c0                	test   %eax,%eax
 225:	0f 88 b5 00 00 00    	js     2e0 <ls+0x1e0>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 22b:	0f bf 44 24 3c       	movswl 0x3c(%esp),%eax
 230:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
 234:	83 ec 0c             	sub    $0xc,%esp
 237:	8b 54 24 50          	mov    0x50(%esp),%edx
 23b:	89 4c 24 20          	mov    %ecx,0x20(%esp)
 23f:	89 54 24 1c          	mov    %edx,0x1c(%esp)
 243:	89 44 24 18          	mov    %eax,0x18(%esp)
 247:	55                   	push   %ebp
 248:	e8 13 fe ff ff       	call   60 <fmtname>
 24d:	5a                   	pop    %edx
 24e:	59                   	pop    %ecx
 24f:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
 253:	51                   	push   %ecx
 254:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 258:	52                   	push   %edx
 259:	ff 74 24 1c          	pushl  0x1c(%esp)
 25d:	50                   	push   %eax
 25e:	68 b0 09 00 00       	push   $0x9b0
 263:	6a 01                	push   $0x1
 265:	e8 f6 03 00 00       	call   660 <printf>
 26a:	83 c4 20             	add    $0x20,%esp
 26d:	e9 6e ff ff ff       	jmp    1e0 <ls+0xe0>
 272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct dirent de;
  struct statv6 st;
  
  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 278:	83 ec 04             	sub    $0x4,%esp
 27b:	57                   	push   %edi
 27c:	68 88 09 00 00       	push   $0x988
 281:	6a 02                	push   $0x2
 283:	e8 d8 03 00 00       	call   660 <printf>
    return;
 288:	83 c4 10             	add    $0x10,%esp
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 28b:	81 c4 5c 02 00 00    	add    $0x25c,%esp
 291:	5b                   	pop    %ebx
 292:	5e                   	pop    %esi
 293:	5f                   	pop    %edi
 294:	5d                   	pop    %ebp
 295:	c3                   	ret    
 296:	8d 76 00             	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 2a0:	83 ec 08             	sub    $0x8,%esp
 2a3:	68 bd 09 00 00       	push   $0x9bd
 2a8:	6a 01                	push   $0x1
 2aa:	e8 b1 03 00 00       	call   660 <printf>
      break;
 2af:	83 c4 10             	add    $0x10,%esp
 2b2:	e9 c0 fe ff ff       	jmp    177 <ls+0x77>
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }
  
  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	57                   	push   %edi
 2c4:	68 9c 09 00 00       	push   $0x99c
 2c9:	6a 02                	push   $0x2
 2cb:	e8 90 03 00 00       	call   660 <printf>
    close(fd);
 2d0:	89 1c 24             	mov    %ebx,(%esp)
 2d3:	e8 71 02 00 00       	call   549 <close>
    return;
 2d8:	83 c4 10             	add    $0x10,%esp
 2db:	e9 a3 fe ff ff       	jmp    183 <ls+0x83>
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	55                   	push   %ebp
 2e4:	68 9c 09 00 00       	push   $0x99c
 2e9:	6a 01                	push   $0x1
 2eb:	e8 70 03 00 00       	call   660 <printf>
        continue;
 2f0:	83 c4 10             	add    $0x10,%esp
 2f3:	e9 e8 fe ff ff       	jmp    1e0 <ls+0xe0>
 2f8:	66 90                	xchg   %ax,%ax
 2fa:	66 90                	xchg   %ax,%ax
 2fc:	66 90                	xchg   %ax,%ax
 2fe:	66 90                	xchg   %ax,%ax

00000300 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 300:	53                   	push   %ebx
 301:	8b 44 24 08          	mov    0x8(%esp),%eax
 305:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 309:	89 c2                	mov    %eax,%edx
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	83 c1 01             	add    $0x1,%ecx
 313:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 317:	83 c2 01             	add    $0x1,%edx
 31a:	84 db                	test   %bl,%bl
 31c:	88 5a ff             	mov    %bl,-0x1(%edx)
 31f:	75 ef                	jne    310 <strcpy+0x10>
    ;
  return os;
}
 321:	5b                   	pop    %ebx
 322:	c3                   	ret    
 323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 330:	56                   	push   %esi
 331:	53                   	push   %ebx
 332:	8b 54 24 0c          	mov    0xc(%esp),%edx
 336:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 33a:	0f b6 02             	movzbl (%edx),%eax
 33d:	0f b6 19             	movzbl (%ecx),%ebx
 340:	84 c0                	test   %al,%al
 342:	75 1f                	jne    363 <strcmp+0x33>
 344:	eb 2a                	jmp    370 <strcmp+0x40>
 346:	8d 76 00             	lea    0x0(%esi),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 350:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 353:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 356:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 359:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 35d:	84 c0                	test   %al,%al
 35f:	74 0f                	je     370 <strcmp+0x40>
 361:	89 f1                	mov    %esi,%ecx
 363:	38 d8                	cmp    %bl,%al
 365:	74 e9                	je     350 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 367:	29 d8                	sub    %ebx,%eax
}
 369:	5b                   	pop    %ebx
 36a:	5e                   	pop    %esi
 36b:	c3                   	ret    
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 370:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 372:	29 d8                	sub    %ebx,%eax
}
 374:	5b                   	pop    %ebx
 375:	5e                   	pop    %esi
 376:	c3                   	ret    
 377:	89 f6                	mov    %esi,%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <strlen>:

uint
strlen(char *s)
{
 380:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 384:	80 39 00             	cmpb   $0x0,(%ecx)
 387:	74 14                	je     39d <strlen+0x1d>
 389:	31 d2                	xor    %edx,%edx
 38b:	90                   	nop
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	83 c2 01             	add    $0x1,%edx
 393:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 397:	89 d0                	mov    %edx,%eax
 399:	75 f5                	jne    390 <strlen+0x10>
 39b:	f3 c3                	repz ret 
 39d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 39f:	c3                   	ret    

000003a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3a0:	57                   	push   %edi
 3a1:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3a5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 3a9:	8b 44 24 0c          	mov    0xc(%esp),%eax
 3ad:	89 d7                	mov    %edx,%edi
 3af:	fc                   	cld    
 3b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	5f                   	pop    %edi
 3b5:	c3                   	ret    
 3b6:	8d 76 00             	lea    0x0(%esi),%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <strchr>:

char*
strchr(const char *s, char c)
{
 3c0:	53                   	push   %ebx
 3c1:	8b 44 24 08          	mov    0x8(%esp),%eax
 3c5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 3c9:	0f b6 10             	movzbl (%eax),%edx
 3cc:	84 d2                	test   %dl,%dl
 3ce:	74 1e                	je     3ee <strchr+0x2e>
    if(*s == c)
 3d0:	38 d3                	cmp    %dl,%bl
 3d2:	89 d9                	mov    %ebx,%ecx
 3d4:	75 0e                	jne    3e4 <strchr+0x24>
 3d6:	eb 18                	jmp    3f0 <strchr+0x30>
 3d8:	90                   	nop
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3e0:	38 ca                	cmp    %cl,%dl
 3e2:	74 0c                	je     3f0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3e4:	83 c0 01             	add    $0x1,%eax
 3e7:	0f b6 10             	movzbl (%eax),%edx
 3ea:	84 d2                	test   %dl,%dl
 3ec:	75 f2                	jne    3e0 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 3ee:	31 c0                	xor    %eax,%eax
}
 3f0:	5b                   	pop    %ebx
 3f1:	c3                   	ret    
 3f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <gets>:

char*
gets(char *buf, int max)
{
 400:	55                   	push   %ebp
 401:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 402:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 1c             	sub    $0x1c,%esp
 409:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 40d:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 411:	eb 2c                	jmp    43f <gets+0x3f>
 413:	90                   	nop
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 418:	83 ec 04             	sub    $0x4,%esp
 41b:	6a 01                	push   $0x1
 41d:	55                   	push   %ebp
 41e:	6a 00                	push   $0x0
 420:	e8 14 01 00 00       	call   539 <read>
    if(cc < 1)
 425:	83 c4 10             	add    $0x10,%esp
 428:	85 c0                	test   %eax,%eax
 42a:	7e 1c                	jle    448 <gets+0x48>
      break;
    buf[i++] = c;
 42c:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 431:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 433:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 435:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 439:	74 25                	je     460 <gets+0x60>
 43b:	3c 0d                	cmp    $0xd,%al
 43d:	74 21                	je     460 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43f:	8d 5f 01             	lea    0x1(%edi),%ebx
 442:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 446:	7c d0                	jl     418 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 448:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 44c:	83 c4 1c             	add    $0x1c,%esp
 44f:	89 f0                	mov    %esi,%eax
 451:	5b                   	pop    %ebx
 452:	5e                   	pop    %esi
 453:	5f                   	pop    %edi
 454:	5d                   	pop    %ebp
 455:	c3                   	ret    
 456:	8d 76 00             	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 460:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 462:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 464:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 468:	83 c4 1c             	add    $0x1c,%esp
 46b:	5b                   	pop    %ebx
 46c:	5e                   	pop    %esi
 46d:	5f                   	pop    %edi
 46e:	5d                   	pop    %ebp
 46f:	c3                   	ret    

00000470 <stat>:

int
stat(char *n, struct statv6 *st)
{
 470:	56                   	push   %esi
 471:	53                   	push   %ebx
 472:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 475:	6a 00                	push   $0x0
 477:	ff 74 24 1c          	pushl  0x1c(%esp)
 47b:	e8 e1 00 00 00       	call   561 <open>
  if(fd < 0)
 480:	83 c4 10             	add    $0x10,%esp
 483:	85 c0                	test   %eax,%eax
 485:	78 29                	js     4b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 487:	83 ec 08             	sub    $0x8,%esp
 48a:	89 c3                	mov    %eax,%ebx
 48c:	ff 74 24 1c          	pushl  0x1c(%esp)
 490:	50                   	push   %eax
 491:	e8 e3 00 00 00       	call   579 <fstat>
 496:	89 c6                	mov    %eax,%esi
  close(fd);
 498:	89 1c 24             	mov    %ebx,(%esp)
 49b:	e8 a9 00 00 00       	call   549 <close>
  return r;
 4a0:	83 c4 10             	add    $0x10,%esp
 4a3:	89 f0                	mov    %esi,%eax
}
 4a5:	83 c4 04             	add    $0x4,%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	c3                   	ret    
 4ab:	90                   	nop
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4b5:	eb ee                	jmp    4a5 <stat+0x35>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4c0:	53                   	push   %ebx
 4c1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c5:	0f be 11             	movsbl (%ecx),%edx
 4c8:	8d 42 d0             	lea    -0x30(%edx),%eax
 4cb:	3c 09                	cmp    $0x9,%al
 4cd:	b8 00 00 00 00       	mov    $0x0,%eax
 4d2:	77 19                	ja     4ed <atoi+0x2d>
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 4d8:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4db:	83 c1 01             	add    $0x1,%ecx
 4de:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4e2:	0f be 11             	movsbl (%ecx),%edx
 4e5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4e8:	80 fb 09             	cmp    $0x9,%bl
 4eb:	76 eb                	jbe    4d8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 4ed:	5b                   	pop    %ebx
 4ee:	c3                   	ret    
 4ef:	90                   	nop

000004f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4f0:	56                   	push   %esi
 4f1:	53                   	push   %ebx
 4f2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 4f6:	8b 44 24 0c          	mov    0xc(%esp),%eax
 4fa:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4fe:	85 db                	test   %ebx,%ebx
 500:	7e 14                	jle    516 <memmove+0x26>
 502:	31 d2                	xor    %edx,%edx
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 508:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 50c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 50f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 512:	39 da                	cmp    %ebx,%edx
 514:	75 f2                	jne    508 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	c3                   	ret    

00000519 <fork>:
 519:	b8 01 00 00 00       	mov    $0x1,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <exit>:
 521:	b8 02 00 00 00       	mov    $0x2,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret    

00000529 <wait>:
 529:	b8 03 00 00 00       	mov    $0x3,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret    

00000531 <pipe>:
 531:	b8 04 00 00 00       	mov    $0x4,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret    

00000539 <read>:
 539:	b8 06 00 00 00       	mov    $0x6,%eax
 53e:	cd 40                	int    $0x40
 540:	c3                   	ret    

00000541 <write>:
 541:	b8 05 00 00 00       	mov    $0x5,%eax
 546:	cd 40                	int    $0x40
 548:	c3                   	ret    

00000549 <close>:
 549:	b8 07 00 00 00       	mov    $0x7,%eax
 54e:	cd 40                	int    $0x40
 550:	c3                   	ret    

00000551 <kill>:
 551:	b8 08 00 00 00       	mov    $0x8,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <exec>:
 559:	b8 09 00 00 00       	mov    $0x9,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <open>:
 561:	b8 0a 00 00 00       	mov    $0xa,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <mknod>:
 569:	b8 0b 00 00 00       	mov    $0xb,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <unlink>:
 571:	b8 0c 00 00 00       	mov    $0xc,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    

00000579 <fstat>:
 579:	b8 0d 00 00 00       	mov    $0xd,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <link>:
 581:	b8 0e 00 00 00       	mov    $0xe,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    

00000589 <mkdir>:
 589:	b8 0f 00 00 00       	mov    $0xf,%eax
 58e:	cd 40                	int    $0x40
 590:	c3                   	ret    

00000591 <chdir>:
 591:	b8 10 00 00 00       	mov    $0x10,%eax
 596:	cd 40                	int    $0x40
 598:	c3                   	ret    

00000599 <dup>:
 599:	b8 11 00 00 00       	mov    $0x11,%eax
 59e:	cd 40                	int    $0x40
 5a0:	c3                   	ret    

000005a1 <getpid>:
 5a1:	b8 12 00 00 00       	mov    $0x12,%eax
 5a6:	cd 40                	int    $0x40
 5a8:	c3                   	ret    

000005a9 <sbrk>:
 5a9:	b8 13 00 00 00       	mov    $0x13,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <sleep>:
 5b1:	b8 14 00 00 00       	mov    $0x14,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    
 5b9:	66 90                	xchg   %ax,%ax
 5bb:	66 90                	xchg   %ax,%ax
 5bd:	66 90                	xchg   %ax,%ax
 5bf:	90                   	nop

000005c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5c0:	55                   	push   %ebp
 5c1:	57                   	push   %edi
 5c2:	89 c7                	mov    %eax,%edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c9:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 5cd:	85 db                	test   %ebx,%ebx
 5cf:	74 77                	je     648 <printint+0x88>
 5d1:	89 d0                	mov    %edx,%eax
 5d3:	c1 e8 1f             	shr    $0x1f,%eax
 5d6:	84 c0                	test   %al,%al
 5d8:	74 6e                	je     648 <printint+0x88>
    neg = 1;
    x = -xx;
 5da:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5dc:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5e3:	00 
    x = -xx;
 5e4:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 5e6:	31 ed                	xor    %ebp,%ebp
 5e8:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 5ec:	eb 04                	jmp    5f2 <printint+0x32>
 5ee:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 5f0:	89 f5                	mov    %esi,%ebp
 5f2:	31 d2                	xor    %edx,%edx
 5f4:	8d 75 01             	lea    0x1(%ebp),%esi
 5f7:	f7 f1                	div    %ecx
 5f9:	0f b6 92 dc 09 00 00 	movzbl 0x9dc(%edx),%edx
  }while((x /= base) != 0);
 600:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 602:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 605:	75 e9                	jne    5f0 <printint+0x30>
  if(neg)
 607:	8b 44 24 0c          	mov    0xc(%esp),%eax
 60b:	85 c0                	test   %eax,%eax
 60d:	74 08                	je     617 <printint+0x57>
    buf[i++] = '-';
 60f:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 614:	8d 75 02             	lea    0x2(%ebp),%esi
 617:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 61b:	90                   	nop
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 623:	83 ec 04             	sub    $0x4,%esp
 626:	83 ee 01             	sub    $0x1,%esi
 629:	88 44 24 23          	mov    %al,0x23(%esp)
 62d:	6a 01                	push   $0x1
 62f:	53                   	push   %ebx
 630:	57                   	push   %edi
 631:	e8 0b ff ff ff       	call   541 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 636:	83 c4 10             	add    $0x10,%esp
 639:	39 de                	cmp    %ebx,%esi
 63b:	75 e3                	jne    620 <printint+0x60>
    putc(fd, buf[i]);
}
 63d:	83 c4 3c             	add    $0x3c,%esp
 640:	5b                   	pop    %ebx
 641:	5e                   	pop    %esi
 642:	5f                   	pop    %edi
 643:	5d                   	pop    %ebp
 644:	c3                   	ret    
 645:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 648:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 64a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 651:	00 
 652:	eb 92                	jmp    5e6 <printint+0x26>
 654:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 65a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000660 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 660:	55                   	push   %ebp
 661:	57                   	push   %edi
 662:	56                   	push   %esi
 663:	53                   	push   %ebx
 664:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 667:	8b 74 24 44          	mov    0x44(%esp),%esi
 66b:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 66f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 673:	89 44 24 0c          	mov    %eax,0xc(%esp)
 677:	0f b6 1e             	movzbl (%esi),%ebx
 67a:	83 c6 01             	add    $0x1,%esi
 67d:	84 db                	test   %bl,%bl
 67f:	0f 84 ad 00 00 00    	je     732 <printf+0xd2>
 685:	31 ed                	xor    %ebp,%ebp
 687:	eb 32                	jmp    6bb <printf+0x5b>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 690:	83 f8 25             	cmp    $0x25,%eax
 693:	0f 84 a7 00 00 00    	je     740 <printf+0xe0>
 699:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69d:	83 ec 04             	sub    $0x4,%esp
 6a0:	6a 01                	push   $0x1
 6a2:	8d 44 24 22          	lea    0x22(%esp),%eax
 6a6:	50                   	push   %eax
 6a7:	57                   	push   %edi
 6a8:	e8 94 fe ff ff       	call   541 <write>
 6ad:	83 c4 10             	add    $0x10,%esp
 6b0:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6b3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6b7:	84 db                	test   %bl,%bl
 6b9:	74 77                	je     732 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 6bb:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6bd:	0f be cb             	movsbl %bl,%ecx
 6c0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6c3:	74 cb                	je     690 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c5:	83 fd 25             	cmp    $0x25,%ebp
 6c8:	75 e6                	jne    6b0 <printf+0x50>
      if(c == 'd'){
 6ca:	83 f8 64             	cmp    $0x64,%eax
 6cd:	0f 84 15 01 00 00    	je     7e8 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6d3:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6d9:	83 f9 70             	cmp    $0x70,%ecx
 6dc:	74 72                	je     750 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6de:	83 f8 73             	cmp    $0x73,%eax
 6e1:	0f 84 99 00 00 00    	je     780 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e7:	83 f8 63             	cmp    $0x63,%eax
 6ea:	0f 84 07 01 00 00    	je     7f7 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6f0:	83 f8 25             	cmp    $0x25,%eax
 6f3:	0f 84 d7 00 00 00    	je     7d0 <printf+0x170>
 6f9:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fe:	83 ec 04             	sub    $0x4,%esp
 701:	6a 01                	push   $0x1
 703:	8d 44 24 27          	lea    0x27(%esp),%eax
 707:	50                   	push   %eax
 708:	57                   	push   %edi
 709:	e8 33 fe ff ff       	call   541 <write>
 70e:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 712:	83 c4 0c             	add    $0xc,%esp
 715:	6a 01                	push   $0x1
 717:	8d 44 24 26          	lea    0x26(%esp),%eax
 71b:	50                   	push   %eax
 71c:	57                   	push   %edi
 71d:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 720:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 722:	e8 1a fe ff ff       	call   541 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 727:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 72b:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 72e:	84 db                	test   %bl,%bl
 730:	75 89                	jne    6bb <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 732:	83 c4 2c             	add    $0x2c,%esp
 735:	5b                   	pop    %ebx
 736:	5e                   	pop    %esi
 737:	5f                   	pop    %edi
 738:	5d                   	pop    %ebp
 739:	c3                   	ret    
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 740:	bd 25 00 00 00       	mov    $0x25,%ebp
 745:	e9 66 ff ff ff       	jmp    6b0 <printf+0x50>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 750:	83 ec 0c             	sub    $0xc,%esp
 753:	b9 10 00 00 00       	mov    $0x10,%ecx
 758:	6a 00                	push   $0x0
 75a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 75e:	89 f8                	mov    %edi,%eax
 760:	8b 13                	mov    (%ebx),%edx
 762:	e8 59 fe ff ff       	call   5c0 <printint>
        ap++;
 767:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 769:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 76b:	83 c0 04             	add    $0x4,%eax
 76e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 772:	83 c4 10             	add    $0x10,%esp
 775:	e9 36 ff ff ff       	jmp    6b0 <printf+0x50>
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 780:	8b 44 24 0c          	mov    0xc(%esp),%eax
 784:	8b 28                	mov    (%eax),%ebp
        ap++;
 786:	83 c0 04             	add    $0x4,%eax
 789:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 78d:	b8 d2 09 00 00       	mov    $0x9d2,%eax
 792:	85 ed                	test   %ebp,%ebp
 794:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 797:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 79b:	84 c0                	test   %al,%al
 79d:	74 27                	je     7c6 <printf+0x166>
 79f:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 7a3:	90                   	nop
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7a8:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ac:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7af:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7b2:	6a 01                	push   $0x1
 7b4:	53                   	push   %ebx
 7b5:	57                   	push   %edi
 7b6:	e8 86 fd ff ff       	call   541 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7bb:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 7bf:	83 c4 10             	add    $0x10,%esp
 7c2:	84 c0                	test   %al,%al
 7c4:	75 e2                	jne    7a8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c6:	31 ed                	xor    %ebp,%ebp
 7c8:	e9 e3 fe ff ff       	jmp    6b0 <printf+0x50>
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
 7d0:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7d4:	83 ec 04             	sub    $0x4,%esp
 7d7:	6a 01                	push   $0x1
 7d9:	8d 44 24 25          	lea    0x25(%esp),%eax
 7dd:	e9 39 ff ff ff       	jmp    71b <printf+0xbb>
 7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7e8:	83 ec 0c             	sub    $0xc,%esp
 7eb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7f0:	6a 01                	push   $0x1
 7f2:	e9 63 ff ff ff       	jmp    75a <printf+0xfa>
 7f7:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7fb:	83 ec 04             	sub    $0x4,%esp
 7fe:	8b 03                	mov    (%ebx),%eax
 800:	88 44 24 20          	mov    %al,0x20(%esp)
 804:	6a 01                	push   $0x1
 806:	8d 44 24 24          	lea    0x24(%esp),%eax
 80a:	50                   	push   %eax
 80b:	57                   	push   %edi
 80c:	e8 30 fd ff ff       	call   541 <write>
 811:	e9 51 ff ff ff       	jmp    767 <printf+0x107>
 816:	66 90                	xchg   %ax,%ax
 818:	66 90                	xchg   %ax,%ax
 81a:	66 90                	xchg   %ax,%ax
 81c:	66 90                	xchg   %ax,%ax
 81e:	66 90                	xchg   %ax,%ax

00000820 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 820:	57                   	push   %edi
 821:	56                   	push   %esi
 822:	53                   	push   %ebx
 823:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 827:	a1 08 0f 00 00       	mov    0xf08,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 82c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82f:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 831:	39 c8                	cmp    %ecx,%eax
 833:	73 13                	jae    848 <free+0x28>
 835:	8d 76 00             	lea    0x0(%esi),%esi
 838:	39 d1                	cmp    %edx,%ecx
 83a:	72 14                	jb     850 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 83c:	39 d0                	cmp    %edx,%eax
 83e:	73 10                	jae    850 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 840:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 842:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 844:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 846:	72 f0                	jb     838 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 848:	39 d0                	cmp    %edx,%eax
 84a:	72 f4                	jb     840 <free+0x20>
 84c:	39 d1                	cmp    %edx,%ecx
 84e:	73 f0                	jae    840 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 850:	8b 73 fc             	mov    -0x4(%ebx),%esi
 853:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 856:	39 d7                	cmp    %edx,%edi
 858:	74 18                	je     872 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 85a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 85d:	8b 50 04             	mov    0x4(%eax),%edx
 860:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 863:	39 f1                	cmp    %esi,%ecx
 865:	74 20                	je     887 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 867:	89 08                	mov    %ecx,(%eax)
  freep = p;
 869:	a3 08 0f 00 00       	mov    %eax,0xf08
}
 86e:	5b                   	pop    %ebx
 86f:	5e                   	pop    %esi
 870:	5f                   	pop    %edi
 871:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 872:	03 72 04             	add    0x4(%edx),%esi
 875:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 878:	8b 12                	mov    (%edx),%edx
 87a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 87d:	8b 50 04             	mov    0x4(%eax),%edx
 880:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 883:	39 f1                	cmp    %esi,%ecx
 885:	75 e0                	jne    867 <free+0x47>
    p->s.size += bp->s.size;
 887:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 88a:	a3 08 0f 00 00       	mov    %eax,0xf08
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 88f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 892:	8b 53 f8             	mov    -0x8(%ebx),%edx
 895:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 897:	5b                   	pop    %ebx
 898:	5e                   	pop    %esi
 899:	5f                   	pop    %edi
 89a:	c3                   	ret    
 89b:	90                   	nop
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a0:	57                   	push   %edi
 8a1:	56                   	push   %esi
 8a2:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a3:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 8a7:	8b 15 08 0f 00 00    	mov    0xf08,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ad:	8d 78 07             	lea    0x7(%eax),%edi
 8b0:	c1 ef 03             	shr    $0x3,%edi
 8b3:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8b6:	85 d2                	test   %edx,%edx
 8b8:	0f 84 a0 00 00 00    	je     95e <malloc+0xbe>
 8be:	8b 02                	mov    (%edx),%eax
 8c0:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8c3:	39 cf                	cmp    %ecx,%edi
 8c5:	76 71                	jbe    938 <malloc+0x98>
 8c7:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8cd:	be 00 10 00 00       	mov    $0x1000,%esi
 8d2:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8d9:	0f 43 f7             	cmovae %edi,%esi
 8dc:	ba 00 80 00 00       	mov    $0x8000,%edx
 8e1:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8e7:	0f 46 da             	cmovbe %edx,%ebx
 8ea:	eb 0d                	jmp    8f9 <malloc+0x59>
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8f2:	8b 48 04             	mov    0x4(%eax),%ecx
 8f5:	39 cf                	cmp    %ecx,%edi
 8f7:	76 3f                	jbe    938 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 8f9:	39 05 08 0f 00 00    	cmp    %eax,0xf08
 8ff:	89 c2                	mov    %eax,%edx
 901:	75 ed                	jne    8f0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 903:	83 ec 0c             	sub    $0xc,%esp
 906:	53                   	push   %ebx
 907:	e8 9d fc ff ff       	call   5a9 <sbrk>
  if(p == (char*) -1)
 90c:	83 c4 10             	add    $0x10,%esp
 90f:	83 f8 ff             	cmp    $0xffffffff,%eax
 912:	74 1c                	je     930 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 914:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 917:	83 ec 0c             	sub    $0xc,%esp
 91a:	83 c0 08             	add    $0x8,%eax
 91d:	50                   	push   %eax
 91e:	e8 fd fe ff ff       	call   820 <free>
  return freep;
 923:	8b 15 08 0f 00 00    	mov    0xf08,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 929:	83 c4 10             	add    $0x10,%esp
 92c:	85 d2                	test   %edx,%edx
 92e:	75 c0                	jne    8f0 <malloc+0x50>
        return 0;
 930:	31 c0                	xor    %eax,%eax
 932:	eb 1c                	jmp    950 <malloc+0xb0>
 934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 938:	39 cf                	cmp    %ecx,%edi
 93a:	74 1c                	je     958 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 93c:	29 f9                	sub    %edi,%ecx
 93e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 941:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 944:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 947:	89 15 08 0f 00 00    	mov    %edx,0xf08
      return (void*) (p + 1);
 94d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 950:	5b                   	pop    %ebx
 951:	5e                   	pop    %esi
 952:	5f                   	pop    %edi
 953:	c3                   	ret    
 954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 958:	8b 08                	mov    (%eax),%ecx
 95a:	89 0a                	mov    %ecx,(%edx)
 95c:	eb e9                	jmp    947 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 95e:	c7 05 08 0f 00 00 0c 	movl   $0xf0c,0xf08
 965:	0f 00 00 
 968:	c7 05 0c 0f 00 00 0c 	movl   $0xf0c,0xf0c
 96f:	0f 00 00 
    base.s.size = 0;
 972:	b8 0c 0f 00 00       	mov    $0xf0c,%eax
 977:	c7 05 10 0f 00 00 00 	movl   $0x0,0xf10
 97e:	00 00 00 
 981:	e9 41 ff ff ff       	jmp    8c7 <malloc+0x27>
