#![no_std]
#![no_main]
#![feature(custom_test_frameworks)]
#![test_runner(RustKernel::test_runner)]
#![reexport_test_harness_main = "test_main"]

use RustKernel::println;
use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    println!("Hello from RustKernel{}", "!");

    RustKernel::init();

    #[cfg(test)]
    test_main();

    println!("It did not crash!");
    RustKernel::hlt_loop();
}

/// This function is called on panic.
#[cfg(not(test))]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    println!("{}", info);
    RustKernel::hlt_loop();
}

#[cfg(test)]
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    RustKernel::test_panic_handler(info)
}

#[test_case]
fn trivial_assertion() {
    assert_eq!(1, 1);
}