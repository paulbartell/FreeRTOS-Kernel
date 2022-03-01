// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

/*
 * Insert copyright notice
 */

/**
 * @file pvPortMalloc_harness.c
 * @brief Implements the proof harness for pvPortMalloc function.
 */

/*
 * Insert project header files that
 *   - include the declaration of the function
 *   - include the types needed to declare function arguments
 */

#include <stddef.h>

#include "FreeRTOSConfig.h"

void *pvPortMalloc(size_t size);

void harness()
{
  void *ptr1,*ptr2,*ptr3,*ptr4,*ptr5;
  size_t size1,size2,size3,size4,size5;

  __CPROVER_assume(size4 < configTOTAL_HEAP_SIZE/4);
  __CPROVER_assume(size1 < size2);
  __CPROVER_assume(size2 < size3);
  __CPROVER_assume(size3 < size4);
  __CPROVER_assume(size5 < size4);
  __CPROVER_assume(size5 > size3);
  
//  __CPROVER_assume(size1+size2+size3+size4 == configTOTAL_HEAP_SIZE/2);

   ptr1 = pvPortMalloc(size1);
   xPortFree(ptr1);
   ptr2 = pvPortMalloc(size2);
   xPortFree(ptr2);
   ptr3 = pvPortMalloc(size3);
   xPortFree(ptr3);
   ptr4 = pvPortMalloc(size4);
   xPortFree(ptr4);

   ptr5 = pvPortMalloc(size5);

}
