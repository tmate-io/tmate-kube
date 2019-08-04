k8s_yaml('ssh-keys-dev.yaml')
k8s_yaml('session-server.yaml')

docker_build('tmate/tmate-ssh-server', '../tmate-ssh-server',
             dockerfile='../tmate-ssh-server/Dockerfile.dev',
             live_update=[fall_back_on(['../tmate-ssh-server/Makefile.am']),
                          sync('../tmate-ssh-server', '/src/tmate-ssh-server'),
                          run('make -j "$(nproc)"'),
                          restart_container()]
)

docker_build('tmate/tmate-proxy', '../tmate-proxy',
             dockerfile='../tmate-proxy/Dockerfile.dev',
             live_update=[fall_back_on(['../tmate-proxy/mix.exs', '../tmate-proxy/mix.lock']),
                          sync('../tmate-proxy', '/src/tmate-proxy'),
                          run('echo recompile >> console')]
)

k8s_resource('session-server', port_forwards=['2222:22',4001])
