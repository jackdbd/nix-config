{
  enable-activity-web-watcher ? true,
  enable-adblock ? true,
  enable-consent-o-matic ? true,
  enable-google-arts-and-culture ? true,
  enable-notion-boost ? true,
  enable-octotree ? true,
  enable-sponsorblock ? true,
  enable-terms-of-service-didnt-read ? true,
  enable-tmetric ? true,
}:
[
  # 1Password
  {id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";}
  # Lastpass
  {id = "hdokiejnpimakedhajhdlcegeplioahd";}
  # Modern for Hacker News
  {id = "dabkegjlekdcmefifaolmdhnhdcplklo";}
  # Vimium
  {id = "dbepggeogbaibhgnhhndojpepiihcmeb";}
]
++ (
  if enable-activity-web-watcher
  then [{id = "nglaklhklhcoonedhgnpgddginnjdadi";}]
  else []
)
++ (
  if enable-adblock
  then [{id = "gighmmpiobklfepjocnamgkkbiglidom";}]
  else []
)
++ (
  if enable-consent-o-matic # Automatic handling of GDPR consent forms
  then [{id = "mdjildafknihdffpkfmmpnpoiajfjnjd";}]
  else []
)
++ (
  if enable-google-arts-and-culture
  then [{id = "akimgimeeoiognljlfchpbkpfbmeapkh";}]
  else []
)
++ (
  if enable-notion-boost
  then [{id = "eciepnnimnjaojlkcpdpcgbfkpcagahd";}]
  else []
)
++ (
  if enable-octotree # (GitHub code tree)
  then [{id = "bkhaagjahfmjljalopjnoealnfndnagc";}]
  else []
)
++ (
  if enable-sponsorblock # skip over sponsors or other annoying parts of YouTube videos
  then [{id = "mnjggcdmjocbbbhaepdhchncahnbgone";}]
  else []
)
++ (
  if enable-terms-of-service-didnt-read # Get information instantly about websites' terms of service and privacy policies, with ratings and summaries from the www.tosdr.org.
  then [{id = "hjdoplcnndgiblooccencgcggcoihigg";}]
  else []
)
++ (
  if enable-tmetric # (time tracker)
  then [{id = "ffijoclmniipjbhecddgkfpdafpbdnen";}]
  else []
)
