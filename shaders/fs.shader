#version 330 compatibility

varying vec3 N;
varying vec3 v;
void main(void)
{
	//vec3 L = normalize(gl_LightSource[0].position.xyz - v);
	vec3 L = normalize(vec3(0.0,1.0,0.0) - v);
	vec3 E = normalize(-v); // we are in Eye Coordinates, so EyePos is (0,0,0)  
	vec3 R = normalize(-reflect(L, N));

	//calculate Ambient Term:  
	vec4 Iamb = vec4(1.0, 0.0, 0.0, 1.0);	//Ambient colour

	//calculate Diffuse Term:  
	vec4 Idiff = vec4(0.0, 1.0, 0.0, 1.0)	//diffuse colour
		* max(dot(N, L), 0.0); 
	Idiff = clamp(Idiff, 0.0, 1.0);

	// calculate Specular Term:
	vec4 Ispec = vec4(0.0, 0.0, 1.0, 1.0)	//specular colour
		* pow(max(dot(R, E), 0.0), 0.3 * 
			1.0);							//specular shinyness
	Ispec = clamp(Ispec, 0.0, 1.0);

	// write Total Color:  
	gl_FragColor = vec4(0.1, 0.1, 0.1, 1.0)	//scene Color
		+ Iamb + Idiff + Ispec;
}