def roles_context_processor(request):
    role = None
    if request.user.is_superuser:
        role = 'administrador'
    elif request.user.is_authenticated:
        role = 'cliente'
    elif request.user.is_authenticated:
        role = 'bodeguero'
    elif request.user.is_authenticated:
        role = 'vendedor'
    elif request.user.is_authenticated:
        role = 'tesorero'
    else:
        role = 'invitado'
    return {'role': role}
