
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
  19:	83 f8 01             	cmp    $0x1,%eax
  }
}

int
main(int argc, char *argv[])
{
  1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
  1f:	7e 76                	jle    97 <main+0x97>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  24:	83 c3 08             	add    $0x8,%ebx
  
  if(argc <= 2){
  27:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  
  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  30:	89 45 e0             	mov    %eax,-0x20(%ebp)
  
  if(argc <= 2){
  33:	74 53                	je     88 <main+0x88>
  35:	8d 76 00             	lea    0x0(%esi),%esi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 ed 04 00 00       	call   531 <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	89 c7                	mov    %eax,%edi
  4b:	78 27                	js     74 <main+0x74>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4d:	83 ec 08             	sub    $0x8,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  50:	83 c6 01             	add    $0x1,%esi
  53:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  56:	50                   	push   %eax
  57:	ff 75 e0             	pushl  -0x20(%ebp)
  5a:	e8 a1 01 00 00       	call   200 <grep>
    close(fd);
  5f:	89 3c 24             	mov    %edi,(%esp)
  62:	e8 b2 04 00 00       	call   519 <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  67:	83 c4 10             	add    $0x10,%esp
  6a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  6d:	7f c9                	jg     38 <main+0x38>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  6f:	e8 7d 04 00 00       	call   4f1 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  74:	50                   	push   %eax
  75:	ff 33                	pushl  (%ebx)
  77:	68 78 09 00 00       	push   $0x978
  7c:	6a 01                	push   $0x1
  7e:	e8 ad 05 00 00       	call   630 <printf>
      exit();
  83:	e8 69 04 00 00       	call   4f1 <exit>
    exit();
  }
  pattern = argv[1];
  
  if(argc <= 2){
    grep(pattern, 0);
  88:	52                   	push   %edx
  89:	52                   	push   %edx
  8a:	6a 00                	push   $0x0
  8c:	50                   	push   %eax
  8d:	e8 6e 01 00 00       	call   200 <grep>
    exit();
  92:	e8 5a 04 00 00       	call   4f1 <exit>
{
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  97:	51                   	push   %ecx
  98:	51                   	push   %ecx
  99:	68 58 09 00 00       	push   $0x958
  9e:	6a 02                	push   $0x2
  a0:	e8 8b 05 00 00       	call   630 <printf>
    exit();
  a5:	e8 47 04 00 00       	call   4f1 <exit>
  aa:	66 90                	xchg   %ax,%ax
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	57                   	push   %edi
  b1:	56                   	push   %esi
  b2:	53                   	push   %ebx
  b3:	8b 74 24 10          	mov    0x10(%esp),%esi
  b7:	8b 7c 24 14          	mov    0x14(%esp),%edi
  bb:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  bf:	90                   	nop
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c0:	83 ec 08             	sub    $0x8,%esp
  c3:	53                   	push   %ebx
  c4:	57                   	push   %edi
  c5:	e8 36 00 00 00       	call   100 <matchhere>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	85 c0                	test   %eax,%eax
  cf:	75 1f                	jne    f0 <matchstar+0x40>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d1:	0f be 13             	movsbl (%ebx),%edx
  d4:	84 d2                	test   %dl,%dl
  d6:	74 0c                	je     e4 <matchstar+0x34>
  d8:	83 c3 01             	add    $0x1,%ebx
  db:	83 fe 2e             	cmp    $0x2e,%esi
  de:	74 e0                	je     c0 <matchstar+0x10>
  e0:	39 f2                	cmp    %esi,%edx
  e2:	74 dc                	je     c0 <matchstar+0x10>
  return 0;
}
  e4:	5b                   	pop    %ebx
  e5:	5e                   	pop    %esi
  e6:	5f                   	pop    %edi
  e7:	c3                   	ret    
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	5b                   	pop    %ebx
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  f1:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
  f6:	5e                   	pop    %esi
  f7:	5f                   	pop    %edi
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000100 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 100:	57                   	push   %edi
 101:	56                   	push   %esi
 102:	53                   	push   %ebx
 103:	8b 44 24 10          	mov    0x10(%esp),%eax
 107:	8b 7c 24 14          	mov    0x14(%esp),%edi
  if(re[0] == '\0')
 10b:	0f b6 18             	movzbl (%eax),%ebx
 10e:	84 db                	test   %bl,%bl
 110:	74 5f                	je     171 <matchhere+0x71>
    return 1;
  if(re[1] == '*')
 112:	0f be 50 01          	movsbl 0x1(%eax),%edx
 116:	80 fa 2a             	cmp    $0x2a,%dl
 119:	74 6b                	je     186 <matchhere+0x86>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 11b:	80 fb 24             	cmp    $0x24,%bl
 11e:	75 04                	jne    124 <matchhere+0x24>
 120:	84 d2                	test   %dl,%dl
 122:	74 7a                	je     19e <matchhere+0x9e>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 124:	0f b6 37             	movzbl (%edi),%esi
 127:	89 f1                	mov    %esi,%ecx
 129:	84 c9                	test   %cl,%cl
 12b:	74 53                	je     180 <matchhere+0x80>
 12d:	38 cb                	cmp    %cl,%bl
 12f:	74 05                	je     136 <matchhere+0x36>
 131:	80 fb 2e             	cmp    $0x2e,%bl
 134:	75 4a                	jne    180 <matchhere+0x80>
    return matchhere(re+1, text+1);
 136:	83 c7 01             	add    $0x1,%edi
 139:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 13c:	84 d2                	test   %dl,%dl
 13e:	74 31                	je     171 <matchhere+0x71>
    return 1;
  if(re[1] == '*')
 140:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
 144:	80 fb 2a             	cmp    $0x2a,%bl
 147:	74 40                	je     189 <matchhere+0x89>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 149:	80 fa 24             	cmp    $0x24,%dl
 14c:	75 04                	jne    152 <matchhere+0x52>
 14e:	84 db                	test   %bl,%bl
 150:	74 4c                	je     19e <matchhere+0x9e>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 152:	0f b6 37             	movzbl (%edi),%esi
 155:	89 f1                	mov    %esi,%ecx
 157:	84 c9                	test   %cl,%cl
 159:	74 25                	je     180 <matchhere+0x80>
 15b:	80 fa 2e             	cmp    $0x2e,%dl
 15e:	74 04                	je     164 <matchhere+0x64>
 160:	38 d1                	cmp    %dl,%cl
 162:	75 1c                	jne    180 <matchhere+0x80>
 164:	0f be d3             	movsbl %bl,%edx
    return matchhere(re+1, text+1);
 167:	83 c7 01             	add    $0x1,%edi
 16a:	83 c0 01             	add    $0x1,%eax
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 16d:	84 d2                	test   %dl,%dl
 16f:	75 cf                	jne    140 <matchhere+0x40>
    return 1;
 171:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 176:	5b                   	pop    %ebx
 177:	5e                   	pop    %esi
 178:	5f                   	pop    %edi
 179:	c3                   	ret    
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	5b                   	pop    %ebx
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
 181:	31 c0                	xor    %eax,%eax
}
 183:	5e                   	pop    %esi
 184:	5f                   	pop    %edi
 185:	c3                   	ret    
// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
 186:	0f be d3             	movsbl %bl,%edx
    return matchstar(re[0], re+2, text);
 189:	83 ec 04             	sub    $0x4,%esp
 18c:	83 c0 02             	add    $0x2,%eax
 18f:	57                   	push   %edi
 190:	50                   	push   %eax
 191:	52                   	push   %edx
 192:	e8 19 ff ff ff       	call   b0 <matchstar>
 197:	83 c4 10             	add    $0x10,%esp
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 19a:	5b                   	pop    %ebx
 19b:	5e                   	pop    %esi
 19c:	5f                   	pop    %edi
 19d:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 19e:	31 c0                	xor    %eax,%eax
 1a0:	80 3f 00             	cmpb   $0x0,(%edi)
 1a3:	0f 94 c0             	sete   %al
 1a6:	eb ce                	jmp    176 <matchhere+0x76>
 1a8:	90                   	nop
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1b0:	56                   	push   %esi
 1b1:	53                   	push   %ebx
 1b2:	83 ec 04             	sub    $0x4,%esp
 1b5:	8b 74 24 10          	mov    0x10(%esp),%esi
 1b9:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  if(re[0] == '^')
 1bd:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1c0:	75 0f                	jne    1d1 <match+0x21>
 1c2:	eb 29                	jmp    1ed <match+0x3d>
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
 1c8:	83 c3 01             	add    $0x1,%ebx
 1cb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1cf:	74 16                	je     1e7 <match+0x37>
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 1d1:	83 ec 08             	sub    $0x8,%esp
 1d4:	53                   	push   %ebx
 1d5:	56                   	push   %esi
 1d6:	e8 25 ff ff ff       	call   100 <matchhere>
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	85 c0                	test   %eax,%eax
 1e0:	74 e6                	je     1c8 <match+0x18>
      return 1;
 1e2:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 1e7:	83 c4 04             	add    $0x4,%esp
 1ea:	5b                   	pop    %ebx
 1eb:	5e                   	pop    %esi
 1ec:	c3                   	ret    

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1ed:	83 c6 01             	add    $0x1,%esi
 1f0:	89 74 24 10          	mov    %esi,0x10(%esp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 1f4:	83 c4 04             	add    $0x4,%esp
 1f7:	5b                   	pop    %ebx
 1f8:	5e                   	pop    %esi

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 1f9:	e9 02 ff ff ff       	jmp    100 <matchhere>
 1fe:	66 90                	xchg   %ax,%ax

00000200 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 200:	55                   	push   %ebp
 201:	57                   	push   %edi
  int n, m;
  char *p, *q;
  
  m = 0;
 202:	31 ff                	xor    %edi,%edi
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
 206:	83 ec 0c             	sub    $0xc,%esp
 209:	8b 74 24 20          	mov    0x20(%esp),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
 210:	b8 00 04 00 00       	mov    $0x400,%eax
 215:	83 ec 04             	sub    $0x4,%esp
 218:	29 f8                	sub    %edi,%eax
 21a:	50                   	push   %eax
 21b:	8d 87 80 0e 00 00    	lea    0xe80(%edi),%eax
 221:	50                   	push   %eax
 222:	ff 74 24 30          	pushl  0x30(%esp)
 226:	e8 de 02 00 00       	call   509 <read>
 22b:	83 c4 10             	add    $0x10,%esp
 22e:	85 c0                	test   %eax,%eax
 230:	0f 8e 91 00 00 00    	jle    2c7 <grep+0xc7>
    m += n;
 236:	01 c7                	add    %eax,%edi
    p = buf;
 238:	bb 80 0e 00 00       	mov    $0xe80,%ebx
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    while((q = strchr(p, '\n')) != 0){
 240:	83 ec 08             	sub    $0x8,%esp
 243:	6a 0a                	push   $0xa
 245:	53                   	push   %ebx
 246:	e8 45 01 00 00       	call   390 <strchr>
 24b:	83 c4 10             	add    $0x10,%esp
 24e:	85 c0                	test   %eax,%eax
 250:	89 c5                	mov    %eax,%ebp
 252:	74 3c                	je     290 <grep+0x90>
      *q = 0;
      if(match(pattern, p)){
 254:	83 ec 08             	sub    $0x8,%esp
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
      *q = 0;
 257:	c6 45 00 00          	movb   $0x0,0x0(%ebp)
      if(match(pattern, p)){
 25b:	53                   	push   %ebx
 25c:	56                   	push   %esi
 25d:	e8 4e ff ff ff       	call   1b0 <match>
 262:	83 c4 10             	add    $0x10,%esp
 265:	85 c0                	test   %eax,%eax
 267:	75 07                	jne    270 <grep+0x70>
 269:	8d 5d 01             	lea    0x1(%ebp),%ebx
 26c:	eb d2                	jmp    240 <grep+0x40>
 26e:	66 90                	xchg   %ax,%ax
        *q = '\n';
 270:	c6 45 00 0a          	movb   $0xa,0x0(%ebp)
        write(1, p, q+1 - p);
 274:	83 c5 01             	add    $0x1,%ebp
 277:	83 ec 04             	sub    $0x4,%esp
 27a:	89 e8                	mov    %ebp,%eax
 27c:	29 d8                	sub    %ebx,%eax
 27e:	50                   	push   %eax
 27f:	53                   	push   %ebx
 280:	89 eb                	mov    %ebp,%ebx
 282:	6a 01                	push   $0x1
 284:	e8 88 02 00 00       	call   511 <write>
 289:	83 c4 10             	add    $0x10,%esp
 28c:	eb b2                	jmp    240 <grep+0x40>
 28e:	66 90                	xchg   %ax,%ax
      }
      p = q+1;
    }
    if(p == buf)
 290:	81 fb 80 0e 00 00    	cmp    $0xe80,%ebx
 296:	74 28                	je     2c0 <grep+0xc0>
      m = 0;
    if(m > 0){
 298:	85 ff                	test   %edi,%edi
 29a:	0f 8e 70 ff ff ff    	jle    210 <grep+0x10>
      m -= p - buf;
 2a0:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2a2:	83 ec 04             	sub    $0x4,%esp
      p = q+1;
    }
    if(p == buf)
      m = 0;
    if(m > 0){
      m -= p - buf;
 2a5:	2d 80 0e 00 00       	sub    $0xe80,%eax
 2aa:	29 c7                	sub    %eax,%edi
      memmove(buf, p, m);
 2ac:	57                   	push   %edi
 2ad:	53                   	push   %ebx
 2ae:	68 80 0e 00 00       	push   $0xe80
 2b3:	e8 08 02 00 00       	call   4c0 <memmove>
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	e9 50 ff ff ff       	jmp    210 <grep+0x10>
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 2c0:	31 ff                	xor    %edi,%edi
 2c2:	e9 49 ff ff ff       	jmp    210 <grep+0x10>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 2c7:	83 c4 0c             	add    $0xc,%esp
 2ca:	5b                   	pop    %ebx
 2cb:	5e                   	pop    %esi
 2cc:	5f                   	pop    %edi
 2cd:	5d                   	pop    %ebp
 2ce:	c3                   	ret    
 2cf:	90                   	nop

000002d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2d0:	53                   	push   %ebx
 2d1:	8b 44 24 08          	mov    0x8(%esp),%eax
 2d5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d9:	89 c2                	mov    %eax,%edx
 2db:	90                   	nop
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2e0:	83 c1 01             	add    $0x1,%ecx
 2e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2e7:	83 c2 01             	add    $0x1,%edx
 2ea:	84 db                	test   %bl,%bl
 2ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 2ef:	75 ef                	jne    2e0 <strcpy+0x10>
    ;
  return os;
}
 2f1:	5b                   	pop    %ebx
 2f2:	c3                   	ret    
 2f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 300:	56                   	push   %esi
 301:	53                   	push   %ebx
 302:	8b 54 24 0c          	mov    0xc(%esp),%edx
 306:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
 30a:	0f b6 02             	movzbl (%edx),%eax
 30d:	0f b6 19             	movzbl (%ecx),%ebx
 310:	84 c0                	test   %al,%al
 312:	75 1f                	jne    333 <strcmp+0x33>
 314:	eb 2a                	jmp    340 <strcmp+0x40>
 316:	8d 76 00             	lea    0x0(%esi),%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 320:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 323:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 326:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 329:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 32d:	84 c0                	test   %al,%al
 32f:	74 0f                	je     340 <strcmp+0x40>
 331:	89 f1                	mov    %esi,%ecx
 333:	38 d8                	cmp    %bl,%al
 335:	74 e9                	je     320 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 337:	29 d8                	sub    %ebx,%eax
}
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	c3                   	ret    
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 340:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 342:	29 d8                	sub    %ebx,%eax
}
 344:	5b                   	pop    %ebx
 345:	5e                   	pop    %esi
 346:	c3                   	ret    
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <strlen>:

uint
strlen(char *s)
{
 350:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 354:	80 39 00             	cmpb   $0x0,(%ecx)
 357:	74 14                	je     36d <strlen+0x1d>
 359:	31 d2                	xor    %edx,%edx
 35b:	90                   	nop
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 360:	83 c2 01             	add    $0x1,%edx
 363:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 367:	89 d0                	mov    %edx,%eax
 369:	75 f5                	jne    360 <strlen+0x10>
 36b:	f3 c3                	repz ret 
 36d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 36f:	c3                   	ret    

00000370 <memset>:

void*
memset(void *dst, int c, uint n)
{
 370:	57                   	push   %edi
 371:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 375:	8b 4c 24 10          	mov    0x10(%esp),%ecx
 379:	8b 44 24 0c          	mov    0xc(%esp),%eax
 37d:	89 d7                	mov    %edx,%edi
 37f:	fc                   	cld    
 380:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 382:	89 d0                	mov    %edx,%eax
 384:	5f                   	pop    %edi
 385:	c3                   	ret    
 386:	8d 76 00             	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <strchr>:

char*
strchr(const char *s, char c)
{
 390:	53                   	push   %ebx
 391:	8b 44 24 08          	mov    0x8(%esp),%eax
 395:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
 399:	0f b6 10             	movzbl (%eax),%edx
 39c:	84 d2                	test   %dl,%dl
 39e:	74 1e                	je     3be <strchr+0x2e>
    if(*s == c)
 3a0:	38 d3                	cmp    %dl,%bl
 3a2:	89 d9                	mov    %ebx,%ecx
 3a4:	75 0e                	jne    3b4 <strchr+0x24>
 3a6:	eb 18                	jmp    3c0 <strchr+0x30>
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b0:	38 ca                	cmp    %cl,%dl
 3b2:	74 0c                	je     3c0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3b4:	83 c0 01             	add    $0x1,%eax
 3b7:	0f b6 10             	movzbl (%eax),%edx
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
 3be:	31 c0                	xor    %eax,%eax
}
 3c0:	5b                   	pop    %ebx
 3c1:	c3                   	ret    
 3c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <gets>:

char*
gets(char *buf, int max)
{
 3d0:	55                   	push   %ebp
 3d1:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d2:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 1c             	sub    $0x1c,%esp
 3d9:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 3dd:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e1:	eb 2c                	jmp    40f <gets+0x3f>
 3e3:	90                   	nop
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	6a 01                	push   $0x1
 3ed:	55                   	push   %ebp
 3ee:	6a 00                	push   $0x0
 3f0:	e8 14 01 00 00       	call   509 <read>
    if(cc < 1)
 3f5:	83 c4 10             	add    $0x10,%esp
 3f8:	85 c0                	test   %eax,%eax
 3fa:	7e 1c                	jle    418 <gets+0x48>
      break;
    buf[i++] = c;
 3fc:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
 401:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
 403:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 405:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 409:	74 25                	je     430 <gets+0x60>
 40b:	3c 0d                	cmp    $0xd,%al
 40d:	74 21                	je     430 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 40f:	8d 5f 01             	lea    0x1(%edi),%ebx
 412:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
 416:	7c d0                	jl     3e8 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 418:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 41c:	83 c4 1c             	add    $0x1c,%esp
 41f:	89 f0                	mov    %esi,%eax
 421:	5b                   	pop    %ebx
 422:	5e                   	pop    %esi
 423:	5f                   	pop    %edi
 424:	5d                   	pop    %ebp
 425:	c3                   	ret    
 426:	8d 76 00             	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 430:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
 432:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 434:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
 438:	83 c4 1c             	add    $0x1c,%esp
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5f                   	pop    %edi
 43e:	5d                   	pop    %ebp
 43f:	c3                   	ret    

00000440 <stat>:

int
stat(char *n, struct statv6 *st)
{
 440:	56                   	push   %esi
 441:	53                   	push   %ebx
 442:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 445:	6a 00                	push   $0x0
 447:	ff 74 24 1c          	pushl  0x1c(%esp)
 44b:	e8 e1 00 00 00       	call   531 <open>
  if(fd < 0)
 450:	83 c4 10             	add    $0x10,%esp
 453:	85 c0                	test   %eax,%eax
 455:	78 29                	js     480 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 457:	83 ec 08             	sub    $0x8,%esp
 45a:	89 c3                	mov    %eax,%ebx
 45c:	ff 74 24 1c          	pushl  0x1c(%esp)
 460:	50                   	push   %eax
 461:	e8 e3 00 00 00       	call   549 <fstat>
 466:	89 c6                	mov    %eax,%esi
  close(fd);
 468:	89 1c 24             	mov    %ebx,(%esp)
 46b:	e8 a9 00 00 00       	call   519 <close>
  return r;
 470:	83 c4 10             	add    $0x10,%esp
 473:	89 f0                	mov    %esi,%eax
}
 475:	83 c4 04             	add    $0x4,%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	c3                   	ret    
 47b:	90                   	nop
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 485:	eb ee                	jmp    475 <stat+0x35>
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 490:	53                   	push   %ebx
 491:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 495:	0f be 11             	movsbl (%ecx),%edx
 498:	8d 42 d0             	lea    -0x30(%edx),%eax
 49b:	3c 09                	cmp    $0x9,%al
 49d:	b8 00 00 00 00       	mov    $0x0,%eax
 4a2:	77 19                	ja     4bd <atoi+0x2d>
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 4a8:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4ab:	83 c1 01             	add    $0x1,%ecx
 4ae:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b2:	0f be 11             	movsbl (%ecx),%edx
 4b5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4b8:	80 fb 09             	cmp    $0x9,%bl
 4bb:	76 eb                	jbe    4a8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 4bd:	5b                   	pop    %ebx
 4be:	c3                   	ret    
 4bf:	90                   	nop

000004c0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4c0:	56                   	push   %esi
 4c1:	53                   	push   %ebx
 4c2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
 4c6:	8b 44 24 0c          	mov    0xc(%esp),%eax
 4ca:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	7e 14                	jle    4e6 <memmove+0x26>
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4df:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4e2:	39 da                	cmp    %ebx,%edx
 4e4:	75 f2                	jne    4d8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4e6:	5b                   	pop    %ebx
 4e7:	5e                   	pop    %esi
 4e8:	c3                   	ret    

000004e9 <fork>:
 4e9:	b8 01 00 00 00       	mov    $0x1,%eax
 4ee:	cd 40                	int    $0x40
 4f0:	c3                   	ret    

000004f1 <exit>:
 4f1:	b8 02 00 00 00       	mov    $0x2,%eax
 4f6:	cd 40                	int    $0x40
 4f8:	c3                   	ret    

000004f9 <wait>:
 4f9:	b8 03 00 00 00       	mov    $0x3,%eax
 4fe:	cd 40                	int    $0x40
 500:	c3                   	ret    

00000501 <pipe>:
 501:	b8 04 00 00 00       	mov    $0x4,%eax
 506:	cd 40                	int    $0x40
 508:	c3                   	ret    

00000509 <read>:
 509:	b8 06 00 00 00       	mov    $0x6,%eax
 50e:	cd 40                	int    $0x40
 510:	c3                   	ret    

00000511 <write>:
 511:	b8 05 00 00 00       	mov    $0x5,%eax
 516:	cd 40                	int    $0x40
 518:	c3                   	ret    

00000519 <close>:
 519:	b8 07 00 00 00       	mov    $0x7,%eax
 51e:	cd 40                	int    $0x40
 520:	c3                   	ret    

00000521 <kill>:
 521:	b8 08 00 00 00       	mov    $0x8,%eax
 526:	cd 40                	int    $0x40
 528:	c3                   	ret    

00000529 <exec>:
 529:	b8 09 00 00 00       	mov    $0x9,%eax
 52e:	cd 40                	int    $0x40
 530:	c3                   	ret    

00000531 <open>:
 531:	b8 0a 00 00 00       	mov    $0xa,%eax
 536:	cd 40                	int    $0x40
 538:	c3                   	ret    

00000539 <mknod>:
 539:	b8 0b 00 00 00       	mov    $0xb,%eax
 53e:	cd 40                	int    $0x40
 540:	c3                   	ret    

00000541 <unlink>:
 541:	b8 0c 00 00 00       	mov    $0xc,%eax
 546:	cd 40                	int    $0x40
 548:	c3                   	ret    

00000549 <fstat>:
 549:	b8 0d 00 00 00       	mov    $0xd,%eax
 54e:	cd 40                	int    $0x40
 550:	c3                   	ret    

00000551 <link>:
 551:	b8 0e 00 00 00       	mov    $0xe,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <mkdir>:
 559:	b8 0f 00 00 00       	mov    $0xf,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <chdir>:
 561:	b8 10 00 00 00       	mov    $0x10,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <dup>:
 569:	b8 11 00 00 00       	mov    $0x11,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <getpid>:
 571:	b8 12 00 00 00       	mov    $0x12,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    

00000579 <sbrk>:
 579:	b8 13 00 00 00       	mov    $0x13,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <sleep>:
 581:	b8 14 00 00 00       	mov    $0x14,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    
 589:	66 90                	xchg   %ax,%ax
 58b:	66 90                	xchg   %ax,%ax
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 590:	55                   	push   %ebp
 591:	57                   	push   %edi
 592:	89 c7                	mov    %eax,%edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 599:	8b 5c 24 50          	mov    0x50(%esp),%ebx
 59d:	85 db                	test   %ebx,%ebx
 59f:	74 77                	je     618 <printint+0x88>
 5a1:	89 d0                	mov    %edx,%eax
 5a3:	c1 e8 1f             	shr    $0x1f,%eax
 5a6:	84 c0                	test   %al,%al
 5a8:	74 6e                	je     618 <printint+0x88>
    neg = 1;
    x = -xx;
 5aa:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5ac:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5b3:	00 
    x = -xx;
 5b4:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 5b6:	31 ed                	xor    %ebp,%ebp
 5b8:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
 5bc:	eb 04                	jmp    5c2 <printint+0x32>
 5be:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
 5c0:	89 f5                	mov    %esi,%ebp
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	8d 75 01             	lea    0x1(%ebp),%esi
 5c7:	f7 f1                	div    %ecx
 5c9:	0f b6 92 98 09 00 00 	movzbl 0x998(%edx),%edx
  }while((x /= base) != 0);
 5d0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5d2:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
 5d5:	75 e9                	jne    5c0 <printint+0x30>
  if(neg)
 5d7:	8b 44 24 0c          	mov    0xc(%esp),%eax
 5db:	85 c0                	test   %eax,%eax
 5dd:	74 08                	je     5e7 <printint+0x57>
    buf[i++] = '-';
 5df:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
 5e4:	8d 75 02             	lea    0x2(%ebp),%esi
 5e7:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
 5eb:	90                   	nop
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f0:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f3:	83 ec 04             	sub    $0x4,%esp
 5f6:	83 ee 01             	sub    $0x1,%esi
 5f9:	88 44 24 23          	mov    %al,0x23(%esp)
 5fd:	6a 01                	push   $0x1
 5ff:	53                   	push   %ebx
 600:	57                   	push   %edi
 601:	e8 0b ff ff ff       	call   511 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 606:	83 c4 10             	add    $0x10,%esp
 609:	39 de                	cmp    %ebx,%esi
 60b:	75 e3                	jne    5f0 <printint+0x60>
    putc(fd, buf[i]);
}
 60d:	83 c4 3c             	add    $0x3c,%esp
 610:	5b                   	pop    %ebx
 611:	5e                   	pop    %esi
 612:	5f                   	pop    %edi
 613:	5d                   	pop    %ebp
 614:	c3                   	ret    
 615:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 618:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 61a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 621:	00 
 622:	eb 92                	jmp    5b6 <printint+0x26>
 624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 62a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000630 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	57                   	push   %edi
 632:	56                   	push   %esi
 633:	53                   	push   %ebx
 634:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 637:	8b 74 24 44          	mov    0x44(%esp),%esi
 63b:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 63f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 643:	89 44 24 0c          	mov    %eax,0xc(%esp)
 647:	0f b6 1e             	movzbl (%esi),%ebx
 64a:	83 c6 01             	add    $0x1,%esi
 64d:	84 db                	test   %bl,%bl
 64f:	0f 84 ad 00 00 00    	je     702 <printf+0xd2>
 655:	31 ed                	xor    %ebp,%ebp
 657:	eb 32                	jmp    68b <printf+0x5b>
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 660:	83 f8 25             	cmp    $0x25,%eax
 663:	0f 84 a7 00 00 00    	je     710 <printf+0xe0>
 669:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66d:	83 ec 04             	sub    $0x4,%esp
 670:	6a 01                	push   $0x1
 672:	8d 44 24 22          	lea    0x22(%esp),%eax
 676:	50                   	push   %eax
 677:	57                   	push   %edi
 678:	e8 94 fe ff ff       	call   511 <write>
 67d:	83 c4 10             	add    $0x10,%esp
 680:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 683:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 687:	84 db                	test   %bl,%bl
 689:	74 77                	je     702 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
 68b:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 68d:	0f be cb             	movsbl %bl,%ecx
 690:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 693:	74 cb                	je     660 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 695:	83 fd 25             	cmp    $0x25,%ebp
 698:	75 e6                	jne    680 <printf+0x50>
      if(c == 'd'){
 69a:	83 f8 64             	cmp    $0x64,%eax
 69d:	0f 84 15 01 00 00    	je     7b8 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6a3:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6a9:	83 f9 70             	cmp    $0x70,%ecx
 6ac:	74 72                	je     720 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6ae:	83 f8 73             	cmp    $0x73,%eax
 6b1:	0f 84 99 00 00 00    	je     750 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6b7:	83 f8 63             	cmp    $0x63,%eax
 6ba:	0f 84 07 01 00 00    	je     7c7 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6c0:	83 f8 25             	cmp    $0x25,%eax
 6c3:	0f 84 d7 00 00 00    	je     7a0 <printf+0x170>
 6c9:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ce:	83 ec 04             	sub    $0x4,%esp
 6d1:	6a 01                	push   $0x1
 6d3:	8d 44 24 27          	lea    0x27(%esp),%eax
 6d7:	50                   	push   %eax
 6d8:	57                   	push   %edi
 6d9:	e8 33 fe ff ff       	call   511 <write>
 6de:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
 6e2:	83 c4 0c             	add    $0xc,%esp
 6e5:	6a 01                	push   $0x1
 6e7:	8d 44 24 26          	lea    0x26(%esp),%eax
 6eb:	50                   	push   %eax
 6ec:	57                   	push   %edi
 6ed:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6f0:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6f2:	e8 1a fe ff ff       	call   511 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fb:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6fe:	84 db                	test   %bl,%bl
 700:	75 89                	jne    68b <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 702:	83 c4 2c             	add    $0x2c,%esp
 705:	5b                   	pop    %ebx
 706:	5e                   	pop    %esi
 707:	5f                   	pop    %edi
 708:	5d                   	pop    %ebp
 709:	c3                   	ret    
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 710:	bd 25 00 00 00       	mov    $0x25,%ebp
 715:	e9 66 ff ff ff       	jmp    680 <printf+0x50>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 720:	83 ec 0c             	sub    $0xc,%esp
 723:	b9 10 00 00 00       	mov    $0x10,%ecx
 728:	6a 00                	push   $0x0
 72a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
 72e:	89 f8                	mov    %edi,%eax
 730:	8b 13                	mov    (%ebx),%edx
 732:	e8 59 fe ff ff       	call   590 <printint>
        ap++;
 737:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 739:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 73b:	83 c0 04             	add    $0x4,%eax
 73e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 742:	83 c4 10             	add    $0x10,%esp
 745:	e9 36 ff ff ff       	jmp    680 <printf+0x50>
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 750:	8b 44 24 0c          	mov    0xc(%esp),%eax
 754:	8b 28                	mov    (%eax),%ebp
        ap++;
 756:	83 c0 04             	add    $0x4,%eax
 759:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
 75d:	b8 8e 09 00 00       	mov    $0x98e,%eax
 762:	85 ed                	test   %ebp,%ebp
 764:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
 767:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 76b:	84 c0                	test   %al,%al
 76d:	74 27                	je     796 <printf+0x166>
 76f:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 773:	90                   	nop
 774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 778:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 77c:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 77f:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 782:	6a 01                	push   $0x1
 784:	53                   	push   %ebx
 785:	57                   	push   %edi
 786:	e8 86 fd ff ff       	call   511 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 78b:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
 78f:	83 c4 10             	add    $0x10,%esp
 792:	84 c0                	test   %al,%al
 794:	75 e2                	jne    778 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 796:	31 ed                	xor    %ebp,%ebp
 798:	e9 e3 fe ff ff       	jmp    680 <printf+0x50>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
 7a0:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7a4:	83 ec 04             	sub    $0x4,%esp
 7a7:	6a 01                	push   $0x1
 7a9:	8d 44 24 25          	lea    0x25(%esp),%eax
 7ad:	e9 39 ff ff ff       	jmp    6eb <printf+0xbb>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7b8:	83 ec 0c             	sub    $0xc,%esp
 7bb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7c0:	6a 01                	push   $0x1
 7c2:	e9 63 ff ff ff       	jmp    72a <printf+0xfa>
 7c7:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7cb:	83 ec 04             	sub    $0x4,%esp
 7ce:	8b 03                	mov    (%ebx),%eax
 7d0:	88 44 24 20          	mov    %al,0x20(%esp)
 7d4:	6a 01                	push   $0x1
 7d6:	8d 44 24 24          	lea    0x24(%esp),%eax
 7da:	50                   	push   %eax
 7db:	57                   	push   %edi
 7dc:	e8 30 fd ff ff       	call   511 <write>
 7e1:	e9 51 ff ff ff       	jmp    737 <printf+0x107>
 7e6:	66 90                	xchg   %ax,%ax
 7e8:	66 90                	xchg   %ax,%ax
 7ea:	66 90                	xchg   %ax,%ax
 7ec:	66 90                	xchg   %ax,%ax
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	57                   	push   %edi
 7f1:	56                   	push   %esi
 7f2:	53                   	push   %ebx
 7f3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f7:	a1 60 0e 00 00       	mov    0xe60,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
 7fc:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ff:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 801:	39 c8                	cmp    %ecx,%eax
 803:	73 13                	jae    818 <free+0x28>
 805:	8d 76 00             	lea    0x0(%esi),%esi
 808:	39 d1                	cmp    %edx,%ecx
 80a:	72 14                	jb     820 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	39 d0                	cmp    %edx,%eax
 80e:	73 10                	jae    820 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
 810:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 812:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 816:	72 f0                	jb     808 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	39 d0                	cmp    %edx,%eax
 81a:	72 f4                	jb     810 <free+0x20>
 81c:	39 d1                	cmp    %edx,%ecx
 81e:	73 f0                	jae    810 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 820:	8b 73 fc             	mov    -0x4(%ebx),%esi
 823:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 826:	39 d7                	cmp    %edx,%edi
 828:	74 18                	je     842 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 82a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 82d:	8b 50 04             	mov    0x4(%eax),%edx
 830:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 833:	39 f1                	cmp    %esi,%ecx
 835:	74 20                	je     857 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 837:	89 08                	mov    %ecx,(%eax)
  freep = p;
 839:	a3 60 0e 00 00       	mov    %eax,0xe60
}
 83e:	5b                   	pop    %ebx
 83f:	5e                   	pop    %esi
 840:	5f                   	pop    %edi
 841:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 842:	03 72 04             	add    0x4(%edx),%esi
 845:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 848:	8b 12                	mov    (%edx),%edx
 84a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 84d:	8b 50 04             	mov    0x4(%eax),%edx
 850:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 853:	39 f1                	cmp    %esi,%ecx
 855:	75 e0                	jne    837 <free+0x47>
    p->s.size += bp->s.size;
 857:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 85a:	a3 60 0e 00 00       	mov    %eax,0xe60
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 85f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 862:	8b 53 f8             	mov    -0x8(%ebx),%edx
 865:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 867:	5b                   	pop    %ebx
 868:	5e                   	pop    %esi
 869:	5f                   	pop    %edi
 86a:	c3                   	ret    
 86b:	90                   	nop
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	57                   	push   %edi
 871:	56                   	push   %esi
 872:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 873:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
 877:	8b 15 60 0e 00 00    	mov    0xe60,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 87d:	8d 78 07             	lea    0x7(%eax),%edi
 880:	c1 ef 03             	shr    $0x3,%edi
 883:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 886:	85 d2                	test   %edx,%edx
 888:	0f 84 a0 00 00 00    	je     92e <malloc+0xbe>
 88e:	8b 02                	mov    (%edx),%eax
 890:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 893:	39 cf                	cmp    %ecx,%edi
 895:	76 71                	jbe    908 <malloc+0x98>
 897:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 89d:	be 00 10 00 00       	mov    $0x1000,%esi
 8a2:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8a9:	0f 43 f7             	cmovae %edi,%esi
 8ac:	ba 00 80 00 00       	mov    $0x8000,%edx
 8b1:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8b7:	0f 46 da             	cmovbe %edx,%ebx
 8ba:	eb 0d                	jmp    8c9 <malloc+0x59>
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8c2:	8b 48 04             	mov    0x4(%eax),%ecx
 8c5:	39 cf                	cmp    %ecx,%edi
 8c7:	76 3f                	jbe    908 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
 8c9:	39 05 60 0e 00 00    	cmp    %eax,0xe60
 8cf:	89 c2                	mov    %eax,%edx
 8d1:	75 ed                	jne    8c0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 8d3:	83 ec 0c             	sub    $0xc,%esp
 8d6:	53                   	push   %ebx
 8d7:	e8 9d fc ff ff       	call   579 <sbrk>
  if(p == (char*) -1)
 8dc:	83 c4 10             	add    $0x10,%esp
 8df:	83 f8 ff             	cmp    $0xffffffff,%eax
 8e2:	74 1c                	je     900 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8e4:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8e7:	83 ec 0c             	sub    $0xc,%esp
 8ea:	83 c0 08             	add    $0x8,%eax
 8ed:	50                   	push   %eax
 8ee:	e8 fd fe ff ff       	call   7f0 <free>
  return freep;
 8f3:	8b 15 60 0e 00 00    	mov    0xe60,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8f9:	83 c4 10             	add    $0x10,%esp
 8fc:	85 d2                	test   %edx,%edx
 8fe:	75 c0                	jne    8c0 <malloc+0x50>
        return 0;
 900:	31 c0                	xor    %eax,%eax
 902:	eb 1c                	jmp    920 <malloc+0xb0>
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 908:	39 cf                	cmp    %ecx,%edi
 90a:	74 1c                	je     928 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 90c:	29 f9                	sub    %edi,%ecx
 90e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 911:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 914:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 917:	89 15 60 0e 00 00    	mov    %edx,0xe60
      return (void*) (p + 1);
 91d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 920:	5b                   	pop    %ebx
 921:	5e                   	pop    %esi
 922:	5f                   	pop    %edi
 923:	c3                   	ret    
 924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 928:	8b 08                	mov    (%eax),%ecx
 92a:	89 0a                	mov    %ecx,(%edx)
 92c:	eb e9                	jmp    917 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 92e:	c7 05 60 0e 00 00 64 	movl   $0xe64,0xe60
 935:	0e 00 00 
 938:	c7 05 64 0e 00 00 64 	movl   $0xe64,0xe64
 93f:	0e 00 00 
    base.s.size = 0;
 942:	b8 64 0e 00 00       	mov    $0xe64,%eax
 947:	c7 05 68 0e 00 00 00 	movl   $0x0,0xe68
 94e:	00 00 00 
 951:	e9 41 ff ff ff       	jmp    897 <malloc+0x27>
