# 世の中 : Yononaka

## Breakdown of the Name

世の中 means "society," "the world," or "the times" in Japanese.

- 世 ( yo ): The world, life, or an era/generation.
- の ( no ): A possessive or connective particle ( "of" ) -- technically hiragana.
- 中 ( naka ): Inside, middle, or midst.
Together, yo no naka literally translates to "the middle of the world/society," referring to human society, public life, or the general state of the world.

This is an agent-based model engine written in Raku.  If you have used NetLogo, you will find some things familiar and some things not ... but you will have the idea.

## Agent-based Modelling

An agent-based model ( ABM ) is a computer simulation that studies how autonomous individual entities—called agents—interact with each other and their environment to produce large-scale system patterns.

### Core Components of an ABM

- *Agents*: The independent decision-makers. They can be people ( consumers, citizens, patients ), animals ( birds, fish ), vehicles, companies, or software programs. Each agent has its own traits and behavioral rules.
- *Environment*: The space or network in which agents live, move, and interact ( such as a geographic map, a social network, or a grid. )
- *Interactions*: The rules or protocols governing how agents talk to, trade with, avoid, or influence one another and their surroundings.
- *Emergence*: The macro-level patterns, trends, or chaos that "emerge" from the collective micro-level actions of individual agents ( much like how single birds flying together create a coordinated flock. )

## Prerequisites

- Rakudo supporting Raku 6.d
- zef

## Installation

- `zef install .` from source, or ..
- 'zef install Yononaka`

## Layout

- `lib/`
- `t/`

## Testing

- `zef test .`
- `prove6 -Ilib t/`

## Installation

- `zef install .`

