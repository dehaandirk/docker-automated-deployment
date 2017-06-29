repo/my_app:  
  dockerng.image_present:
    - force: true
    - name: repo/my_app:latest

my_app:  
  dockerng.running:
    - name: my_adpp
    - image: repo/my_app:latest
    - port_bindings: 80:80