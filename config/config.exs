# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :haiku,
    delimiter: '-',
    range: 9999

import_config "adjectives.exs"
import_config "nouns.exs"
