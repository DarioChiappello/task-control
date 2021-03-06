<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use App\Entity\User;
use App\Form\RegisterType;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

class UserController extends AbstractController
{
    
    public function register(Request $request, UserPasswordEncoderInterface $encoder)
    {
        
        // crear formulario
        $user = new User();
        $form = $this->createForm(RegisterType::class, $user);
        
        //rellenar el objeto con datos
        $form->handleRequest($request);
        
        //comprobar si el formulario se envio
        if($form->isSubmitted() && $form->isValid()){
            //modificar el objeto para guardarlo
            $user->setRole('ROLE_USER');
            
            $user->setCreatedAt(new \Datetime('now'));
            
            //cifrar password
            $encoded = $encoder->encodePassword($user, $user->getPassword());
            $user->setPassword($encoded);
            
            //guardar usuario
            $em = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();
            
            return $this->redirectToRoute('tasks');
            
        }

        return $this->render('user/register.html.twig', [
            'form' => $form->createView()
        ]);
    }
    
    public function login(AuthenticationUtils $authenticatioUtils){
        $error = $authenticatioUtils->getLastAuthenticationError();
        
        $lastUsername = $authenticatioUtils->getLastUsername();
        
        return $this->render('user/login.html.twig', array(
            'error' => $error,
            'last_username' => $lastUsername
        ));
    }
}
