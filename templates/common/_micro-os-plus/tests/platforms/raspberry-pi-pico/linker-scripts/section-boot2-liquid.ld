/*
 * DO NOT EDIT! Automatically generated from template file:
 * {{fromFilePath}}
 */

SECTIONS
{
  /* ----------------------------------------------------------------------- */

  /* 
   * For Raspberry Pi Pico, the second stage bootloader must be prepended 
   * to the image. It must be 256 bytes big and checksummed. It is usually 
   * built by the boot_stage2 target in the Raspberry Pi Pico SDK
   */

  .boot2 : 
  {
      __boot2_start__ = .;
      KEEP (*(.boot2))
      __boot2_end__ = .;
  } > FLASH

  ASSERT(__boot2_end__ - __boot2_start__ == 256,
      "ERROR: Pico second stage bootloader must be 256 bytes in size")

  /* ----------------------------------------------------------------------- */
}
