let
  wash = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIINpkjlRIlhvQhBM54u+1jbuH3cNesjb+9xyUfTz7/O9";
  wyatt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJvI27JrNE4d90nePxI0jzJrpUA6pecuBONusQpuEfuP";
  users = [ wash wyatt ];

  anubis = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFE4rG9LOLWZJq38YRZlK7lNK3lL8HYRn61sgp6CrDcJ";
  neptune = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJeno7kGL0KKvPzaqLyP3TyXqUkM3M0Lphk9r94hut5t";
  zelda = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQ/40iaZdCUOK24lAyPmyt1SJVaLKGQK50FZCm5Mzbt";
  nixmacVM = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4dWVZcNnAXGKgF0ZlzGCIkD93pODqU05qH7RzhPIWv";
  systems = [ anubis neptune zelda nixmacVM ];
in
{
#  "secret1.age".publicKeys = [ wash anubis ];
"secrets.age".publicKeys = users ++ systems;
"tailscale_key.age".publicKeys = users ++ systems;
"washpw.age".publicKeys = [ wash ] ++ systems;
}
