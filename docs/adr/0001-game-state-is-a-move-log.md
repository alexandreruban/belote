# Game state is a Move log replayed by a pure rules core

A Game stores only what can't be recomputed: its Seats, each Deal's 32-card deck order, and every Move in order. Everything a Player sees (hands, Trump, Tricks, Scores, the winner) is computed on each request by replaying the Moves through a plain-Ruby rules core that uses no database, randomness or clock. We chose this so the rules code, and later a variant such as coinche, can change shape without migrating stored Games: what's stored is the Moves that went in, never the state that came out.

## Considered Options

- **Snapshot of the state** (one JSON column rewritten on every Move): the same rules core, but it needs a serializer for the whole state, kept in step with it, and stored states must be migrated whenever the state's shape changes.
- **One table per concept** (Deals, Tricks, hands, card plays): the same fact lives in several rows that must agree, the rules end up spread over models, and every rules test needs a database.

## Consequences

- A shuffle is stored as the deck order, never a seed: a seed's output depends on Ruby's RNG and `Array#shuffle`, which can change between Ruby versions.
- Replay applies stored Moves without re-checking their legality, so a rules fix can't make a stored Game unreadable. It can change how an in-progress Game replays; we accept that.
- The only computed fact that is stored is when a Game ended, so "the User's Game in progress" is a query. Other caches wait until replay is measured to be slow.
- A Game's version is its latest Move's number.
