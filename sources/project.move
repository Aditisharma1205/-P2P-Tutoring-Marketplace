module MyModule::TutoringMarketplace {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct Tutor has store, key {
        price_per_session: u64,
    }

    /// Function to register a tutor with a price per session.
    public fun register_tutor(owner: &signer, price: u64) {
        let tutor = Tutor {
            price_per_session: price,
        };
        move_to(owner, tutor);
    }

    /// Function for a student to book a session with a tutor by paying the price.
    public fun book_session(student: &signer, tutor_address: address) acquires Tutor {
        let tutor = borrow_global<Tutor>(tutor_address);
        let payment = coin::withdraw<AptosCoin>(student, tutor.price_per_session);
        coin::deposit<AptosCoin>(tutor_address, payment);
    }
}

