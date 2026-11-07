#![cfg(feature = "datom")]
#![allow(dead_code)]
// The reader budget a scenario hands the codec, built the way this crate's
// pinned protos builds it.

pub fn reader_budget(remaining: usize) -> protos::ReaderBudget {
    protos::ReaderBudget { remaining }
}
