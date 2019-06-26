Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports Microsoft.AspNet.Identity
Imports Microsoft.AspNet.Identity.EntityFramework
Imports Battelle.ApplicationDbContext


Public Class RoleActions

    Public Sub createAdmin()
        ' Access the application context and create result variables.
        Dim context As Battelle.ApplicationDbContext = New ApplicationDbContext()
        Dim IdRoleResult As IdentityResult
        Dim IdUserResult As IdentityResult

        ' Create a RoleStore object by using the ApplicationDbContext object. 
        ' The RoleStore is only allowed to contain IdentityRole objects.
        Dim roleStore = New RoleStore(Of IdentityRole)(context)

        ' Create a RoleManager object that is only allowed to contain IdentityRole objects.
        ' When creating the RoleManager object, you pass in (as a parameter) a new RoleStore object. 
        Dim roleMgr = New RoleManager(Of IdentityRole)(roleStore)

            ' Then, you create the "Administrator" role if it doesn't already exist.
            If Not roleMgr.RoleExists("Administrator") Then
                IdRoleResult = roleMgr.Create(New IdentityRole("Administrator"))
                ' Handle the error condition if there's a problem creating the RoleManager object.
                If Not IdRoleResult.Succeeded Then
                End If
            End If



        ' Create a UserManager object based on the UserStore object and the ApplicationDbContext  
        ' object. Note that you can create new objects and use them as parameters in
        ' a single line of code, rather than using multiple lines of code, as you did
        ' for the RoleManager object.
        Dim userMgr = New UserManager(Of ApplicationUser)(New UserStore(Of ApplicationUser)(context))
        Dim appUser = New ApplicationUser()
        appUser.UserName = "Admin"

        IdUserResult = userMgr.Create(appUser, "Pa$$word")

        ' If the new "Admin" user was successfully created, 
        ' add the "Admin" user to the "Administrator" role. 
        If IdUserResult.Succeeded Then
            IdUserResult = userMgr.AddToRole(appUser.Id, "Administrator")
            ' Handle the error condition if there's a problem adding the user to the role.
            If Not IdUserResult.Succeeded Then
            End If
            ' Handle the error condition if there's a problem creating the new user. 
        Else
        End If
    End Sub

    Public Sub createRole(sRole As String)
        'Create the a Role (Program Chair, etc)
        ' Access the application context and create result variables.
        Dim context As Battelle.ApplicationDbContext = New ApplicationDbContext()
        Dim IdRoleResult As IdentityResult

        ' Create a RoleStore object by using the ApplicationDbContext object. 
        ' The RoleStore is only allowed to contain IdentityRole objects.
        Dim roleStore = New RoleStore(Of IdentityRole)(context)

        ' Create a RoleManager object that is only allowed to contain IdentityRole objects.
        ' When creating the RoleManager object, you pass in (as a parameter) a new RoleStore object. 
        Dim roleMgr = New RoleManager(Of IdentityRole)(roleStore)

        ' Then, you create the "Administrator" role if it doesn't already exist.
        If Not roleMgr.RoleExists(sRole) Then
            IdRoleResult = roleMgr.Create(New IdentityRole(sRole))
            ' Handle the error condition if there's a problem creating the RoleManager object.
            If Not IdRoleResult.Succeeded Then
            End If
        End If

 


    End Sub

    Public Sub addUsertoRole(sUserID, sRole)

        Dim context As Battelle.ApplicationDbContext = New ApplicationDbContext()
        Dim IdUserResult As IdentityResult

        Dim roleStore = New RoleStore(Of IdentityRole)(context)


        'Add an existing user to a role
        Dim userMgr = New UserManager(Of ApplicationUser)(New UserStore(Of ApplicationUser)(context))
        Dim appUser = New ApplicationUser()
        appUser.Id = sUserID

        IdUserResult = userMgr.AddToRole(appUser.Id, sRole)
        ' Handle the error condition if there's a problem adding the user to the role.
        If Not IdUserResult.Succeeded Then
        End If


    End Sub

    Public Sub createUser()
        'Create new users - so Admins can create logins for reviewers
    End Sub

End Class


