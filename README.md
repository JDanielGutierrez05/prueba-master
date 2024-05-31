# README

- [README](#readme)
  - [Summary](#summary)
    - [Development container](#development-container)
    - [Note](#note)
  - [Glossary](#glossary)
    - [Petitions examples on Curl format](#petitions-examples-on-curl-format)

---

## Summary

`Prueba Master` this is a challenge.

---

### Development container

This steps are tailored to work with Visual Studio Code, but you are free to chose a different IDE and make necessary adjustments to the setup.

1. Install Visual Studio Code [here](https://code.visualstudio.com/)
2. Install Docker desktop [here](https://code.visualstudio.com/)
3. Install `ms-vscode-remote.remote-containers` extension. If you don't know how to do that follow this steps: <https://code.visualstudio.com/docs/editor/extension-gallery#_install-an-extension>
4. Open this project's folder in Visual Studio Code. The extension will detect a container configuration and will ask you if you want to reopen the project un the container. Accept. (this build develop container and mongodb container to use it as storage)
5. after container build finish, you can execute `npm run start` in terminal to start the app.

### Note

If your prefer to not install all tools mentioned on the previous steps, just open a terminal into the project folder and execute the command in 5 step (Need Nodejs v18 or higher).

---

## Glossary

### Petitions examples on Curl format

```env
curl --location 'http://localhost:3000/index'
```
