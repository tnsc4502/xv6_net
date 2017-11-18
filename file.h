struct file {
  enum { FD_NONE, FD_PIPE, FD_INODE } type;
  int ref; // reference count
  char readable;
  char writable;
  struct pipe *pipe;
  struct inode *ip;
  uint off;
};


// in-core file system types

/*struct inode {
  uint dev;           // Device number
  uint inum;          // Inode number
  int ref;            // Reference count
  int flags;          // I_BUSY, I_VALID

  short type;         // copy of disk inode
  short major;
  short minor;
  short nlink;
  uint size;
  uint addrs[12+1];
};*/

#define I_BUSY 0x1
#define I_VALID 0x2


// device implementations

/*struct devsw {
  int (*read)(struct inode*, char*, int);
  int (*write)(struct inode*, char*, int);
  // traditionally, 3rd argument type is 'char*', but use 'void*' in this time.
  int (*ioctl)(struct inode*, int request, void* argp);
};*/

//extern struct devsw devsw[];

#define CONSOLE 1
#define ETHERNET 2         // Major
#define ETHERNET_NO(n) n   // Miner >= 0

