struct devsw {
  int (*read)(struct inode*, char*, int);
  int (*write)(struct inode*, char*, int);

  int (*ioctl)(struct inode*, int request, void* argp);
};

extern struct devsw devsw[];

#define CONSOLE 1
