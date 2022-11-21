.global process_data

#; Input:
#; rdx --> int *borders_array
#; rcx --> int borders_number
#; rax --> int number
#; Output:
#; rax --> int interval_index + 1
#; rax = 0 --> not in interval
find_interval_index:
  push rdi

find_interval_index_loop:
  mov  edi, [rdx + rcx * 4 - 4]
  cmp  eax, edi
  jge  find_interval_index_end
  loop find_interval_index_loop
  xor  rax, rax

find_interval_index_end:
  mov  rax, rcx

  pop  rdi
  ret

#; rdi --> int *result_array  (qword)
#; rsi --> int *source_array  (qword)
#; rdx --> int *borders_array (qword)
#; rcx --> int count          (dword)
#; r8  --> int borders_number (dword)
process_data:
  push rax

process_data_loop:
  lodsd

  push rcx
  mov  rcx, r8
  call find_interval_index
  pop  rcx

  inc dword ptr [rdi + rax * 4 - 4]
  loop process_data_loop

  pop  rax
	ret