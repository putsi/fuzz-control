<?php
$fuzz_string = file_get_contents('php://stdin');

/*
   Test cases stolen from: https://www.evonide.com/fuzzing-unserialize/#Test_Cases
*/

// Test Case 1 - Unserialize only
// This test case does nothing but unserializing the provided serialized string.
unserialize($fuzz_string);

// Test Case 2 - Unserialize var_dump
// Here, the string is unserialized and every value in the result is accessed and printed via var_dump.
var_dump(unserialize($fuzz_string));

// Test Case 3 - Unserialize unserialize var_dump
// A second unserialize has been added. Its purpose is to increase the amount of memory operations after the initial unserialize.
var_dump(unserialize(unserialize($fuzz_string)));

// Test Case 4 - Unserialize alloc var_dump
// Here, the string is unserialized, some fix values are assigned to variables and finally the result of unserialize is printed.
$array = unserialize($fuzz_string);
gc_collect_cycles();
$filler1 = "aaaa";
$filler2 = "bbbb";
var_dump($array);
