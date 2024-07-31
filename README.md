# eventfetch
automated event flyers using neo(wo)fetch

## requirements

- `imagemagick`
- terminal with sixel support

the script will automatically download `neowofetch` from `hyfetch`'s site

## usage

- run `./eventfetch.sh`
- follow the interactive prompts
- take a screenshot of your terminal
- done!

### using env vars
alternatively, you can answer the prompts as environment variable values. here
are the possible values:

- `$EVENT_IMG`
- `$EVENT_TITLE`
- `$EVENT_DATE`
- `$EVENT_TIME`
- `$EVENT_ROOM`
- `$EVENT_CONTACT`
- `$EVENT_DISCORD`
- `$EVENT_WEBSITE`
- `$EVENT_DESC` (newline separated, trailing newline needed for last line to be
  included)

any variables left empty will be prompted for (`EVENT_IMG`, `EVENT_ROOM`,
`EVENT_CONTACT`, `EVENT_WEBSITE`, and `EVENT_DISCORD` have default interactive
prompt values for convenience)
