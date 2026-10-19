# Standard belote rules and house-rule variations

Research for [Standard belote rules and house-rule variations](https://github.com/alexandreruban/belote/issues/6). It feeds two decision tickets: [Dealing, trump and legal card plays](https://github.com/alexandreruban/belote/issues/7) and [Deal scoring and Game end](https://github.com/alexandreruban/belote/issues/8).

**Question.** What are the standard rules of classic belote ("à la retourne", four Players in two Teams), and where do common house rules differ?

**Scope.** Classic belote only. Coinche/contrée and sans-atout/tout-atout are out of scope. They come up below only where a source mixes them in.

**Vocabulary.** The glossary terms are User, Player, Team, Lobby, Game, Deal and Trick. Belote words with no English equivalent stay French (Belote/Rebelote, dix de der, capot, dedans, litige). This note also uses some terms that `GLOSSARY.md` does not have yet; they are candidates for `/domain-modeling`:

- **dealer**: the Player who deals this Deal.
- **turned card**: *la retourne*, the card turned face up after the first packets.
- **trump-choosing round**: *tour de prise*. There are at most two per Deal.
- **taker** (*preneur*), **taking Team** and **defending Team**.
- **announcement**: *annonce*.
- **partner is winning**: *le partenaire est maître*, meaning the partner's card currently wins the Trick.

## How each rule point is laid out

Each point has three parts:

- **Standard rule**: the most common rule. It is the Fédération Française de Belote (FFB) text unless that text is itself the minority practice, which is said explicitly.
- **Common variations**: the alternatives actually seen in practice, each with its source.
- **Sources**: the source tags (see the [source list](#sources) at the end).

The variation points are gathered at the end under [Variation points to decide](#variation-points-to-decide).

## Sources and how much to trust them

Classic belote is a public-domain folk game, so no source has legal authority over it. Sources are ranked by how close they come to being a primary authority.

1. **Federation texts (highest trust).** These are the official rules of the Fédération Française de Belote, a private association that sanctions tournaments.
   - [FFB-2016]: its versioned rulebook, *Règles officielles de belote*, dated 27 January 2016. It is the latest dated version the site links to.
   - [FFB-RA]: its web regulation *avec ou sans annonce*, which adds announcements.
   - [FFB-R]: its rules summary page.
   - [FFB-PC]: its key-points sheet for tournament organisers.

   The four do not agree on every detail, and the disagreements are flagged where they occur.
2. **Established rulebook references.**
   - [PAGAT]: the Pagat.com belote page by J.-P. Coulon, edited by John McLeod. It is the standard English-language card-game reference and lists variations explicitly.
   - [UNIV]: the *Encyclopædia Universalis* entry by the game historian Thierry Depaulis.
   - [CARTA]: the rules leaflet from the card maker Cartamundi (France Cartes), in its "La belote classique" section.
3. **Organised-play evidence.** These are local tournament regulations, which show the house rules real clubs write down: [GM33], [MIOS], [GM53] and [PDC].
4. **Online implementation.**
   - [BGA]: the Board Game Arena belote help. It shows which rules an online table turns into options.
5. **Secondary sources, used only to catalogue variations.**
   - [WFR]: French Wikipedia, *Belote*. The page is flagged *à sourcer* (needs sources).
   - [WEN]: English Wikipedia.

Some print sources were not consulted because they are offline: R. Lewy and B. Lefebvre, *La Fédération française de belote présente : La Belote* (Hatier, 1985), and the 1984 *Jeux et Stratégie* no. 27 article "La belote et ses règles officielles".

---

## 1. Deck, Teams and seating

**Standard rule.**

- The deck has 32 cards: 7, 8, 9, 10, Jack, Queen, King and Ace in each of the four suits (spades, hearts, diamonds, clubs).
- There are four Players in two Teams. Partners sit opposite each other (North/South against East/West).

**Common variations.** None for the four-Player game.

**Sources.** [FFB-2016 §2], [PAGAT], [UNIV].

## 2. Card ranks and points

**Standard rule.** Ranks and points depend on whether the suit is trump. They are listed here high to low:

| Rank in trump | Points | Rank outside trump | Points |
|---|---|---|---|
| Jack | 20 | Ace | 11 |
| 9 | 14 | 10 | 10 |
| Ace | 11 | King | 4 |
| 10 | 10 | Queen | 3 |
| King | 4 | Jack | 2 |
| Queen | 3 | 9 | 0 |
| 8 | 0 | 8 | 0 |
| 7 | 0 | 7 | 0 |

- The trump suit holds 62 points and each other suit holds 30, so the cards total 152.
- The dix de der adds 10, making 162 per Deal.
- Any trump beats any card of another suit.

**Common variations.** None in classic belote. The only differing card values belong to sans-atout and tout-atout, which are out of scope.

**Sources.** [FFB-2016 §6], [FFB-RA §III], [PAGAT], [WFR].

## 3. Direction of play

**Standard rule.** Dealing, trump choosing and play all go **anticlockwise**. The "next" Player is therefore the one on the dealer's **right**.

**Common variations.**

- Many people play **clockwise**:
  - [PAGAT] says "people often play the whole game clockwise".
  - [BGA] offers it as a table option.
  - Two local tournaments mandate it: [PDC art. 8] and [GM53 §5].
  - The [CARTA] leaflet's introduction uses it.

  Everything else is mirrored. In this note, "right" means "next in rotation".

**Sources.** [FFB-2016 §3.4, §5.1], [FFB-RA §IV.C], [PAGAT], [WFR], [GM33 art. 2], [MIOS art. 3].

## 4. Shuffle, cut and first dealer

**Standard rule (FFB).**

- The first dealer is chosen by a draw: the lowest card deals.
- The pack must be shuffled before **every** Deal.
- The Player on the dealer's left cuts. Each packet must keep at least 3 cards.

**Common variations.**

- **Traditional practice is no shuffle.** [PAGAT] says "the pack is never shuffled at Belote". [WFR] says cards are shuffled only at the start of the Game, then only cut, so Players can remember the previous Deal's Tricks. [GM53 §5] forbids shuffling outright.
- The FFB made shuffling mandatory to stop cheating. It says so explicitly in [FFB-RA §IV.A].
- [WFR] gives a 4-card minimum for each packet of the cut.

In an online Game the realistic choice is between two options:

- a fresh random shuffle each Deal;
- simulating the tradition: gather the Tricks in order, then apply a random cut.

**Sources.** [FFB-2016 §3.1–3.3], [FFB-RA §IV], [PAGAT], [WFR], [GM53].

## 5. Dealing: packet sizes and the turned card

**Standard rule.**

1. The dealer gives each Player **5 cards**. Dealing starts with the Player on the dealer's right, in packets of **3 then 2** or **2 then 3**; the FFB allows either.
2. The dealer then turns the top card of the remaining 12 face up. This is the turned card.
3. Once someone takes:
   - the taker receives the turned card plus **2** more cards;
   - every other Player receives **3** cards.

   This dealing also starts with the Player on the dealer's right, who is not necessarily the taker.
4. Everyone ends with 8 cards.

**Common variations.**

- [PAGAT] gives 3 then 2 as the norm and notes that some let the dealer choose 2 then 3. The FFB allows both.
- The "Annemasse" form alternates packets of 3 and 2 within one pass around the table [WFR].
- In an online Game, packet sizes are invisible except through card order, so they matter only if the tradition of no shuffling is simulated.

**Sources.** [FFB-2016 §3.4–3.5], [FFB-RA §IV.C], [FFB-R], [PAGAT], [UNIV], [WFR].

## 6. First trump-choosing round

**Standard rule.**

- The Player on the dealer's right speaks first, and the turn passes around the table.
- Each Player either **passes** or **takes**. Taking makes the turned card's suit trump.
- The first take ends trump choosing. There is no overbidding, which is what distinguishes classic belote from coinche.
- The taker receives the turned card and the deal resumes (§5).

**Common variations.**

- **"Valet forcé"** (Belgium): if the turned card is a Jack, the first Player to speak must take [WFR]. This is a secondary source only and rare.
- The FFB fixes the spoken formulas ("je passe", "je prends", and "deux" for passing in the second round). This does not apply online.

**Sources.** [FFB-2016 §4.1], [FFB-RA §V.A–B], [FFB-R], [PAGAT].

## 7. Second trump-choosing round

**Standard rule.**

- This round happens only if all four Players pass the first one. It uses the same speaking order.
- Each Player may pass or name **one of the three other suits** as trump.
- The first Player to name a suit is the taker. The taker **still receives the turned card**, even though it is not trump.

**Common variations.**

- **Any suit, including the turned card's suit, may be named.** Several sources word the second round as a free choice:
  - [FFB-2016 §4.2] lists all four suit names as the allowed words.
  - [UNIV] says "choisir l'atout librement".
  - [CARTA] says "proposer une couleur".

  The FFB's own web pages and [PAGAT] restrict the choice to the other three suits.
- The **dealer may pick any suit**, including the turned card's suit [WEN, secondary].

**Sources.** [FFB-RA §V.B], [FFB-R], [FFB-2016 §4.2], [PAGAT], [UNIV], [WFR], [WEN].

## 8. Nobody takes: the redeal

**Standard rule.**

- If all four Players pass in both trump-choosing rounds, the Deal ends unplayed.
- The cards are gathered and the **next Player in rotation deals**. That is the Player on the dealer's right.
- In a Game limited to a fixed number of Deals, the passed Deal does not count toward the limit.

**Common variations.**

- **The same dealer redeals** until someone takes. This is mandated by [PDC art. 10] and [GM53 §5]. [CARTA] only says "on recoupe et on redistribue", which could be read either way.
- **"La vache"**: if nobody takes in the second round, the dealer must choose a trump [WFR, secondary].
- **Fringe redeal triggers**, which are not FFB rules:
  - a Player with fewer than 11 points of cards and no trump may annul the Deal;
  - a carré of 7s annuls the Deal.

  Both come from [WFR]. [FFB-2016] explicitly declares "le carré de 7 annule la donne" void.

**Sources.** [FFB-2016 §4.2, §10.4.1], [FFB-RA §V.B], [FFB-R], [PAGAT], [BGA], [GM33 art. 8].

## 9. Who deals next

**Standard rule.**

- The deal passes **one Player in rotation** after every Deal, including a passed one. That Player is on the dealer's right.
- The first Trick of each Deal is led by the Player on the dealer's right, **not** by the taker.
- The winner of each Trick leads the next.

**Common variations.**

- **Clockwise play** moves the deal to the left (§3). [CARTA] says that whoever led first deals next.
- **Same dealer after a passed Deal** (§8).

**Sources.** [FFB-2016 §4.2, §5.1], [FFB-RA §VI], [WFR], [PAGAT].

## 10. Legal card plays

**Standard rule (FFB).** Apply these checks in order:

1. **Follow suit.** A Player who holds the led suit must play it.
2. **Trump led.** The Player must play a trump and **beat the highest trump already in the Trick if able** ("monter"). This applies whoever is winning, **including the partner**. A Player who cannot beat it plays any trump. A Player with no trump may play any card.
3. **Void in a non-trump led suit, partner is winning.** The Player may play **any card**: discard, or trump if they wish.
4. **Void in a non-trump led suit, partner not winning or not yet played.** The Player **must trump** if able ("couper"). With no trump, they may play any card ("se défausser").
5. **An opponent has trumped and holds the Trick.** A Player who has to trump must **overtrump** if able ("surcouper"). If unable, they must still play a lower trump ("pisser"). Undertrumping an opponent is compulsory.
6. **The partner has trumped and holds the Trick.** Rule 3 applies: the Player is not obliged to trump. [FFB-2016 §5.2 2.3] says the Player may play any card "sans exception (y compris un atout inférieur au sien)".

Summary in French: *fournir; sinon couper, sauf si le partenaire est maître; à l'atout, toujours monter si possible.*

**Common variations.**

- **Voluntarily trumping on a partner's winning trump.** The FFB lets the Player play any card, including a *lower* trump. [PAGAT] lets them discard or overtrump, and allows a lower trump only when they cannot overtrump. Pagat's general rule is "whenever playing a trump you must beat the highest trump in the trick if possible".
  - [WFR] states both readings in different paragraphs.
  - This is a real fork for the rules engine.
- **Undertrumping a partner is compulsory.** In Pagat's "Tarot-influenced" variant, *"on est toujours obligé de pisser"*:
  - a Player who cannot overtrump must undertrump, and may not discard;
  - a Player who can overtrump may overtrump or discard, but not undertrump.

  The regular rule is *"on ne pisse pas sur le partenaire"* [PAGAT].
- **No compulsory undertrumping.** A Player who cannot overtrump an opponent may discard instead of playing a lower trump [WFR].
- **No source was found that relaxes rule 2** ("monter" on a trump lead, even over the partner). Tournaments restate it [PDC art. 13], so it is not a real variation point.
- In over-the-table play, an illegal play found later costs 162 points [FFB-RA §VIII.B], [PDC art. 12]. That does not apply here, because the server rejects illegal plays.

**Sources.** [FFB-2016 §5.2], [FFB-RA §VI], [FFB-R], [PAGAT], [WFR], [BGA], [GM53 §7], [PDC art. 13–14].

## 11. Belote/Rebelote

**Standard rule.**

- The King and Queen of trump held by the same Player score **20** points for that Player's Team.
- The Player says "Belote" on playing the first of the two and "Rebelote" on playing the second. Either card may come first.
- Belote is **imprenable**: it scores for the Team that announced it even when that Team is dedans or capot.
- It **counts toward the contract comparison** (§15).
- It scores regardless of other announcements.

**Common variations.**

- **The King must be played first**, or the 20 points are lost. This is mandated by three local tournaments, [GM33 art. 5], [MIOS art. 4] and [GM53 §6], and listed as a variation by [PAGAT]. [WFR] says Belgian tournaments use it and calls it the "official and original" rule, which contradicts [FFB-2016 §7] ("indifféremment la Dame ou le Roi").
- **Whether "Rebelote" must be said:**
  - [FFB-2016 §7]: both words are required, or the 20 points are lost.
  - [FFB-R]: "Rebelote" is optional.
  - [FFB-RA §VII.A]: forgetting "Rebelote" is tolerated once per Team per Game.

  Online, the choice is between the Player declaring it and the server detecting it.
- **Belote is "prenable".** If the taking Team announced Belote and is dedans, the 20 points go to the defenders, who score 182. If the Team is capot, its opponents score 272 [MIOS art. 4], [WFR].
- **Belote excluded from the contract comparison** ("les annonces ne servent pas à prendre") [WFR], [PAGAT].

**Sources.** [FFB-2016 §7, §10.1–10.2], [FFB-RA §VII.A], [FFB-R], [PAGAT], [WFR], [BGA], [GM33], [MIOS], [GM53], [PDC art. 5, 16].

## 12. Announcements (tierce, cinquante, cent, carré)

**Standard rule (FFB, tournaments and online).** **No announcements other than Belote/Rebelote.** [FFB-2016 §8] says "La belote classique se joue sans annonces". Its closing note adds that "carré", "cent", "cinquante" and "tierce" "ne font pas partie de la belote classique". Tournaments also play without them [PAGAT], [PDC art. 5], [GM53 §6], [MIOS art. 4]. [BGA] has none.

**Common variations.** The main variation is to **play with announcements**. Traditional home play does: [PAGAT] treats them as part of the game, and [FFB-RA] defines them as an option. If they are played, these sub-rules apply.

- **Values:**
  - tierce (3 in sequence): 20;
  - cinquante (4 in sequence): 50;
  - cent (5 or more in sequence): 100;
  - carré of Jacks: 200;
  - carré of 9s: 150;
  - carré of Aces, 10s, Kings or Queens: 100;
  - carrés of 8s and 7s: 0.

  Sources: [FFB-RA §VII.A], [PAGAT], [UNIV].
  - A tierce worth 30 [WFR].
  - A carré of Aces worth 110 and of 9s worth 140 [WFR].
  - A carré of 8s cancels all announcements; a carré of 7s cancels the Deal [WFR]. [FFB-2016] declares the carré-of-7s rule void.
- **Sequence order** is A, K, Q, J, 10, 9, 8, 7 [PAGAT], [FFB-RA]. [WFR] lists an odd variant order.
- **Longer sequences.** Six or more cards count as one cent [PAGAT]. [WFR] says a longer cent beats a shorter one.
- **One card in two announcements.** Not allowed, except with Belote [FFB-RA], [PAGAT]. Allowed [WFR main text].
- **When to declare:**
  - each Player names the announcement while playing a card to the first Trick;
  - the cards are shown at the second Trick [FFB-RA §VII.B–C], or once the first Trick is gathered [PAGAT], [WFR].

  [PAGAT] notes that "most players" now show them as soon as they notice them. [WFR] notes that a Player may choose not to declare. Online, the choice is between automatic detection and an opt-in declaration.
- **Comparison.** Only the Team holding the single best announcement scores, and it scores **all** of its announcements. Belote is separate.
  1. A carré beats any sequence. "Un carré de 100 points est plus fort qu'un cent."
  2. Otherwise, higher value wins.
  3. At equal value, the higher top card wins.
  4. Then a trump sequence wins.
  5. If still equal:
     - **nobody scores** announcements [FFB-RA], [WFR];
     - or the Player **earliest in rotation** wins [PAGAT].
- **Counting toward the contract.** Announcements count [FFB-RA §V.C], [PAGAT]. [WFR] and [PAGAT] list a variant where they do not.
- **When the taking Team is dedans**, the defenders score their own announcements plus the takers' [FFB-RA §V], [PAGAT].
- **On a capot**, the announcements of the Team that is capot either:
  - go to the winners [FFB-RA];
  - are forfeited [PAGAT];
  - or are kept by that Team [PAGAT variant], [WFR]. In that case the Team cannot put the takers dedans without winning a Trick.
- **Renonce.** If a Player cannot show what they announced, the opponents score it [FFB-RA §VII.D]. This does not apply when the server detects announcements.

**Sources.** [FFB-2016 §8 and closing note], [FFB-RA §V, §VII and annex], [PAGAT], [UNIV], [WFR], [BGA].

## 13. Dix de der

**Standard rule.** The Team that wins the last Trick scores 10 extra points, which brings the Deal total to 162. On a capot the 10 becomes 100 (§14).

**Common variations.** None found.

**Sources.** [FFB-2016 §9.1], [FFB-RA §III], [PAGAT], [UNIV], [BGA].

## 14. Capot

**Standard rule.**

- A Team that wins all 8 Tricks scores **252**: the 152 card points plus 100 in place of the dix de der.
- Belote is added on top (272 if the capot Team also has it).
- The other Team scores nothing except its own imprenable Belote.
- The same applies when the **defending Team** wins all 8 Tricks against the takers: it scores 252, plus any announcements.

**Common variations.**

- **Capot worth 250** rather than 252 [CARTA], [WFR]. [GM33 art. 4] and [MIOS art. 2] have to say "252 et non pas 250", which shows that 250 is common.
- **A taking Team that is capot is only dedans**, so the defenders score 162 [WFR].
- **The capot Team's Belote** goes to the winners (272) [MIOS], versus imprenable [FFB-RA §VII.A], [PDC art. 16].
- **The Game cannot be won on a capot.** [FFB-RA §VII.A] says a Team that is capot cannot reach the target on its Belote alone; it scores the 20, but one more Deal must be played. [WFR] calls this unofficial. [FFB-2016]'s closing note declares the variant "on ne finit pas sur un capot" void in sanctioned tournaments. The two FFB texts contradict each other here.
- **"Capot demandé"**: a capot called in advance is worth 500 (520 with Belote) [WFR, secondary]. This borders on coinche.

**Sources.** [FFB-2016 §9.2, §10.2], [FFB-RA §V], [FFB-R], [PAGAT], [BGA], [WFR], [CARTA], [GM33], [MIOS], [PDC].

## 15. Making the contract

**Standard rule (FFB).**

- The taking Team **makes** its contract if its total is **strictly greater** than the defending Team's. A total is card points, plus the dix de der, plus Belote (plus announcements if played).
- If the taking Team's total is strictly lower, it is **dedans** (§16).
- Equal totals are a **litige** (§17).
- When the contract is made, both Teams score what they took.

**Common variations.**

- **Ties go to the taking Team** ("at least as many points as the other team") [PAGAT main text]. [FFB-2016 §10.1.3] lets a tournament choose either outcome when it does not play litige.
- **Ties go to the defending Team**, meaning a tie is dedans [PAGAT variant].
- **Compare card points only**, excluding Belote and announcements:
  - the taking Team needs **82** or more card points [CARTA], [WFR §Modalités], [PDC art. 17], with 81 being litige;
  - or it needs 81 [PAGAT variant].

**Sources.** [FFB-2016 §10.1], [FFB-RA §V.C], [FFB-R], [PAGAT], [WFR], [CARTA], [PDC].

## 16. Dedans (the taking Team fails)

**Standard rule.**

- The taking Team scores **0**, except its own imprenable Belote.
- The defending Team scores **162** (252 if it made a capot), plus its own and the takers' announcements if those are played.

**Common variations.**

- **Belote "prenable"**: the defenders score 182 [MIOS], [WFR].
- **With rounding**, a dedans is often written as 160 [WFR], [CARTA].
- **The defenders score 250 for a chute** [WFR, secondary and isolated].

**Sources.** [FFB-2016 §10.1.2, §10.2], [FFB-RA §V], [FFB-R], [PAGAT], [WFR], [BGA], [PDC art. 17].

## 17. Litige (tie)

**Standard rule (FFB).**

- When both Teams' totals are equal (81–81, or 91–91 with Belote), the **defending Team scores its points at once**.
- The **taking Team's points are held over**. They go to the Team that wins the **next Deal**. [FFB-R] and [FFB-RA] put it as "offerts en bonus aux vainqueurs de la prochaine prise"; [FFB-2016] says "l'équipe réussissant le contrat de la donne suivante".
- Example from [WFR]: the taking Team A ties 81–81, so B scores 81 now. On the next Deal A is dedans, so B scores 162 + 81 = 243.
- The holder keeps its Belote. [BGA] says the held points exclude Belote, and [WFR] gives an example where they do.

**Common variations.**

- **No litige: each Team scores its own points** (81 each) [MIOS art. 5], [GM53 §8].
- **No litige on the last Deal** of a fixed-length Game: each Team scores 81 [GM33 art. 6], [PDC art. 15].
- **A tie is a made contract, or a tie is dedans** (§15). The FFB lets a tournament choose either instead of litige.
- **Pagat's abeyance variant**: the whole Deal (162 plus announcements) is held. If the previous taking Team wins the next Deal, each Team gets its tied share; otherwise the previous defenders get all of it [PAGAT].
- **Edge cases no source settles**:
  - a second consecutive litige (do the held points accumulate?);
  - held points still pending when the Game ends;
  - a passed Deal in between.

**Sources.** [FFB-2016 §10.1.3, §10.4.1], [FFB-RA §V], [FFB-R], [FFB-PC], [PAGAT], [WFR], [BGA], [GM33], [MIOS], [GM53], [PDC].

## 18. Rounding

**Standard rule.** **No rounding**; scores are kept to the point [FFB-RA §V] ("Il n'y a pas d'arrondi"), [GM33 art. 3] ("pas d'arrondi à 160").

**Common variations.**

- **Round each Team's score to the nearest 10, with 5 rounding up** (85 → 90, 84 → 80). This is a tournament option [FFB-2016 §10.3], [FFB-RA §V].
  - [FFB-PC] adds that scores are rounded except on the last Deal, and that rounding can carry a Team past the target.
  - Rounding each score separately can make the total 170 (for example 86/76 → 90/80).
- **The "160-total" convention.** Endings 1 to 5 round down and 7 to 9 round up. On a 6–6 split, the taking Team rounds down and the other Team rounds up [WFR].
- **Round to the nearest 5**, keeping a 160 total [WFR], [PAGAT].

**Sources.** [FFB-2016 §10.3, §10.4.2], [FFB-RA §V], [FFB-PC], [PAGAT], [WFR], [GM33].

## 19. Target score and Game end

**Standard rule.**

- The first Team to **reach or pass 1000** points wins. [PAGAT] gives 1000, [BGA]'s "Classic" length is 1000, [WFR] gives 1000, and [FFB-2016 §10.4.2] uses 1000 in its example. The FFB itself leaves the target to the organiser.
- **If both Teams pass the target in the same Deal**, the Team with more points wins. If they are exactly level, another Deal is played [FFB-2016 §10.4.2], [FFB-RA §V], [FFB-R], [WFR].
- Belote alone can bring a Team to the target [FFB-PC].

**Common variations.**

- **Other targets**:
  - 500 [BGA "Half-game"], [CARTA];
  - 1500 [CARTA];
  - 1001, or 1010 with rounding [WFR].
- **A fixed number of Deals instead of a target.** Tournaments use 12 counted Deals [GM33 art. 3], [MIOS art. 2], [GM53 §3], [PDC art. 6], [WFR]. [FFB-2016 §10.4.1] does not count a passed Deal toward the limit. [BGA] also offers a single-Deal Game.
- **Both Teams pass the target in the same Deal:**
  - it is a **draw** [PAGAT];
  - the **taking Team** wins [CARTA];
  - the **Team that won that Deal** wins [WFR].
- **No winning while capot** (§14).
- **"L'arrêt"**: after winning a Trick, a Player may claim their Team has reached the target. A wrong claim loses the Game [PAGAT variant]. This does not apply online, where the server keeps score.

**Sources.** [FFB-2016 §2, §10.4], [FFB-RA §V], [FFB-R], [FFB-PC], [PAGAT], [WFR], [BGA], [CARTA], [GM33], [MIOS], [GM53], [PDC].

## 20. Misdeals and irregularities (for completeness)

Over-the-table rules handle mistakes in three ways:

- misdeals: redeal, with penalties for repeated misdeals [FFB-RA §VIII.A];
- exposed cards: "toute carte montrée doit être jouée" [FFB-2016 §5.1];
- reviewing the last Trick: allowed only until the next Trick is gathered [FFB-2016 §5.1].

Most of this disappears online, because the server deals and rejects illegal plays. The one item that may still be worth deciding is **whether a Player may review the last Trick**.

---

## Variation points to decide

### For [Dealing, trump and legal card plays](https://github.com/alexandreruban/belote/issues/7)

1. **Direction**: anticlockwise (FFB) or clockwise.
2. **Shuffle**: a fresh shuffle each Deal (FFB), or the traditional gather-and-cut with no shuffle. Also decide whether a cut is simulated at all.
3. **First dealer**: by random draw, or by fixed seating.
4. **First packets**: 3+2, 2+3, or either. This is invisible online unless the no-shuffle tradition is simulated.
5. **Second trump-choosing round**: only the three other suits (FFB web pages, Pagat), or any suit including the turned card's suit.
6. **Nobody takes**: the next Player deals (FFB), or the same dealer redeals. Also decide whether to reject or adopt "la vache", "valet forcé" and the low-points and carré-of-7s redeals (recommended: reject all of them).
7. **Voluntarily trumping on a partner's winning trump**: any trump allowed, including a lower one (FFB); or overtrump if able, with a lower trump only when unable (Pagat).
8. **Undertrumping**: compulsory when an opponent has trumped and you cannot overtrump (standard), or optional. Also decide whether "on est toujours obligé de pisser" applies over a partner's trump (standard: no).
9. **Reviewing the last Trick** online: allowed or not.

These are not variation points; every source agrees:

- follow suit;
- go higher on a trump lead even over the partner;
- you must trump when the partner is not winning;
- you may trump or discard freely when the partner is winning;
- the first Trick is led by the Player after the dealer;
- the taker always receives the turned card.

### For [Deal scoring and Game end](https://github.com/alexandreruban/belote/issues/8)

1. **Belote/Rebelote**:
   - either card first, or the King must come first;
   - declared by the Player, or detected automatically. If declared, whether "Rebelote" must also be said;
   - imprenable or prenable;
   - whether it counts toward the contract comparison;
   - whether it stays with its holder in a litige.
2. **Announcements**: none (FFB, tournaments, BGA) or with announcements. If they are played, decide:
   - the values (tierce 20 or 30, carré values);
   - whether one card may be in two announcements;
   - automatic or declared;
   - the final tie-break: nobody scores, or the Player earliest in rotation;
   - whether they count toward the contract;
   - who gets them on a dedans and on a capot;
   - whether the carré-of-8s and carré-of-7s rules apply (recommended: no).
3. **Contract criterion**: totals compared strictly (FFB), or card points only (82 or more).
4. **Tie handling**: litige held over to the winner of the next Deal (FFB); each Team scores its own; a tie is made; or a tie is dedans. If litige is played, decide repeated litiges, held points still pending at Game end, and passed Deals.
5. **Capot**: worth 252 or 250. Decide also whether a taking Team that is capot is scored as a capot (252) or as a plain dedans (162), what happens to the capot Team's Belote and announcements, and whether a Team that is capot may win the Game on its Belote.
6. **Dedans** scoring: 162 plus the announcements of both Teams, with the takers' Belote either kept or given to the defenders.
7. **Rounding**: none (FFB standard), nearest 10, the 160-total convention, or nearest 5. Also decide whether the last Deal is rounded.
8. **Game length**: a target score (1000 standard; 500, 1001, 1500 seen) or a fixed number of Deals (12 in tournaments).
9. **Both Teams pass the target in the same Deal**: higher total wins with an extra Deal on an exact tie (FFB); a draw; the taking Team wins; or the Team that won that Deal wins.

---

## Sources

All sources were retrieved on 2026-10-19.

- **[FFB-2016]** Fédération Française de Belote, *Règles officielles de belote*, version of 27 January 2016 (PDF, 8 pp.). <https://www.ffbelote.org/wp-content/uploads/2016/01/regles-officielles-de-la-Belote-27-01-2016.pdf>
- **[FFB-RA]** Fédération Française de Belote, *Règlement officiel de la belote avec ou sans annonce* (web regulation, includes the announcements, discipline and *sans annonces* annexes). <https://www.ffbelote.org/reglements-de-la-belote-avec-ou-sans-annonce/>
- **[FFB-R]** Fédération Française de Belote, *Les règles officielle de la Belote* (summary page). <https://www.ffbelote.org/regles-officielle-belote/>
- **[FFB-PC]** Fédération Française de Belote, *Points-clés des règles officielles à expliquer par les organisateurs* (PDF, 1 p.). <https://www.ffbelote.org/documents/Points-cles-des-regles-officielles-a-expliquer-par-les-organisateurs.pdf>
- **[PAGAT]** J.-P. Coulon, ed. N. Wedd and J. McLeod, *Belote*, pagat.com, last updated 24 June 2018. <https://www.pagat.com/jass/belote.html>
- **[UNIV]** Thierry Depaulis, "Belote", *Encyclopædia Universalis*. <https://www.universalis.fr/encyclopedie/belote/>
- **[CARTA]** Cartamundi (France Cartes), *Belote* rules leaflet, section "La belote classique — version sans enchère" (2017). <https://cartamundi.fr/app/uploads/2018/06/729710_notice_belote-1.pdf>
- **[BGA]** Board Game Arena, *Gamehelpbelote* (last edited 1 March 2024). <https://en.doc.boardgamearena.com/Gamehelpbelote>
- **[GM33]** Générations Mouvement, Fédération de Gironde, *Règlement des concours de belote*. <https://lotetgaronne.generations-mouvement.org/wp-content/uploads/2023/09/Reglement-belote-FD-33-1.pdf>
- **[MIOS]** Élan Miossais (Générations Mouvement Gironde), *Règlement concours de belote*. <https://gironde.generations-mouvement.org/wp-content/uploads/2024/11/Reglement-belote-Elan-Miossais.pdf>
- **[GM53]** Générations Mouvement Mayenne, *Règlement du concours de belote sans annonces* (5 February 2021). <https://mayenne.generations-mouvement.org/wp-content/uploads/2022/08/belote-reglement-concours-1.pdf>
- **[PDC]** Twirl Danse Pont-de-Claix, *Règlement concours de belote* (2024). <https://www.pontdeclaix.fr/sites/default/files/2024-01/65a68d18ab985_rglementconcoursdebelote.pdf>
- **[WFR]** Wikipédia (fr), *Belote* (secondary; page flagged *à sourcer*). <https://fr.wikipedia.org/wiki/Belote>
- **[WEN]** Wikipedia (en), *Belote* (secondary). <https://en.wikipedia.org/wiki/Belote>
