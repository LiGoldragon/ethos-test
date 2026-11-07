#![cfg(feature = "datom")]
#![allow(dead_code)]
// RETAINED, NEVER UPGRADED: this crate keeps the held set's original protos
// pin on purpose, so its fixture builds ReaderBudget by its public field,
// the API that pin has. Do not move it to a newer protos.

pub fn reader_budget(remaining: usize) -> protos::ReaderBudget {
    protos::ReaderBudget { remaining }
}
