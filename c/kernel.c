void main(void) {
  // point to first text cell of video memory
  char *video_memory = (char *)0xb8000;

  // store 'X' at address pointed by video_memory
  *video_memory = 'A';
}
