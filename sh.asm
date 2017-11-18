
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

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
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f c3 00 00 00    	jg     e4 <main+0xe4>
{
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 d9 11 00 00       	push   $0x11d9
      2b:	e8 e1 0c 00 00       	call   d11 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 22 1c 00 00 20 	cmpb   $0x20,0x1c22
      47:	74 5d                	je     a6 <main+0xa6>
      49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;
  
  pid = fork();
      50:	e8 74 0c 00 00       	call   cc9 <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	74 3f                	je     99 <main+0x99>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      5a:	85 c0                	test   %eax,%eax
      5c:	0f 84 98 00 00 00    	je     fa <main+0xfa>
      runcmd(parsecmd(buf));
    wait();
      62:	e8 72 0c 00 00       	call   cd9 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	6a 64                	push   $0x64
      6c:	68 20 1c 00 00       	push   $0x1c20
      71:	e8 9a 00 00 00       	call   110 <getcmd>
      76:	83 c4 10             	add    $0x10,%esp
      79:	85 c0                	test   %eax,%eax
      7b:	78 78                	js     f5 <main+0xf5>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      7d:	80 3d 20 1c 00 00 63 	cmpb   $0x63,0x1c20
      84:	75 ca                	jne    50 <main+0x50>
      86:	80 3d 21 1c 00 00 64 	cmpb   $0x64,0x1c21
      8d:	74 b1                	je     40 <main+0x40>
int
fork1(void)
{
  int pid;
  
  pid = fork();
      8f:	e8 35 0c 00 00       	call   cc9 <fork>
  if(pid == -1)
      94:	83 f8 ff             	cmp    $0xffffffff,%eax
      97:	75 c1                	jne    5a <main+0x5a>
    panic("fork");
      99:	83 ec 0c             	sub    $0xc,%esp
      9c:	68 62 11 00 00       	push   $0x1162
      a1:	e8 aa 00 00 00       	call   150 <panic>
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	68 20 1c 00 00       	push   $0x1c20
      ae:	e8 7d 0a 00 00       	call   b30 <strlen>
      if(chdir(buf+3) < 0)
      b3:	c7 04 24 23 1c 00 00 	movl   $0x1c23,(%esp)
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      ba:	c6 80 1f 1c 00 00 00 	movb   $0x0,0x1c1f(%eax)
      if(chdir(buf+3) < 0)
      c1:	e8 7b 0c 00 00       	call   d41 <chdir>
      c6:	83 c4 10             	add    $0x10,%esp
      c9:	85 c0                	test   %eax,%eax
      cb:	79 9a                	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
      cd:	50                   	push   %eax
      ce:	68 23 1c 00 00       	push   $0x1c23
      d3:	68 e1 11 00 00       	push   $0x11e1
      d8:	6a 02                	push   $0x2
      da:	e8 31 0d 00 00       	call   e10 <printf>
      df:	83 c4 10             	add    $0x10,%esp
      e2:	eb 83                	jmp    67 <main+0x67>
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      e4:	83 ec 0c             	sub    $0xc,%esp
      e7:	50                   	push   %eax
      e8:	e8 0c 0c 00 00       	call   cf9 <close>
      break;
      ed:	83 c4 10             	add    $0x10,%esp
      f0:	e9 72 ff ff ff       	jmp    67 <main+0x67>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
      f5:	e8 d7 0b 00 00       	call   cd1 <exit>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
      fa:	83 ec 0c             	sub    $0xc,%esp
      fd:	68 20 1c 00 00       	push   $0x1c20
     102:	e8 39 09 00 00       	call   a40 <parsecmd>
     107:	89 04 24             	mov    %eax,(%esp)
     10a:	e8 61 00 00 00       	call   170 <runcmd>
     10f:	90                   	nop

00000110 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
     110:	56                   	push   %esi
     111:	53                   	push   %ebx
     112:	83 ec 0c             	sub    $0xc,%esp
     115:	8b 5c 24 18          	mov    0x18(%esp),%ebx
     119:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  printf(2, "$ ");
     11d:	68 38 11 00 00       	push   $0x1138
     122:	6a 02                	push   $0x2
     124:	e8 e7 0c 00 00       	call   e10 <printf>
  memset(buf, 0, nbuf);
     129:	83 c4 0c             	add    $0xc,%esp
     12c:	56                   	push   %esi
     12d:	6a 00                	push   $0x0
     12f:	53                   	push   %ebx
     130:	e8 1b 0a 00 00       	call   b50 <memset>
  gets(buf, nbuf);
     135:	58                   	pop    %eax
     136:	5a                   	pop    %edx
     137:	56                   	push   %esi
     138:	53                   	push   %ebx
     139:	e8 72 0a 00 00       	call   bb0 <gets>
     13e:	31 c0                	xor    %eax,%eax
     140:	80 3b 00             	cmpb   $0x0,(%ebx)
     143:	0f 94 c0             	sete   %al
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     146:	83 c4 14             	add    $0x14,%esp
     149:	f7 d8                	neg    %eax
     14b:	5b                   	pop    %ebx
     14c:	5e                   	pop    %esi
     14d:	c3                   	ret    
     14e:	66 90                	xchg   %ax,%ax

00000150 <panic>:
  exit();
}

void
panic(char *s)
{
     150:	83 ec 10             	sub    $0x10,%esp
  printf(2, "%s\n", s);
     153:	ff 74 24 14          	pushl  0x14(%esp)
     157:	68 d5 11 00 00       	push   $0x11d5
     15c:	6a 02                	push   $0x2
     15e:	e8 ad 0c 00 00       	call   e10 <printf>
  exit();
     163:	e8 69 0b 00 00       	call   cd1 <exit>
     168:	90                   	nop
     169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000170 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     170:	53                   	push   %ebx
     171:	83 ec 18             	sub    $0x18,%esp
     174:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     178:	85 db                	test   %ebx,%ebx
     17a:	74 79                	je     1f5 <runcmd+0x85>
    exit();
  
  switch(cmd->type){
     17c:	83 3b 05             	cmpl   $0x5,(%ebx)
     17f:	0f 87 fb 00 00 00    	ja     280 <runcmd+0x110>
     185:	8b 03                	mov    (%ebx),%eax
     187:	ff 24 85 f0 11 00 00 	jmp    *0x11f0(,%eax,4)
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     18e:	83 ec 0c             	sub    $0xc,%esp
     191:	8d 44 24 14          	lea    0x14(%esp),%eax
     195:	50                   	push   %eax
     196:	e8 46 0b 00 00       	call   ce1 <pipe>
     19b:	83 c4 10             	add    $0x10,%esp
     19e:	85 c0                	test   %eax,%eax
     1a0:	0f 88 09 01 00 00    	js     2af <runcmd+0x13f>
int
fork1(void)
{
  int pid;
  
  pid = fork();
     1a6:	e8 1e 0b 00 00       	call   cc9 <fork>
  if(pid == -1)
     1ab:	83 f8 ff             	cmp    $0xffffffff,%eax
     1ae:	0f 84 d9 00 00 00    	je     28d <runcmd+0x11d>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
     1b4:	85 c0                	test   %eax,%eax
     1b6:	0f 84 00 01 00 00    	je     2bc <runcmd+0x14c>
int
fork1(void)
{
  int pid;
  
  pid = fork();
     1bc:	e8 08 0b 00 00       	call   cc9 <fork>
  if(pid == -1)
     1c1:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c4:	0f 84 c3 00 00 00    	je     28d <runcmd+0x11d>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     1ca:	85 c0                	test   %eax,%eax
     1cc:	0f 84 1b 01 00 00    	je     2ed <runcmd+0x17d>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     1d2:	83 ec 0c             	sub    $0xc,%esp
     1d5:	ff 74 24 14          	pushl  0x14(%esp)
     1d9:	e8 1b 0b 00 00       	call   cf9 <close>
    close(p[1]);
     1de:	58                   	pop    %eax
     1df:	ff 74 24 18          	pushl  0x18(%esp)
     1e3:	e8 11 0b 00 00       	call   cf9 <close>
    wait();
     1e8:	e8 ec 0a 00 00       	call   cd9 <wait>
    wait();
     1ed:	e8 e7 0a 00 00       	call   cd9 <wait>
    break;
     1f2:	83 c4 10             	add    $0x10,%esp
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
     1f5:	e8 d7 0a 00 00       	call   cd1 <exit>
int
fork1(void)
{
  int pid;
  
  pid = fork();
     1fa:	e8 ca 0a 00 00       	call   cc9 <fork>
  if(pid == -1)
     1ff:	83 f8 ff             	cmp    $0xffffffff,%eax
     202:	0f 84 85 00 00 00    	je     28d <runcmd+0x11d>
    wait();
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     208:	85 c0                	test   %eax,%eax
     20a:	75 e9                	jne    1f5 <runcmd+0x85>
     20c:	eb 49                	jmp    257 <runcmd+0xe7>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     20e:	8b 43 04             	mov    0x4(%ebx),%eax
     211:	85 c0                	test   %eax,%eax
     213:	74 e0                	je     1f5 <runcmd+0x85>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     215:	52                   	push   %edx
     216:	52                   	push   %edx
     217:	8d 53 04             	lea    0x4(%ebx),%edx
     21a:	52                   	push   %edx
     21b:	50                   	push   %eax
     21c:	e8 e8 0a 00 00       	call   d09 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     221:	83 c4 0c             	add    $0xc,%esp
     224:	ff 73 04             	pushl  0x4(%ebx)
     227:	68 42 11 00 00       	push   $0x1142
     22c:	6a 02                	push   $0x2
     22e:	e8 dd 0b 00 00       	call   e10 <printf>
    break;
     233:	83 c4 10             	add    $0x10,%esp
     236:	eb bd                	jmp    1f5 <runcmd+0x85>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     238:	83 ec 0c             	sub    $0xc,%esp
     23b:	ff 73 14             	pushl  0x14(%ebx)
     23e:	e8 b6 0a 00 00       	call   cf9 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     243:	59                   	pop    %ecx
     244:	58                   	pop    %eax
     245:	ff 73 10             	pushl  0x10(%ebx)
     248:	ff 73 08             	pushl  0x8(%ebx)
     24b:	e8 c1 0a 00 00       	call   d11 <open>
     250:	83 c4 10             	add    $0x10,%esp
     253:	85 c0                	test   %eax,%eax
     255:	78 43                	js     29a <runcmd+0x12a>
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     257:	83 ec 0c             	sub    $0xc,%esp
     25a:	ff 73 04             	pushl  0x4(%ebx)
     25d:	e8 0e ff ff ff       	call   170 <runcmd>
int
fork1(void)
{
  int pid;
  
  pid = fork();
     262:	e8 62 0a 00 00       	call   cc9 <fork>
  if(pid == -1)
     267:	83 f8 ff             	cmp    $0xffffffff,%eax
     26a:	74 21                	je     28d <runcmd+0x11d>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     26c:	85 c0                	test   %eax,%eax
     26e:	74 e7                	je     257 <runcmd+0xe7>
      runcmd(lcmd->left);
    wait();
     270:	e8 64 0a 00 00       	call   cd9 <wait>
    runcmd(lcmd->right);
     275:	83 ec 0c             	sub    $0xc,%esp
     278:	ff 73 08             	pushl  0x8(%ebx)
     27b:	e8 f0 fe ff ff       	call   170 <runcmd>
  if(cmd == 0)
    exit();
  
  switch(cmd->type){
  default:
    panic("runcmd");
     280:	83 ec 0c             	sub    $0xc,%esp
     283:	68 3b 11 00 00       	push   $0x113b
     288:	e8 c3 fe ff ff       	call   150 <panic>
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
     28d:	83 ec 0c             	sub    $0xc,%esp
     290:	68 62 11 00 00       	push   $0x1162
     295:	e8 b6 fe ff ff       	call   150 <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     29a:	52                   	push   %edx
     29b:	ff 73 08             	pushl  0x8(%ebx)
     29e:	68 52 11 00 00       	push   $0x1152
     2a3:	6a 02                	push   $0x2
     2a5:	e8 66 0b 00 00       	call   e10 <printf>
      exit();
     2aa:	e8 22 0a 00 00       	call   cd1 <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     2af:	83 ec 0c             	sub    $0xc,%esp
     2b2:	68 67 11 00 00       	push   $0x1167
     2b7:	e8 94 fe ff ff       	call   150 <panic>
    if(fork1() == 0){
      close(1);
     2bc:	83 ec 0c             	sub    $0xc,%esp
     2bf:	6a 01                	push   $0x1
     2c1:	e8 33 0a 00 00       	call   cf9 <close>
      dup(p[1]);
     2c6:	58                   	pop    %eax
     2c7:	ff 74 24 18          	pushl  0x18(%esp)
     2cb:	e8 79 0a 00 00       	call   d49 <dup>
      close(p[0]);
     2d0:	58                   	pop    %eax
     2d1:	ff 74 24 14          	pushl  0x14(%esp)
     2d5:	e8 1f 0a 00 00       	call   cf9 <close>
      close(p[1]);
     2da:	58                   	pop    %eax
     2db:	ff 74 24 18          	pushl  0x18(%esp)
     2df:	e8 15 0a 00 00       	call   cf9 <close>
      runcmd(pcmd->left);
     2e4:	58                   	pop    %eax
     2e5:	ff 73 04             	pushl  0x4(%ebx)
     2e8:	e8 83 fe ff ff       	call   170 <runcmd>
    }
    if(fork1() == 0){
      close(0);
     2ed:	83 ec 0c             	sub    $0xc,%esp
     2f0:	6a 00                	push   $0x0
     2f2:	e8 02 0a 00 00       	call   cf9 <close>
      dup(p[0]);
     2f7:	5a                   	pop    %edx
     2f8:	ff 74 24 14          	pushl  0x14(%esp)
     2fc:	e8 48 0a 00 00       	call   d49 <dup>
      close(p[0]);
     301:	59                   	pop    %ecx
     302:	ff 74 24 14          	pushl  0x14(%esp)
     306:	e8 ee 09 00 00       	call   cf9 <close>
      close(p[1]);
     30b:	58                   	pop    %eax
     30c:	ff 74 24 18          	pushl  0x18(%esp)
     310:	e8 e4 09 00 00       	call   cf9 <close>
      runcmd(pcmd->right);
     315:	58                   	pop    %eax
     316:	ff 73 08             	pushl  0x8(%ebx)
     319:	e8 52 fe ff ff       	call   170 <runcmd>
     31e:	66 90                	xchg   %ax,%ax

00000320 <fork1>:
  exit();
}

int
fork1(void)
{
     320:	83 ec 0c             	sub    $0xc,%esp
  int pid;
  
  pid = fork();
     323:	e8 a1 09 00 00       	call   cc9 <fork>
  if(pid == -1)
     328:	83 f8 ff             	cmp    $0xffffffff,%eax
     32b:	74 04                	je     331 <fork1+0x11>
    panic("fork");
  return pid;
}
     32d:	83 c4 0c             	add    $0xc,%esp
     330:	c3                   	ret    
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
     331:	83 ec 0c             	sub    $0xc,%esp
     334:	68 62 11 00 00       	push   $0x1162
     339:	e8 12 fe ff ff       	call   150 <panic>
     33e:	66 90                	xchg   %ax,%ax

00000340 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     340:	53                   	push   %ebx
     341:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     344:	6a 54                	push   $0x54
     346:	e8 05 0d 00 00       	call   1050 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34b:	83 c4 0c             	add    $0xc,%esp
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     34e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     350:	6a 54                	push   $0x54
     352:	6a 00                	push   $0x0
     354:	50                   	push   %eax
     355:	e8 f6 07 00 00       	call   b50 <memset>
  cmd->type = EXEC;
     35a:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     360:	83 c4 18             	add    $0x18,%esp
     363:	89 d8                	mov    %ebx,%eax
     365:	5b                   	pop    %ebx
     366:	c3                   	ret    
     367:	89 f6                	mov    %esi,%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	53                   	push   %ebx
     371:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     374:	6a 18                	push   $0x18
     376:	e8 d5 0c 00 00       	call   1050 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37b:	83 c4 0c             	add    $0xc,%esp
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     37e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     380:	6a 18                	push   $0x18
     382:	6a 00                	push   $0x0
     384:	50                   	push   %eax
     385:	e8 c6 07 00 00       	call   b50 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     38a:	8b 44 24 20          	mov    0x20(%esp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     38e:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     394:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     397:	8b 44 24 24          	mov    0x24(%esp),%eax
     39b:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39e:	8b 44 24 28          	mov    0x28(%esp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     3a9:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ac:	8b 44 24 30          	mov    0x30(%esp),%eax
     3b0:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b3:	83 c4 18             	add    $0x18,%esp
     3b6:	89 d8                	mov    %ebx,%eax
     3b8:	5b                   	pop    %ebx
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3c0:	53                   	push   %ebx
     3c1:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c4:	6a 0c                	push   $0xc
     3c6:	e8 85 0c 00 00       	call   1050 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3cb:	83 c4 0c             	add    $0xc,%esp
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3ce:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d0:	6a 0c                	push   $0xc
     3d2:	6a 00                	push   $0x0
     3d4:	50                   	push   %eax
     3d5:	e8 76 07 00 00       	call   b50 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3da:	8b 44 24 20          	mov    0x20(%esp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     3de:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e4:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e7:	8b 44 24 24          	mov    0x24(%esp),%eax
     3eb:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ee:	83 c4 18             	add    $0x18,%esp
     3f1:	89 d8                	mov    %ebx,%eax
     3f3:	5b                   	pop    %ebx
     3f4:	c3                   	ret    
     3f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     400:	53                   	push   %ebx
     401:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     404:	6a 0c                	push   $0xc
     406:	e8 45 0c 00 00       	call   1050 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40b:	83 c4 0c             	add    $0xc,%esp
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     40e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     410:	6a 0c                	push   $0xc
     412:	6a 00                	push   $0x0
     414:	50                   	push   %eax
     415:	e8 36 07 00 00       	call   b50 <memset>
  cmd->type = LIST;
  cmd->left = left;
     41a:	8b 44 24 20          	mov    0x20(%esp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     41e:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     424:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     427:	8b 44 24 24          	mov    0x24(%esp),%eax
     42b:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     42e:	83 c4 18             	add    $0x18,%esp
     431:	89 d8                	mov    %ebx,%eax
     433:	5b                   	pop    %ebx
     434:	c3                   	ret    
     435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     440:	53                   	push   %ebx
     441:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     444:	6a 08                	push   $0x8
     446:	e8 05 0c 00 00       	call   1050 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44b:	83 c4 0c             	add    $0xc,%esp
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     44e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     450:	6a 08                	push   $0x8
     452:	6a 00                	push   $0x0
     454:	50                   	push   %eax
     455:	e8 f6 06 00 00       	call   b50 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     45a:	8b 44 24 20          	mov    0x20(%esp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     45e:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     464:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     467:	83 c4 18             	add    $0x18,%esp
     46a:	89 d8                	mov    %ebx,%eax
     46c:	5b                   	pop    %ebx
     46d:	c3                   	ret    
     46e:	66 90                	xchg   %ax,%ax

00000470 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     470:	55                   	push   %ebp
     471:	57                   	push   %edi
     472:	56                   	push   %esi
     473:	53                   	push   %ebx
     474:	83 ec 0c             	sub    $0xc,%esp
     477:	8b 7c 24 20          	mov    0x20(%esp),%edi
     47b:	8b 5c 24 24          	mov    0x24(%esp),%ebx
     47f:	8b 74 24 28          	mov    0x28(%esp),%esi
  char *s;
  int ret;
  
  s = *ps;
     483:	8b 2f                	mov    (%edi),%ebp
  while(s < es && strchr(whitespace, *s))
     485:	39 dd                	cmp    %ebx,%ebp
     487:	72 12                	jb     49b <gettoken+0x2b>
     489:	eb 29                	jmp    4b4 <gettoken+0x44>
     48b:	90                   	nop
     48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     490:	83 c5 01             	add    $0x1,%ebp
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     493:	39 eb                	cmp    %ebp,%ebx
     495:	0f 84 ed 00 00 00    	je     588 <gettoken+0x118>
     49b:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     49f:	83 ec 08             	sub    $0x8,%esp
     4a2:	50                   	push   %eax
     4a3:	68 10 1c 00 00       	push   $0x1c10
     4a8:	e8 c3 06 00 00       	call   b70 <strchr>
     4ad:	83 c4 10             	add    $0x10,%esp
     4b0:	85 c0                	test   %eax,%eax
     4b2:	75 dc                	jne    490 <gettoken+0x20>
    s++;
  if(q)
     4b4:	85 f6                	test   %esi,%esi
     4b6:	74 02                	je     4ba <gettoken+0x4a>
    *q = s;
     4b8:	89 2e                	mov    %ebp,(%esi)
  ret = *s;
     4ba:	0f be 75 00          	movsbl 0x0(%ebp),%esi
     4be:	89 f1                	mov    %esi,%ecx
     4c0:	89 f0                	mov    %esi,%eax
  switch(*s){
     4c2:	80 f9 29             	cmp    $0x29,%cl
     4c5:	7f 59                	jg     520 <gettoken+0xb0>
     4c7:	80 f9 28             	cmp    $0x28,%cl
     4ca:	7d 5f                	jge    52b <gettoken+0xbb>
     4cc:	84 c9                	test   %cl,%cl
     4ce:	0f 85 dc 00 00 00    	jne    5b0 <gettoken+0x140>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4d4:	8b 54 24 2c          	mov    0x2c(%esp),%edx
     4d8:	85 d2                	test   %edx,%edx
     4da:	74 06                	je     4e2 <gettoken+0x72>
    *eq = s;
     4dc:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     4e0:	89 28                	mov    %ebp,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     4e2:	39 eb                	cmp    %ebp,%ebx
     4e4:	77 11                	ja     4f7 <gettoken+0x87>
     4e6:	eb 28                	jmp    510 <gettoken+0xa0>
     4e8:	90                   	nop
     4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s++;
     4f0:	83 c5 01             	add    $0x1,%ebp
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     4f3:	39 eb                	cmp    %ebp,%ebx
     4f5:	74 19                	je     510 <gettoken+0xa0>
     4f7:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     4fb:	83 ec 08             	sub    $0x8,%esp
     4fe:	50                   	push   %eax
     4ff:	68 10 1c 00 00       	push   $0x1c10
     504:	e8 67 06 00 00       	call   b70 <strchr>
     509:	83 c4 10             	add    $0x10,%esp
     50c:	85 c0                	test   %eax,%eax
     50e:	75 e0                	jne    4f0 <gettoken+0x80>
    s++;
  *ps = s;
     510:	89 2f                	mov    %ebp,(%edi)
  return ret;
}
     512:	83 c4 0c             	add    $0xc,%esp
     515:	89 f0                	mov    %esi,%eax
     517:	5b                   	pop    %ebx
     518:	5e                   	pop    %esi
     519:	5f                   	pop    %edi
     51a:	5d                   	pop    %ebp
     51b:	c3                   	ret    
     51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     520:	80 f9 3e             	cmp    $0x3e,%cl
     523:	75 0b                	jne    530 <gettoken+0xc0>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     525:	80 7d 01 3e          	cmpb   $0x3e,0x1(%ebp)
     529:	74 75                	je     5a0 <gettoken+0x130>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     52b:	83 c5 01             	add    $0x1,%ebp
     52e:	eb a4                	jmp    4d4 <gettoken+0x64>
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     530:	7f 5e                	jg     590 <gettoken+0x120>
     532:	83 e9 3b             	sub    $0x3b,%ecx
     535:	80 f9 01             	cmp    $0x1,%cl
     538:	76 f1                	jbe    52b <gettoken+0xbb>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     53a:	39 eb                	cmp    %ebp,%ebx
     53c:	77 26                	ja     564 <gettoken+0xf4>
     53e:	eb 7c                	jmp    5bc <gettoken+0x14c>
     540:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     544:	83 ec 08             	sub    $0x8,%esp
     547:	50                   	push   %eax
     548:	68 08 1c 00 00       	push   $0x1c08
     54d:	e8 1e 06 00 00       	call   b70 <strchr>
     552:	83 c4 10             	add    $0x10,%esp
     555:	85 c0                	test   %eax,%eax
     557:	75 20                	jne    579 <gettoken+0x109>
      s++;
     559:	83 c5 01             	add    $0x1,%ebp
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     55c:	39 eb                	cmp    %ebp,%ebx
     55e:	74 5a                	je     5ba <gettoken+0x14a>
     560:	0f be 45 00          	movsbl 0x0(%ebp),%eax
     564:	83 ec 08             	sub    $0x8,%esp
     567:	50                   	push   %eax
     568:	68 10 1c 00 00       	push   $0x1c10
     56d:	e8 fe 05 00 00       	call   b70 <strchr>
     572:	83 c4 10             	add    $0x10,%esp
     575:	85 c0                	test   %eax,%eax
     577:	74 c7                	je     540 <gettoken+0xd0>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     579:	be 61 00 00 00       	mov    $0x61,%esi
     57e:	e9 51 ff ff ff       	jmp    4d4 <gettoken+0x64>
     583:	90                   	nop
     584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     588:	89 dd                	mov    %ebx,%ebp
     58a:	e9 25 ff ff ff       	jmp    4b4 <gettoken+0x44>
     58f:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     590:	80 f9 7c             	cmp    $0x7c,%cl
     593:	74 96                	je     52b <gettoken+0xbb>
     595:	eb a3                	jmp    53a <gettoken+0xca>
     597:	89 f6                	mov    %esi,%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
     5a0:	83 c5 02             	add    $0x2,%ebp
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     5a3:	be 2b 00 00 00       	mov    $0x2b,%esi
     5a8:	e9 27 ff ff ff       	jmp    4d4 <gettoken+0x64>
     5ad:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5b0:	80 f9 26             	cmp    $0x26,%cl
     5b3:	75 85                	jne    53a <gettoken+0xca>
     5b5:	e9 71 ff ff ff       	jmp    52b <gettoken+0xbb>
     5ba:	89 dd                	mov    %ebx,%ebp
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     5bc:	8b 44 24 2c          	mov    0x2c(%esp),%eax
     5c0:	be 61 00 00 00       	mov    $0x61,%esi
     5c5:	85 c0                	test   %eax,%eax
     5c7:	0f 85 0f ff ff ff    	jne    4dc <gettoken+0x6c>
     5cd:	e9 3e ff ff ff       	jmp    510 <gettoken+0xa0>
     5d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     5e0:	57                   	push   %edi
     5e1:	56                   	push   %esi
     5e2:	53                   	push   %ebx
     5e3:	8b 7c 24 10          	mov    0x10(%esp),%edi
     5e7:	8b 74 24 14          	mov    0x14(%esp),%esi
  char *s;
  
  s = *ps;
     5eb:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5ed:	39 f3                	cmp    %esi,%ebx
     5ef:	72 0e                	jb     5ff <peek+0x1f>
     5f1:	eb 24                	jmp    617 <peek+0x37>
     5f3:	90                   	nop
     5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     5f8:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     5fb:	39 de                	cmp    %ebx,%esi
     5fd:	74 18                	je     617 <peek+0x37>
     5ff:	0f be 03             	movsbl (%ebx),%eax
     602:	83 ec 08             	sub    $0x8,%esp
     605:	50                   	push   %eax
     606:	68 10 1c 00 00       	push   $0x1c10
     60b:	e8 60 05 00 00       	call   b70 <strchr>
     610:	83 c4 10             	add    $0x10,%esp
     613:	85 c0                	test   %eax,%eax
     615:	75 e1                	jne    5f8 <peek+0x18>
    s++;
  *ps = s;
     617:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     619:	0f be 13             	movsbl (%ebx),%edx
     61c:	31 c0                	xor    %eax,%eax
     61e:	84 d2                	test   %dl,%dl
     620:	74 18                	je     63a <peek+0x5a>
     622:	83 ec 08             	sub    $0x8,%esp
     625:	52                   	push   %edx
     626:	ff 74 24 24          	pushl  0x24(%esp)
     62a:	e8 41 05 00 00       	call   b70 <strchr>
     62f:	83 c4 10             	add    $0x10,%esp
     632:	85 c0                	test   %eax,%eax
     634:	0f 95 c0             	setne  %al
     637:	0f b6 c0             	movzbl %al,%eax
}
     63a:	5b                   	pop    %ebx
     63b:	5e                   	pop    %esi
     63c:	5f                   	pop    %edi
     63d:	c3                   	ret    
     63e:	66 90                	xchg   %ax,%ax

00000640 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     640:	55                   	push   %ebp
     641:	57                   	push   %edi
     642:	56                   	push   %esi
     643:	53                   	push   %ebx
     644:	83 ec 1c             	sub    $0x1c,%esp
     647:	8b 7c 24 30          	mov    0x30(%esp),%edi
     64b:	8b 74 24 34          	mov    0x34(%esp),%esi
     64f:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     653:	90                   	nop
     654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     658:	83 ec 04             	sub    $0x4,%esp
     65b:	68 89 11 00 00       	push   $0x1189
     660:	53                   	push   %ebx
     661:	56                   	push   %esi
     662:	e8 79 ff ff ff       	call   5e0 <peek>
     667:	83 c4 10             	add    $0x10,%esp
     66a:	85 c0                	test   %eax,%eax
     66c:	74 6a                	je     6d8 <parseredirs+0x98>
    tok = gettoken(ps, es, 0, 0);
     66e:	6a 00                	push   $0x0
     670:	6a 00                	push   $0x0
     672:	53                   	push   %ebx
     673:	56                   	push   %esi
     674:	e8 f7 fd ff ff       	call   470 <gettoken>
     679:	89 c5                	mov    %eax,%ebp
    if(gettoken(ps, es, &q, &eq) != 'a')
     67b:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     67f:	50                   	push   %eax
     680:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     684:	50                   	push   %eax
     685:	53                   	push   %ebx
     686:	56                   	push   %esi
     687:	e8 e4 fd ff ff       	call   470 <gettoken>
     68c:	83 c4 20             	add    $0x20,%esp
     68f:	83 f8 61             	cmp    $0x61,%eax
     692:	75 4e                	jne    6e2 <parseredirs+0xa2>
      panic("missing file for redirection");
    switch(tok){
     694:	83 fd 3c             	cmp    $0x3c,%ebp
     697:	74 2f                	je     6c8 <parseredirs+0x88>
     699:	83 fd 3e             	cmp    $0x3e,%ebp
     69c:	74 05                	je     6a3 <parseredirs+0x63>
     69e:	83 fd 2b             	cmp    $0x2b,%ebp
     6a1:	75 b5                	jne    658 <parseredirs+0x18>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6a3:	83 ec 0c             	sub    $0xc,%esp
     6a6:	6a 01                	push   $0x1
     6a8:	68 01 02 00 00       	push   $0x201
     6ad:	ff 74 24 20          	pushl  0x20(%esp)
     6b1:	ff 74 24 20          	pushl  0x20(%esp)
     6b5:	57                   	push   %edi
     6b6:	e8 b5 fc ff ff       	call   370 <redircmd>
      break;
     6bb:	83 c4 20             	add    $0x20,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6be:	89 c7                	mov    %eax,%edi
      break;
     6c0:	eb 96                	jmp    658 <parseredirs+0x18>
     6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c8:	83 ec 0c             	sub    $0xc,%esp
     6cb:	6a 00                	push   $0x0
     6cd:	6a 00                	push   $0x0
     6cf:	eb dc                	jmp    6ad <parseredirs+0x6d>
     6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     6d8:	83 c4 1c             	add    $0x1c,%esp
     6db:	89 f8                	mov    %edi,%eax
     6dd:	5b                   	pop    %ebx
     6de:	5e                   	pop    %esi
     6df:	5f                   	pop    %edi
     6e0:	5d                   	pop    %ebp
     6e1:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	68 6c 11 00 00       	push   $0x116c
     6ea:	e8 61 fa ff ff       	call   150 <panic>
     6ef:	90                   	nop

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	57                   	push   %edi
     6f2:	56                   	push   %esi
     6f3:	53                   	push   %ebx
     6f4:	83 ec 30             	sub    $0x30,%esp
     6f7:	8b 74 24 44          	mov    0x44(%esp),%esi
     6fb:	8b 7c 24 48          	mov    0x48(%esp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     6ff:	68 8c 11 00 00       	push   $0x118c
     704:	57                   	push   %edi
     705:	56                   	push   %esi
     706:	e8 d5 fe ff ff       	call   5e0 <peek>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	85 c0                	test   %eax,%eax
     710:	0f 85 9a 00 00 00    	jne    7b0 <parseexec+0xc0>
    return parseblock(ps, es);

  ret = execcmd();
     716:	e8 25 fc ff ff       	call   340 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     71b:	83 ec 04             	sub    $0x4,%esp
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     71e:	89 44 24 10          	mov    %eax,0x10(%esp)
     722:	89 c3                	mov    %eax,%ebx
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     724:	57                   	push   %edi
     725:	56                   	push   %esi
     726:	8d 5b 04             	lea    0x4(%ebx),%ebx
     729:	50                   	push   %eax
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
     72a:	31 ed                	xor    %ebp,%ebp
  ret = parseredirs(ret, ps, es);
     72c:	e8 0f ff ff ff       	call   640 <parseredirs>
     731:	89 44 24 18          	mov    %eax,0x18(%esp)
     735:	83 c4 10             	add    $0x10,%esp
     738:	eb 1b                	jmp    755 <parseexec+0x65>
     73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     740:	83 ec 04             	sub    $0x4,%esp
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	ff 74 24 14          	pushl  0x14(%esp)
     749:	e8 f2 fe ff ff       	call   640 <parseredirs>
     74e:	89 44 24 18          	mov    %eax,0x18(%esp)
     752:	83 c4 10             	add    $0x10,%esp
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     755:	83 ec 04             	sub    $0x4,%esp
     758:	68 a3 11 00 00       	push   $0x11a3
     75d:	57                   	push   %edi
     75e:	56                   	push   %esi
     75f:	e8 7c fe ff ff       	call   5e0 <peek>
     764:	83 c4 10             	add    $0x10,%esp
     767:	85 c0                	test   %eax,%eax
     769:	75 5d                	jne    7c8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     76b:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     76f:	50                   	push   %eax
     770:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     774:	50                   	push   %eax
     775:	57                   	push   %edi
     776:	56                   	push   %esi
     777:	e8 f4 fc ff ff       	call   470 <gettoken>
     77c:	83 c4 10             	add    $0x10,%esp
     77f:	85 c0                	test   %eax,%eax
     781:	74 45                	je     7c8 <parseexec+0xd8>
      break;
    if(tok != 'a')
     783:	83 f8 61             	cmp    $0x61,%eax
     786:	75 61                	jne    7e9 <parseexec+0xf9>
      panic("syntax");
    cmd->argv[argc] = q;
     788:	8b 44 24 18          	mov    0x18(%esp),%eax
    cmd->eargv[argc] = eq;
    argc++;
     78c:	83 c5 01             	add    $0x1,%ebp
     78f:	83 c3 04             	add    $0x4,%ebx
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
     792:	89 43 fc             	mov    %eax,-0x4(%ebx)
    cmd->eargv[argc] = eq;
     795:	8b 44 24 1c          	mov    0x1c(%esp),%eax
     799:	89 43 24             	mov    %eax,0x24(%ebx)
    argc++;
    if(argc >= MAXARGS)
     79c:	83 fd 0a             	cmp    $0xa,%ebp
     79f:	75 9f                	jne    740 <parseexec+0x50>
      panic("too many args");
     7a1:	83 ec 0c             	sub    $0xc,%esp
     7a4:	68 95 11 00 00       	push   $0x1195
     7a9:	e8 a2 f9 ff ff       	call   150 <panic>
     7ae:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);
     7b0:	83 ec 08             	sub    $0x8,%esp
     7b3:	57                   	push   %edi
     7b4:	56                   	push   %esi
     7b5:	e8 46 01 00 00       	call   900 <parseblock>
     7ba:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7bd:	83 c4 2c             	add    $0x2c,%esp
     7c0:	5b                   	pop    %ebx
     7c1:	5e                   	pop    %esi
     7c2:	5f                   	pop    %edi
     7c3:	5d                   	pop    %ebp
     7c4:	c3                   	ret    
     7c5:	8d 76 00             	lea    0x0(%esi),%esi
     7c8:	8b 44 24 0c          	mov    0xc(%esp),%eax
     7cc:	8d 04 a8             	lea    (%eax,%ebp,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     7cf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7d6:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
     7dd:	8b 44 24 08          	mov    0x8(%esp),%eax
  return ret;
}
     7e1:	83 c4 2c             	add    $0x2c,%esp
     7e4:	5b                   	pop    %ebx
     7e5:	5e                   	pop    %esi
     7e6:	5f                   	pop    %edi
     7e7:	5d                   	pop    %ebp
     7e8:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
     7e9:	83 ec 0c             	sub    $0xc,%esp
     7ec:	68 8e 11 00 00       	push   $0x118e
     7f1:	e8 5a f9 ff ff       	call   150 <panic>
     7f6:	8d 76 00             	lea    0x0(%esi),%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     800:	57                   	push   %edi
     801:	56                   	push   %esi
     802:	53                   	push   %ebx
     803:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     807:	8b 74 24 14          	mov    0x14(%esp),%esi
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     80b:	83 ec 08             	sub    $0x8,%esp
     80e:	56                   	push   %esi
     80f:	53                   	push   %ebx
     810:	e8 db fe ff ff       	call   6f0 <parseexec>
  if(peek(ps, es, "|")){
     815:	83 c4 0c             	add    $0xc,%esp
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     818:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     81a:	68 a8 11 00 00       	push   $0x11a8
     81f:	56                   	push   %esi
     820:	53                   	push   %ebx
     821:	e8 ba fd ff ff       	call   5e0 <peek>
     826:	83 c4 10             	add    $0x10,%esp
     829:	85 c0                	test   %eax,%eax
     82b:	75 0b                	jne    838 <parsepipe+0x38>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     82d:	89 f8                	mov    %edi,%eax
     82f:	5b                   	pop    %ebx
     830:	5e                   	pop    %esi
     831:	5f                   	pop    %edi
     832:	c3                   	ret    
     833:	90                   	nop
     834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     838:	6a 00                	push   $0x0
     83a:	6a 00                	push   $0x0
     83c:	56                   	push   %esi
     83d:	53                   	push   %ebx
     83e:	e8 2d fc ff ff       	call   470 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     843:	58                   	pop    %eax
     844:	5a                   	pop    %edx
     845:	56                   	push   %esi
     846:	53                   	push   %ebx
     847:	e8 b4 ff ff ff       	call   800 <parsepipe>
     84c:	83 c4 10             	add    $0x10,%esp
     84f:	89 44 24 14          	mov    %eax,0x14(%esp)
     853:	89 7c 24 10          	mov    %edi,0x10(%esp)
  }
  return cmd;
}
     857:	5b                   	pop    %ebx
     858:	5e                   	pop    %esi
     859:	5f                   	pop    %edi
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     85a:	e9 61 fb ff ff       	jmp    3c0 <pipecmd>
     85f:	90                   	nop

00000860 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     860:	57                   	push   %edi
     861:	56                   	push   %esi
     862:	53                   	push   %ebx
     863:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     867:	8b 74 24 14          	mov    0x14(%esp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     86b:	83 ec 08             	sub    $0x8,%esp
     86e:	56                   	push   %esi
     86f:	53                   	push   %ebx
     870:	e8 8b ff ff ff       	call   800 <parsepipe>
  while(peek(ps, es, "&")){
     875:	83 c4 10             	add    $0x10,%esp
struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     878:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     87a:	eb 1c                	jmp    898 <parseline+0x38>
     87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     880:	6a 00                	push   $0x0
     882:	6a 00                	push   $0x0
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	e8 e5 fb ff ff       	call   470 <gettoken>
    cmd = backcmd(cmd);
     88b:	89 3c 24             	mov    %edi,(%esp)
     88e:	e8 ad fb ff ff       	call   440 <backcmd>
     893:	83 c4 10             	add    $0x10,%esp
     896:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     898:	83 ec 04             	sub    $0x4,%esp
     89b:	68 aa 11 00 00       	push   $0x11aa
     8a0:	56                   	push   %esi
     8a1:	53                   	push   %ebx
     8a2:	e8 39 fd ff ff       	call   5e0 <peek>
     8a7:	83 c4 10             	add    $0x10,%esp
     8aa:	85 c0                	test   %eax,%eax
     8ac:	75 d2                	jne    880 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     8ae:	83 ec 04             	sub    $0x4,%esp
     8b1:	68 a6 11 00 00       	push   $0x11a6
     8b6:	56                   	push   %esi
     8b7:	53                   	push   %ebx
     8b8:	e8 23 fd ff ff       	call   5e0 <peek>
     8bd:	83 c4 10             	add    $0x10,%esp
     8c0:	85 c0                	test   %eax,%eax
     8c2:	75 0c                	jne    8d0 <parseline+0x70>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     8c4:	89 f8                	mov    %edi,%eax
     8c6:	5b                   	pop    %ebx
     8c7:	5e                   	pop    %esi
     8c8:	5f                   	pop    %edi
     8c9:	c3                   	ret    
     8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     8d0:	6a 00                	push   $0x0
     8d2:	6a 00                	push   $0x0
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	e8 95 fb ff ff       	call   470 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8db:	58                   	pop    %eax
     8dc:	5a                   	pop    %edx
     8dd:	56                   	push   %esi
     8de:	53                   	push   %ebx
     8df:	e8 7c ff ff ff       	call   860 <parseline>
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	89 44 24 14          	mov    %eax,0x14(%esp)
     8eb:	89 7c 24 10          	mov    %edi,0x10(%esp)
  }
  return cmd;
}
     8ef:	5b                   	pop    %ebx
     8f0:	5e                   	pop    %esi
     8f1:	5f                   	pop    %edi
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     8f2:	e9 09 fb ff ff       	jmp    400 <listcmd>
     8f7:	89 f6                	mov    %esi,%esi
     8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     900:	57                   	push   %edi
     901:	56                   	push   %esi
     902:	53                   	push   %ebx
     903:	8b 5c 24 10          	mov    0x10(%esp),%ebx
     907:	8b 74 24 14          	mov    0x14(%esp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     90b:	83 ec 04             	sub    $0x4,%esp
     90e:	68 8c 11 00 00       	push   $0x118c
     913:	56                   	push   %esi
     914:	53                   	push   %ebx
     915:	e8 c6 fc ff ff       	call   5e0 <peek>
     91a:	83 c4 10             	add    $0x10,%esp
     91d:	85 c0                	test   %eax,%eax
     91f:	74 49                	je     96a <parseblock+0x6a>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     921:	6a 00                	push   $0x0
     923:	6a 00                	push   $0x0
     925:	56                   	push   %esi
     926:	53                   	push   %ebx
     927:	e8 44 fb ff ff       	call   470 <gettoken>
  cmd = parseline(ps, es);
     92c:	58                   	pop    %eax
     92d:	5a                   	pop    %edx
     92e:	56                   	push   %esi
     92f:	53                   	push   %ebx
     930:	e8 2b ff ff ff       	call   860 <parseline>
  if(!peek(ps, es, ")"))
     935:	83 c4 0c             	add    $0xc,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     938:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     93a:	68 c8 11 00 00       	push   $0x11c8
     93f:	56                   	push   %esi
     940:	53                   	push   %ebx
     941:	e8 9a fc ff ff       	call   5e0 <peek>
     946:	83 c4 10             	add    $0x10,%esp
     949:	85 c0                	test   %eax,%eax
     94b:	74 2a                	je     977 <parseblock+0x77>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
     94d:	6a 00                	push   $0x0
     94f:	6a 00                	push   $0x0
     951:	56                   	push   %esi
     952:	53                   	push   %ebx
     953:	e8 18 fb ff ff       	call   470 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     958:	83 c4 0c             	add    $0xc,%esp
     95b:	56                   	push   %esi
     95c:	53                   	push   %ebx
     95d:	57                   	push   %edi
     95e:	e8 dd fc ff ff       	call   640 <parseredirs>
  return cmd;
     963:	83 c4 10             	add    $0x10,%esp
}
     966:	5b                   	pop    %ebx
     967:	5e                   	pop    %esi
     968:	5f                   	pop    %edi
     969:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     96a:	83 ec 0c             	sub    $0xc,%esp
     96d:	68 ac 11 00 00       	push   $0x11ac
     972:	e8 d9 f7 ff ff       	call   150 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
     977:	83 ec 0c             	sub    $0xc,%esp
     97a:	68 b7 11 00 00       	push   $0x11b7
     97f:	e8 cc f7 ff ff       	call   150 <panic>
     984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     98a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000990 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     990:	53                   	push   %ebx
     991:	83 ec 08             	sub    $0x8,%esp
     994:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     998:	85 db                	test   %ebx,%ebx
     99a:	0f 84 98 00 00 00    	je     a38 <nulterminate+0xa8>
    return 0;
  
  switch(cmd->type){
     9a0:	83 3b 05             	cmpl   $0x5,(%ebx)
     9a3:	77 4a                	ja     9ef <nulterminate+0x5f>
     9a5:	8b 03                	mov    (%ebx),%eax
     9a7:	ff 24 85 08 12 00 00 	jmp    *0x1208(,%eax,4)
     9ae:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     9b0:	83 ec 0c             	sub    $0xc,%esp
     9b3:	ff 73 04             	pushl  0x4(%ebx)
     9b6:	e8 d5 ff ff ff       	call   990 <nulterminate>
    nulterminate(lcmd->right);
     9bb:	58                   	pop    %eax
     9bc:	ff 73 08             	pushl  0x8(%ebx)
     9bf:	e8 cc ff ff ff       	call   990 <nulterminate>
    break;
     9c4:	83 c4 10             	add    $0x10,%esp
     9c7:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9c9:	83 c4 08             	add    $0x8,%esp
     9cc:	5b                   	pop    %ebx
     9cd:	c3                   	ret    
     9ce:	66 90                	xchg   %ax,%ax
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     9d0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     9d3:	8d 43 2c             	lea    0x2c(%ebx),%eax
     9d6:	85 c9                	test   %ecx,%ecx
     9d8:	74 15                	je     9ef <nulterminate+0x5f>
     9da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     9e0:	8b 10                	mov    (%eax),%edx
     9e2:	83 c0 04             	add    $0x4,%eax
     9e5:	c6 02 00             	movb   $0x0,(%edx)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     9e8:	8b 50 d8             	mov    -0x28(%eax),%edx
     9eb:	85 d2                	test   %edx,%edx
     9ed:	75 f1                	jne    9e0 <nulterminate+0x50>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9ef:	83 c4 08             	add    $0x8,%esp
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
  
  switch(cmd->type){
     9f2:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9f4:	5b                   	pop    %ebx
     9f5:	c3                   	ret    
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a00:	83 ec 0c             	sub    $0xc,%esp
     a03:	ff 73 04             	pushl  0x4(%ebx)
     a06:	e8 85 ff ff ff       	call   990 <nulterminate>
    break;
     a0b:	83 c4 10             	add    $0x10,%esp
     a0e:	89 d8                	mov    %ebx,%eax
  }
  return cmd;
}
     a10:	83 c4 08             	add    $0x8,%esp
     a13:	5b                   	pop    %ebx
     a14:	c3                   	ret    
     a15:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     a18:	83 ec 0c             	sub    $0xc,%esp
     a1b:	ff 73 04             	pushl  0x4(%ebx)
     a1e:	e8 6d ff ff ff       	call   990 <nulterminate>
    *rcmd->efile = 0;
     a23:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a26:	83 c4 10             	add    $0x10,%esp
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
     a29:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a2c:	83 c4 08             	add    $0x8,%esp

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;
     a2f:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a31:	5b                   	pop    %ebx
     a32:	c3                   	ret    
     a33:	90                   	nop
     a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
     a38:	31 c0                	xor    %eax,%eax
     a3a:	eb 8d                	jmp    9c9 <nulterminate+0x39>
     a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a40 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     a40:	56                   	push   %esi
     a41:	53                   	push   %ebx
     a42:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     a45:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
     a49:	53                   	push   %ebx
     a4a:	e8 e1 00 00 00       	call   b30 <strlen>
  cmd = parseline(&s, es);
     a4f:	59                   	pop    %ecx
     a50:	5e                   	pop    %esi
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     a51:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a53:	53                   	push   %ebx
     a54:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     a58:	50                   	push   %eax
     a59:	e8 02 fe ff ff       	call   860 <parseline>
  peek(&s, es, "");
     a5e:	83 c4 0c             	add    $0xc,%esp
{
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
  cmd = parseline(&s, es);
     a61:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a63:	68 51 11 00 00       	push   $0x1151
     a68:	53                   	push   %ebx
     a69:	8d 44 24 1c          	lea    0x1c(%esp),%eax
     a6d:	50                   	push   %eax
     a6e:	e8 6d fb ff ff       	call   5e0 <peek>
  if(s != es){
     a73:	8b 44 24 20          	mov    0x20(%esp),%eax
     a77:	83 c4 10             	add    $0x10,%esp
     a7a:	39 c3                	cmp    %eax,%ebx
     a7c:	75 11                	jne    a8f <parsecmd+0x4f>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
     a7e:	83 ec 0c             	sub    $0xc,%esp
     a81:	56                   	push   %esi
     a82:	e8 09 ff ff ff       	call   990 <nulterminate>
  return cmd;
}
     a87:	83 c4 14             	add    $0x14,%esp
     a8a:	89 f0                	mov    %esi,%eax
     a8c:	5b                   	pop    %ebx
     a8d:	5e                   	pop    %esi
     a8e:	c3                   	ret    
  
  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
     a8f:	52                   	push   %edx
     a90:	50                   	push   %eax
     a91:	68 ca 11 00 00       	push   $0x11ca
     a96:	6a 02                	push   $0x2
     a98:	e8 73 03 00 00       	call   e10 <printf>
    panic("syntax");
     a9d:	c7 04 24 8e 11 00 00 	movl   $0x118e,(%esp)
     aa4:	e8 a7 f6 ff ff       	call   150 <panic>
     aa9:	66 90                	xchg   %ax,%ax
     aab:	66 90                	xchg   %ax,%ax
     aad:	66 90                	xchg   %ax,%ax
     aaf:	90                   	nop

00000ab0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ab0:	53                   	push   %ebx
     ab1:	8b 44 24 08          	mov    0x8(%esp),%eax
     ab5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     ab9:	89 c2                	mov    %eax,%edx
     abb:	90                   	nop
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ac0:	83 c1 01             	add    $0x1,%ecx
     ac3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ac7:	83 c2 01             	add    $0x1,%edx
     aca:	84 db                	test   %bl,%bl
     acc:	88 5a ff             	mov    %bl,-0x1(%edx)
     acf:	75 ef                	jne    ac0 <strcpy+0x10>
    ;
  return os;
}
     ad1:	5b                   	pop    %ebx
     ad2:	c3                   	ret    
     ad3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ae0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     ae0:	56                   	push   %esi
     ae1:	53                   	push   %ebx
     ae2:	8b 54 24 0c          	mov    0xc(%esp),%edx
     ae6:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  while(*p && *p == *q)
     aea:	0f b6 02             	movzbl (%edx),%eax
     aed:	0f b6 19             	movzbl (%ecx),%ebx
     af0:	84 c0                	test   %al,%al
     af2:	75 1f                	jne    b13 <strcmp+0x33>
     af4:	eb 2a                	jmp    b20 <strcmp+0x40>
     af6:	8d 76 00             	lea    0x0(%esi),%esi
     af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b00:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b03:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b06:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b09:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     b0d:	84 c0                	test   %al,%al
     b0f:	74 0f                	je     b20 <strcmp+0x40>
     b11:	89 f1                	mov    %esi,%ecx
     b13:	38 d8                	cmp    %bl,%al
     b15:	74 e9                	je     b00 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     b17:	29 d8                	sub    %ebx,%eax
}
     b19:	5b                   	pop    %ebx
     b1a:	5e                   	pop    %esi
     b1b:	c3                   	ret    
     b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b20:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     b22:	29 d8                	sub    %ebx,%eax
}
     b24:	5b                   	pop    %ebx
     b25:	5e                   	pop    %esi
     b26:	c3                   	ret    
     b27:	89 f6                	mov    %esi,%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b30 <strlen>:

uint
strlen(char *s)
{
     b30:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b34:	80 39 00             	cmpb   $0x0,(%ecx)
     b37:	74 14                	je     b4d <strlen+0x1d>
     b39:	31 d2                	xor    %edx,%edx
     b3b:	90                   	nop
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b40:	83 c2 01             	add    $0x1,%edx
     b43:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b47:	89 d0                	mov    %edx,%eax
     b49:	75 f5                	jne    b40 <strlen+0x10>
     b4b:	f3 c3                	repz ret 
     b4d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     b4f:	c3                   	ret    

00000b50 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b50:	57                   	push   %edi
     b51:	8b 54 24 08          	mov    0x8(%esp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b55:	8b 4c 24 10          	mov    0x10(%esp),%ecx
     b59:	8b 44 24 0c          	mov    0xc(%esp),%eax
     b5d:	89 d7                	mov    %edx,%edi
     b5f:	fc                   	cld    
     b60:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b62:	89 d0                	mov    %edx,%eax
     b64:	5f                   	pop    %edi
     b65:	c3                   	ret    
     b66:	8d 76 00             	lea    0x0(%esi),%esi
     b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b70 <strchr>:

char*
strchr(const char *s, char c)
{
     b70:	53                   	push   %ebx
     b71:	8b 44 24 08          	mov    0x8(%esp),%eax
     b75:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  for(; *s; s++)
     b79:	0f b6 10             	movzbl (%eax),%edx
     b7c:	84 d2                	test   %dl,%dl
     b7e:	74 1e                	je     b9e <strchr+0x2e>
    if(*s == c)
     b80:	38 d3                	cmp    %dl,%bl
     b82:	89 d9                	mov    %ebx,%ecx
     b84:	75 0e                	jne    b94 <strchr+0x24>
     b86:	eb 18                	jmp    ba0 <strchr+0x30>
     b88:	90                   	nop
     b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b90:	38 ca                	cmp    %cl,%dl
     b92:	74 0c                	je     ba0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     b94:	83 c0 01             	add    $0x1,%eax
     b97:	0f b6 10             	movzbl (%eax),%edx
     b9a:	84 d2                	test   %dl,%dl
     b9c:	75 f2                	jne    b90 <strchr+0x20>
    if(*s == c)
      return (char*) s;
  return 0;
     b9e:	31 c0                	xor    %eax,%eax
}
     ba0:	5b                   	pop    %ebx
     ba1:	c3                   	ret    
     ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <gets>:

char*
gets(char *buf, int max)
{
     bb0:	55                   	push   %ebp
     bb1:	57                   	push   %edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bb2:	31 ff                	xor    %edi,%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 1c             	sub    $0x1c,%esp
     bb9:	8b 74 24 30          	mov    0x30(%esp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     bbd:	8d 6c 24 0f          	lea    0xf(%esp),%ebp
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bc1:	eb 2c                	jmp    bef <gets+0x3f>
     bc3:	90                   	nop
     bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cc = read(0, &c, 1);
     bc8:	83 ec 04             	sub    $0x4,%esp
     bcb:	6a 01                	push   $0x1
     bcd:	55                   	push   %ebp
     bce:	6a 00                	push   $0x0
     bd0:	e8 14 01 00 00       	call   ce9 <read>
    if(cc < 1)
     bd5:	83 c4 10             	add    $0x10,%esp
     bd8:	85 c0                	test   %eax,%eax
     bda:	7e 1c                	jle    bf8 <gets+0x48>
      break;
    buf[i++] = c;
     bdc:	0f b6 44 24 0f       	movzbl 0xf(%esp),%eax
     be1:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
     be3:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     be5:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
     be9:	74 25                	je     c10 <gets+0x60>
     beb:	3c 0d                	cmp    $0xd,%al
     bed:	74 21                	je     c10 <gets+0x60>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bef:	8d 5f 01             	lea    0x1(%edi),%ebx
     bf2:	3b 5c 24 34          	cmp    0x34(%esp),%ebx
     bf6:	7c d0                	jl     bc8 <gets+0x18>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     bf8:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
     bfc:	83 c4 1c             	add    $0x1c,%esp
     bff:	89 f0                	mov    %esi,%eax
     c01:	5b                   	pop    %ebx
     c02:	5e                   	pop    %esi
     c03:	5f                   	pop    %edi
     c04:	5d                   	pop    %ebp
     c05:	c3                   	ret    
     c06:	8d 76 00             	lea    0x0(%esi),%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c10:	89 df                	mov    %ebx,%edi
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c12:	89 f0                	mov    %esi,%eax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     c14:	c6 04 3e 00          	movb   $0x0,(%esi,%edi,1)
  return buf;
}
     c18:	83 c4 1c             	add    $0x1c,%esp
     c1b:	5b                   	pop    %ebx
     c1c:	5e                   	pop    %esi
     c1d:	5f                   	pop    %edi
     c1e:	5d                   	pop    %ebp
     c1f:	c3                   	ret    

00000c20 <stat>:

int
stat(char *n, struct statv6 *st)
{
     c20:	56                   	push   %esi
     c21:	53                   	push   %ebx
     c22:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c25:	6a 00                	push   $0x0
     c27:	ff 74 24 1c          	pushl  0x1c(%esp)
     c2b:	e8 e1 00 00 00       	call   d11 <open>
  if(fd < 0)
     c30:	83 c4 10             	add    $0x10,%esp
     c33:	85 c0                	test   %eax,%eax
     c35:	78 29                	js     c60 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c37:	83 ec 08             	sub    $0x8,%esp
     c3a:	89 c3                	mov    %eax,%ebx
     c3c:	ff 74 24 1c          	pushl  0x1c(%esp)
     c40:	50                   	push   %eax
     c41:	e8 e3 00 00 00       	call   d29 <fstat>
     c46:	89 c6                	mov    %eax,%esi
  close(fd);
     c48:	89 1c 24             	mov    %ebx,(%esp)
     c4b:	e8 a9 00 00 00       	call   cf9 <close>
  return r;
     c50:	83 c4 10             	add    $0x10,%esp
     c53:	89 f0                	mov    %esi,%eax
}
     c55:	83 c4 04             	add    $0x4,%esp
     c58:	5b                   	pop    %ebx
     c59:	5e                   	pop    %esi
     c5a:	c3                   	ret    
     c5b:	90                   	nop
     c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c65:	eb ee                	jmp    c55 <stat+0x35>
     c67:	89 f6                	mov    %esi,%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c70 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     c70:	53                   	push   %ebx
     c71:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c75:	0f be 11             	movsbl (%ecx),%edx
     c78:	8d 42 d0             	lea    -0x30(%edx),%eax
     c7b:	3c 09                	cmp    $0x9,%al
     c7d:	b8 00 00 00 00       	mov    $0x0,%eax
     c82:	77 19                	ja     c9d <atoi+0x2d>
     c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     c88:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c8b:	83 c1 01             	add    $0x1,%ecx
     c8e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c92:	0f be 11             	movsbl (%ecx),%edx
     c95:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c98:	80 fb 09             	cmp    $0x9,%bl
     c9b:	76 eb                	jbe    c88 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     c9d:	5b                   	pop    %ebx
     c9e:	c3                   	ret    
     c9f:	90                   	nop

00000ca0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ca0:	56                   	push   %esi
     ca1:	53                   	push   %ebx
     ca2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
     ca6:	8b 44 24 0c          	mov    0xc(%esp),%eax
     caa:	8b 74 24 10          	mov    0x10(%esp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cae:	85 db                	test   %ebx,%ebx
     cb0:	7e 14                	jle    cc6 <memmove+0x26>
     cb2:	31 d2                	xor    %edx,%edx
     cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     cb8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cbc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cbf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cc2:	39 da                	cmp    %ebx,%edx
     cc4:	75 f2                	jne    cb8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     cc6:	5b                   	pop    %ebx
     cc7:	5e                   	pop    %esi
     cc8:	c3                   	ret    

00000cc9 <fork>:
     cc9:	b8 01 00 00 00       	mov    $0x1,%eax
     cce:	cd 40                	int    $0x40
     cd0:	c3                   	ret    

00000cd1 <exit>:
     cd1:	b8 02 00 00 00       	mov    $0x2,%eax
     cd6:	cd 40                	int    $0x40
     cd8:	c3                   	ret    

00000cd9 <wait>:
     cd9:	b8 03 00 00 00       	mov    $0x3,%eax
     cde:	cd 40                	int    $0x40
     ce0:	c3                   	ret    

00000ce1 <pipe>:
     ce1:	b8 04 00 00 00       	mov    $0x4,%eax
     ce6:	cd 40                	int    $0x40
     ce8:	c3                   	ret    

00000ce9 <read>:
     ce9:	b8 06 00 00 00       	mov    $0x6,%eax
     cee:	cd 40                	int    $0x40
     cf0:	c3                   	ret    

00000cf1 <write>:
     cf1:	b8 05 00 00 00       	mov    $0x5,%eax
     cf6:	cd 40                	int    $0x40
     cf8:	c3                   	ret    

00000cf9 <close>:
     cf9:	b8 07 00 00 00       	mov    $0x7,%eax
     cfe:	cd 40                	int    $0x40
     d00:	c3                   	ret    

00000d01 <kill>:
     d01:	b8 08 00 00 00       	mov    $0x8,%eax
     d06:	cd 40                	int    $0x40
     d08:	c3                   	ret    

00000d09 <exec>:
     d09:	b8 09 00 00 00       	mov    $0x9,%eax
     d0e:	cd 40                	int    $0x40
     d10:	c3                   	ret    

00000d11 <open>:
     d11:	b8 0a 00 00 00       	mov    $0xa,%eax
     d16:	cd 40                	int    $0x40
     d18:	c3                   	ret    

00000d19 <mknod>:
     d19:	b8 0b 00 00 00       	mov    $0xb,%eax
     d1e:	cd 40                	int    $0x40
     d20:	c3                   	ret    

00000d21 <unlink>:
     d21:	b8 0c 00 00 00       	mov    $0xc,%eax
     d26:	cd 40                	int    $0x40
     d28:	c3                   	ret    

00000d29 <fstat>:
     d29:	b8 0d 00 00 00       	mov    $0xd,%eax
     d2e:	cd 40                	int    $0x40
     d30:	c3                   	ret    

00000d31 <link>:
     d31:	b8 0e 00 00 00       	mov    $0xe,%eax
     d36:	cd 40                	int    $0x40
     d38:	c3                   	ret    

00000d39 <mkdir>:
     d39:	b8 0f 00 00 00       	mov    $0xf,%eax
     d3e:	cd 40                	int    $0x40
     d40:	c3                   	ret    

00000d41 <chdir>:
     d41:	b8 10 00 00 00       	mov    $0x10,%eax
     d46:	cd 40                	int    $0x40
     d48:	c3                   	ret    

00000d49 <dup>:
     d49:	b8 11 00 00 00       	mov    $0x11,%eax
     d4e:	cd 40                	int    $0x40
     d50:	c3                   	ret    

00000d51 <getpid>:
     d51:	b8 12 00 00 00       	mov    $0x12,%eax
     d56:	cd 40                	int    $0x40
     d58:	c3                   	ret    

00000d59 <sbrk>:
     d59:	b8 13 00 00 00       	mov    $0x13,%eax
     d5e:	cd 40                	int    $0x40
     d60:	c3                   	ret    

00000d61 <sleep>:
     d61:	b8 14 00 00 00       	mov    $0x14,%eax
     d66:	cd 40                	int    $0x40
     d68:	c3                   	ret    
     d69:	66 90                	xchg   %ax,%ax
     d6b:	66 90                	xchg   %ax,%ax
     d6d:	66 90                	xchg   %ax,%ax
     d6f:	90                   	nop

00000d70 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d70:	55                   	push   %ebp
     d71:	57                   	push   %edi
     d72:	89 c7                	mov    %eax,%edi
     d74:	56                   	push   %esi
     d75:	53                   	push   %ebx
     d76:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d79:	8b 5c 24 50          	mov    0x50(%esp),%ebx
     d7d:	85 db                	test   %ebx,%ebx
     d7f:	74 77                	je     df8 <printint+0x88>
     d81:	89 d0                	mov    %edx,%eax
     d83:	c1 e8 1f             	shr    $0x1f,%eax
     d86:	84 c0                	test   %al,%al
     d88:	74 6e                	je     df8 <printint+0x88>
    neg = 1;
    x = -xx;
     d8a:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     d8c:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
     d93:	00 
    x = -xx;
     d94:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
     d96:	31 ed                	xor    %ebp,%ebp
     d98:	8d 5c 24 1f          	lea    0x1f(%esp),%ebx
     d9c:	eb 04                	jmp    da2 <printint+0x32>
     d9e:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
     da0:	89 f5                	mov    %esi,%ebp
     da2:	31 d2                	xor    %edx,%edx
     da4:	8d 75 01             	lea    0x1(%ebp),%esi
     da7:	f7 f1                	div    %ecx
     da9:	0f b6 92 28 12 00 00 	movzbl 0x1228(%edx),%edx
  }while((x /= base) != 0);
     db0:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     db2:	88 14 33             	mov    %dl,(%ebx,%esi,1)
  }while((x /= base) != 0);
     db5:	75 e9                	jne    da0 <printint+0x30>
  if(neg)
     db7:	8b 44 24 0c          	mov    0xc(%esp),%eax
     dbb:	85 c0                	test   %eax,%eax
     dbd:	74 08                	je     dc7 <printint+0x57>
    buf[i++] = '-';
     dbf:	c6 44 34 20 2d       	movb   $0x2d,0x20(%esp,%esi,1)
     dc4:	8d 75 02             	lea    0x2(%ebp),%esi
     dc7:	8d 74 34 1f          	lea    0x1f(%esp,%esi,1),%esi
     dcb:	90                   	nop
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dd0:	0f b6 06             	movzbl (%esi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     dd3:	83 ec 04             	sub    $0x4,%esp
     dd6:	83 ee 01             	sub    $0x1,%esi
     dd9:	88 44 24 23          	mov    %al,0x23(%esp)
     ddd:	6a 01                	push   $0x1
     ddf:	53                   	push   %ebx
     de0:	57                   	push   %edi
     de1:	e8 0b ff ff ff       	call   cf1 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     de6:	83 c4 10             	add    $0x10,%esp
     de9:	39 de                	cmp    %ebx,%esi
     deb:	75 e3                	jne    dd0 <printint+0x60>
    putc(fd, buf[i]);
}
     ded:	83 c4 3c             	add    $0x3c,%esp
     df0:	5b                   	pop    %ebx
     df1:	5e                   	pop    %esi
     df2:	5f                   	pop    %edi
     df3:	5d                   	pop    %ebp
     df4:	c3                   	ret    
     df5:	8d 76 00             	lea    0x0(%esi),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     df8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     dfa:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     e01:	00 
     e02:	eb 92                	jmp    d96 <printint+0x26>
     e04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e10 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e10:	55                   	push   %ebp
     e11:	57                   	push   %edi
     e12:	56                   	push   %esi
     e13:	53                   	push   %ebx
     e14:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e17:	8b 74 24 44          	mov    0x44(%esp),%esi
     e1b:	8d 44 24 48          	lea    0x48(%esp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     e1f:	8b 7c 24 40          	mov    0x40(%esp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e23:	89 44 24 0c          	mov    %eax,0xc(%esp)
     e27:	0f b6 1e             	movzbl (%esi),%ebx
     e2a:	83 c6 01             	add    $0x1,%esi
     e2d:	84 db                	test   %bl,%bl
     e2f:	0f 84 ad 00 00 00    	je     ee2 <printf+0xd2>
     e35:	31 ed                	xor    %ebp,%ebp
     e37:	eb 32                	jmp    e6b <printf+0x5b>
     e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e40:	83 f8 25             	cmp    $0x25,%eax
     e43:	0f 84 a7 00 00 00    	je     ef0 <printf+0xe0>
     e49:	88 5c 24 1a          	mov    %bl,0x1a(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e4d:	83 ec 04             	sub    $0x4,%esp
     e50:	6a 01                	push   $0x1
     e52:	8d 44 24 22          	lea    0x22(%esp),%eax
     e56:	50                   	push   %eax
     e57:	57                   	push   %edi
     e58:	e8 94 fe ff ff       	call   cf1 <write>
     e5d:	83 c4 10             	add    $0x10,%esp
     e60:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e63:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e67:	84 db                	test   %bl,%bl
     e69:	74 77                	je     ee2 <printf+0xd2>
    c = fmt[i] & 0xff;
    if(state == 0){
     e6b:	85 ed                	test   %ebp,%ebp
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
     e6d:	0f be cb             	movsbl %bl,%ecx
     e70:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e73:	74 cb                	je     e40 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e75:	83 fd 25             	cmp    $0x25,%ebp
     e78:	75 e6                	jne    e60 <printf+0x50>
      if(c == 'd'){
     e7a:	83 f8 64             	cmp    $0x64,%eax
     e7d:	0f 84 15 01 00 00    	je     f98 <printf+0x188>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e83:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e89:	83 f9 70             	cmp    $0x70,%ecx
     e8c:	74 72                	je     f00 <printf+0xf0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e8e:	83 f8 73             	cmp    $0x73,%eax
     e91:	0f 84 99 00 00 00    	je     f30 <printf+0x120>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e97:	83 f8 63             	cmp    $0x63,%eax
     e9a:	0f 84 07 01 00 00    	je     fa7 <printf+0x197>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ea0:	83 f8 25             	cmp    $0x25,%eax
     ea3:	0f 84 d7 00 00 00    	je     f80 <printf+0x170>
     ea9:	c6 44 24 1f 25       	movb   $0x25,0x1f(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     eae:	83 ec 04             	sub    $0x4,%esp
     eb1:	6a 01                	push   $0x1
     eb3:	8d 44 24 27          	lea    0x27(%esp),%eax
     eb7:	50                   	push   %eax
     eb8:	57                   	push   %edi
     eb9:	e8 33 fe ff ff       	call   cf1 <write>
     ebe:	88 5c 24 2e          	mov    %bl,0x2e(%esp)
     ec2:	83 c4 0c             	add    $0xc,%esp
     ec5:	6a 01                	push   $0x1
     ec7:	8d 44 24 26          	lea    0x26(%esp),%eax
     ecb:	50                   	push   %eax
     ecc:	57                   	push   %edi
     ecd:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     ed0:	31 ed                	xor    %ebp,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     ed2:	e8 1a fe ff ff       	call   cf1 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ed7:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     edb:	83 c4 10             	add    $0x10,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ede:	84 db                	test   %bl,%bl
     ee0:	75 89                	jne    e6b <printf+0x5b>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     ee2:	83 c4 2c             	add    $0x2c,%esp
     ee5:	5b                   	pop    %ebx
     ee6:	5e                   	pop    %esi
     ee7:	5f                   	pop    %edi
     ee8:	5d                   	pop    %ebp
     ee9:	c3                   	ret    
     eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     ef0:	bd 25 00 00 00       	mov    $0x25,%ebp
     ef5:	e9 66 ff ff ff       	jmp    e60 <printf+0x50>
     efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
     f00:	83 ec 0c             	sub    $0xc,%esp
     f03:	b9 10 00 00 00       	mov    $0x10,%ecx
     f08:	6a 00                	push   $0x0
     f0a:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
     f0e:	89 f8                	mov    %edi,%eax
     f10:	8b 13                	mov    (%ebx),%edx
     f12:	e8 59 fe ff ff       	call   d70 <printint>
        ap++;
     f17:	89 d8                	mov    %ebx,%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f19:	31 ed                	xor    %ebp,%ebp
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
     f1b:	83 c0 04             	add    $0x4,%eax
     f1e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
     f22:	83 c4 10             	add    $0x10,%esp
     f25:	e9 36 ff ff ff       	jmp    e60 <printf+0x50>
     f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else if(c == 's'){
        s = (char*)*ap;
     f30:	8b 44 24 0c          	mov    0xc(%esp),%eax
     f34:	8b 28                	mov    (%eax),%ebp
        ap++;
     f36:	83 c0 04             	add    $0x4,%eax
     f39:	89 44 24 0c          	mov    %eax,0xc(%esp)
        if(s == 0)
          s = "(null)";
     f3d:	b8 20 12 00 00       	mov    $0x1220,%eax
     f42:	85 ed                	test   %ebp,%ebp
     f44:	0f 44 e8             	cmove  %eax,%ebp
        while(*s != 0){
     f47:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
     f4b:	84 c0                	test   %al,%al
     f4d:	74 27                	je     f76 <printf+0x166>
     f4f:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
     f53:	90                   	nop
     f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f58:	88 44 24 1b          	mov    %al,0x1b(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f5c:	83 ec 04             	sub    $0x4,%esp
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
     f5f:	83 c5 01             	add    $0x1,%ebp
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f62:	6a 01                	push   $0x1
     f64:	53                   	push   %ebx
     f65:	57                   	push   %edi
     f66:	e8 86 fd ff ff       	call   cf1 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f6b:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
     f6f:	83 c4 10             	add    $0x10,%esp
     f72:	84 c0                	test   %al,%al
     f74:	75 e2                	jne    f58 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f76:	31 ed                	xor    %ebp,%ebp
     f78:	e9 e3 fe ff ff       	jmp    e60 <printf+0x50>
     f7d:	8d 76 00             	lea    0x0(%esi),%esi
     f80:	88 5c 24 1d          	mov    %bl,0x1d(%esp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f84:	83 ec 04             	sub    $0x4,%esp
     f87:	6a 01                	push   $0x1
     f89:	8d 44 24 25          	lea    0x25(%esp),%eax
     f8d:	e9 39 ff ff ff       	jmp    ecb <printf+0xbb>
     f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
     f98:	83 ec 0c             	sub    $0xc,%esp
     f9b:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fa0:	6a 01                	push   $0x1
     fa2:	e9 63 ff ff ff       	jmp    f0a <printf+0xfa>
     fa7:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     fab:	83 ec 04             	sub    $0x4,%esp
     fae:	8b 03                	mov    (%ebx),%eax
     fb0:	88 44 24 20          	mov    %al,0x20(%esp)
     fb4:	6a 01                	push   $0x1
     fb6:	8d 44 24 24          	lea    0x24(%esp),%eax
     fba:	50                   	push   %eax
     fbb:	57                   	push   %edi
     fbc:	e8 30 fd ff ff       	call   cf1 <write>
     fc1:	e9 51 ff ff ff       	jmp    f17 <printf+0x107>
     fc6:	66 90                	xchg   %ax,%ax
     fc8:	66 90                	xchg   %ax,%ax
     fca:	66 90                	xchg   %ax,%ax
     fcc:	66 90                	xchg   %ax,%ax
     fce:	66 90                	xchg   %ax,%ax

00000fd0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fd0:	57                   	push   %edi
     fd1:	56                   	push   %esi
     fd2:	53                   	push   %ebx
     fd3:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd7:	a1 84 1c 00 00       	mov    0x1c84,%eax
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
     fdc:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fdf:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fe1:	39 c8                	cmp    %ecx,%eax
     fe3:	73 13                	jae    ff8 <free+0x28>
     fe5:	8d 76 00             	lea    0x0(%esi),%esi
     fe8:	39 d1                	cmp    %edx,%ecx
     fea:	72 14                	jb     1000 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fec:	39 d0                	cmp    %edx,%eax
     fee:	73 10                	jae    1000 <free+0x30>
static Header base;
static Header *freep;

void
free(void *ap)
{
     ff0:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ff2:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ff4:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ff6:	72 f0                	jb     fe8 <free+0x18>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ff8:	39 d0                	cmp    %edx,%eax
     ffa:	72 f4                	jb     ff0 <free+0x20>
     ffc:	39 d1                	cmp    %edx,%ecx
     ffe:	73 f0                	jae    ff0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1000:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1003:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1006:	39 d7                	cmp    %edx,%edi
    1008:	74 18                	je     1022 <free+0x52>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    100a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    100d:	8b 50 04             	mov    0x4(%eax),%edx
    1010:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1013:	39 f1                	cmp    %esi,%ecx
    1015:	74 20                	je     1037 <free+0x67>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1017:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1019:	a3 84 1c 00 00       	mov    %eax,0x1c84
}
    101e:	5b                   	pop    %ebx
    101f:	5e                   	pop    %esi
    1020:	5f                   	pop    %edi
    1021:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1022:	03 72 04             	add    0x4(%edx),%esi
    1025:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1028:	8b 12                	mov    (%edx),%edx
    102a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    102d:	8b 50 04             	mov    0x4(%eax),%edx
    1030:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1033:	39 f1                	cmp    %esi,%ecx
    1035:	75 e0                	jne    1017 <free+0x47>
    p->s.size += bp->s.size;
    1037:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    103a:	a3 84 1c 00 00       	mov    %eax,0x1c84
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    103f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1042:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1045:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1047:	5b                   	pop    %ebx
    1048:	5e                   	pop    %esi
    1049:	5f                   	pop    %edi
    104a:	c3                   	ret    
    104b:	90                   	nop
    104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001050 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1050:	57                   	push   %edi
    1051:	56                   	push   %esi
    1052:	53                   	push   %ebx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1053:	8b 44 24 10          	mov    0x10(%esp),%eax
  if((prevp = freep) == 0){
    1057:	8b 15 84 1c 00 00    	mov    0x1c84,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    105d:	8d 78 07             	lea    0x7(%eax),%edi
    1060:	c1 ef 03             	shr    $0x3,%edi
    1063:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1066:	85 d2                	test   %edx,%edx
    1068:	0f 84 a0 00 00 00    	je     110e <malloc+0xbe>
    106e:	8b 02                	mov    (%edx),%eax
    1070:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1073:	39 cf                	cmp    %ecx,%edi
    1075:	76 71                	jbe    10e8 <malloc+0x98>
    1077:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    107d:	be 00 10 00 00       	mov    $0x1000,%esi
    1082:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    1089:	0f 43 f7             	cmovae %edi,%esi
    108c:	ba 00 80 00 00       	mov    $0x8000,%edx
    1091:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    1097:	0f 46 da             	cmovbe %edx,%ebx
    109a:	eb 0d                	jmp    10a9 <malloc+0x59>
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    10a2:	8b 48 04             	mov    0x4(%eax),%ecx
    10a5:	39 cf                	cmp    %ecx,%edi
    10a7:	76 3f                	jbe    10e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
    10a9:	39 05 84 1c 00 00    	cmp    %eax,0x1c84
    10af:	89 c2                	mov    %eax,%edx
    10b1:	75 ed                	jne    10a0 <malloc+0x50>
  char *p;
  Header *hp;

  if(nu < PAGE)
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    10b3:	83 ec 0c             	sub    $0xc,%esp
    10b6:	53                   	push   %ebx
    10b7:	e8 9d fc ff ff       	call   d59 <sbrk>
  if(p == (char*) -1)
    10bc:	83 c4 10             	add    $0x10,%esp
    10bf:	83 f8 ff             	cmp    $0xffffffff,%eax
    10c2:	74 1c                	je     10e0 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    10c4:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    10c7:	83 ec 0c             	sub    $0xc,%esp
    10ca:	83 c0 08             	add    $0x8,%eax
    10cd:	50                   	push   %eax
    10ce:	e8 fd fe ff ff       	call   fd0 <free>
  return freep;
    10d3:	8b 15 84 1c 00 00    	mov    0x1c84,%edx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    10d9:	83 c4 10             	add    $0x10,%esp
    10dc:	85 d2                	test   %edx,%edx
    10de:	75 c0                	jne    10a0 <malloc+0x50>
        return 0;
    10e0:	31 c0                	xor    %eax,%eax
    10e2:	eb 1c                	jmp    1100 <malloc+0xb0>
    10e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    10e8:	39 cf                	cmp    %ecx,%edi
    10ea:	74 1c                	je     1108 <malloc+0xb8>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    10ec:	29 f9                	sub    %edi,%ecx
    10ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10f4:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    10f7:	89 15 84 1c 00 00    	mov    %edx,0x1c84
      return (void*) (p + 1);
    10fd:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1100:	5b                   	pop    %ebx
    1101:	5e                   	pop    %esi
    1102:	5f                   	pop    %edi
    1103:	c3                   	ret    
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1108:	8b 08                	mov    (%eax),%ecx
    110a:	89 0a                	mov    %ecx,(%edx)
    110c:	eb e9                	jmp    10f7 <malloc+0xa7>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    110e:	c7 05 84 1c 00 00 88 	movl   $0x1c88,0x1c84
    1115:	1c 00 00 
    1118:	c7 05 88 1c 00 00 88 	movl   $0x1c88,0x1c88
    111f:	1c 00 00 
    base.s.size = 0;
    1122:	b8 88 1c 00 00       	mov    $0x1c88,%eax
    1127:	c7 05 8c 1c 00 00 00 	movl   $0x0,0x1c8c
    112e:	00 00 00 
    1131:	e9 41 ff ff ff       	jmp    1077 <malloc+0x27>
