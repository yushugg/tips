def register(request):
	if request.method == 'POST':
		captcha_error = ""
		captcha_response = captcha.submit(
		request.POST.get("recaptcha_challenge_field", None),
		request.POST.get("recaptcha_response_field", None),
		settings.RECAPTCHA_PRIVATE_KEY,
		request.META.get("REMOTE_ADDR", None))
		if not captcha_response.is_valid:
			captcha_error = "&error=%s" % captcha_response.error_code
			c = {}
			c.update(csrf(request))
			c['repetir'] = True
			c['header'] = "register"
			return render_to_response('register.html', c, context_instance=RequestContext(request))
		else:
			if error_register(request):
				c = {}
				c.update(csrf(request))
				c['repetir'] = True
				c['header'] = "register"
				return render_to_response('register.html', c, context_instance=RequestContext(request))
			else:
				username = clean_username(request.POST['user'])
				password = request.POST['password']
				email = request.POST['email']
				user = User.objects.create_user(username, email, password)
				user.is_active = False
				user.save()
				confirmation_code = ''.join(tehrandom.choice(string.ascii_uppercase + string.digits + string.ascii_lowercase) for x in range(33))
				p = Profile(user=user, confirmation_code=confirmation_code)
				p.save()
				send_registration_confirmation(user)
				return HttpResponseRedirect('../../../../../')
	else:
		c = create_c(request)
		c['header'] = "register"
		return render_to_response('register.html', c, context_instance=RequestContext(request))

def send_registration_confirmation(user):
	p = user.get_profile()
	title = "Gsick account confirmation"
	content = "http://www.gsick.com/confirm/" + str(p.confirmation_code) + "/" + user.username
	send_mail(title, content, 'no-reply@gsick.com', [user.email], fail_silently=False)

def confirm(request, confirmation_code, username):
	try:
		user = User.objects.get(username=username)
		profile = user.get_profile()
		if profile.confirmation_code == confirmation_code and user.date_joined > (datetime.datetime.now()-datetime.timedelta(days=1)):
			user.is_active = True
			user.save()
			user.backend='django.contrib.auth.backends.ModelBackend' 
			auth_login(request,user)
		return HttpResponseRedirect('../../../../../')
	except:
		return HttpResponseRedirect('../../../../../')

def error_register(request):
	username = request.POST['user']
	password = request.POST['password'] 
	email = request.POST['email'] 
	if not clean_username(username):
		return True
	if username.replace(" ", "") == "" or password.replace(" ", "") == "":
		return True
	if len(username) > 15 or len(password) > 50:
		return True
	if not "@" in email:
		return True
	try:
		if User.objects.get(username=username):
			return True
	except:
		pass
