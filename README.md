# Web Framework Comparison for FinTech

A comparison of various web frameworks and languages for typical realworld financial web applications.

It is not intended that this comparison will come to a conclusion with a definitive "best" framework for building fintech apps. Instead it aims to provide a concrete real world baseline and support for discussion around the right choice for your specific company, project and team.

For each framework there is a breakdown of benchmark figures, a list of notable dependencies.

Each app has been built with typical dependencies that would be chosen for a real world app. Projects are not built with just the raw framework or language itself, so this serves as a comparison of the common ecosystem surrounding each.

Project template generators are used, such as [create-react-app](#), however full featured higher-order frameworks such as [Next.js](#) are treated separately.

Please remember, at the end of the day there is no absolute right or wrong framework, there is only the best fit for your team and your project.

## Features of a FinTech App

- Big grids of data, often virtualised, sometimes editable
- Charts, sparklines and more
- Streaming data, websockets of the latest prices and positions

## Frameworks & Languages

In alphabetical order, the technologies used are:

- [Angular](#Angular)
- [Elm](#Elm)
- [Imba](#Imba)
- [React](#React)
- [Svelte](#Svelte)
- [Vue](#Vue)

### Angular

https://angular.io/

...

### Elm

https://elm-lang.org/

**Setup**

```
npm i -g create-elm-app
create-elm-app elm
```

**Getting Started**

```
cd elm
elm-app start
```

**Dependencies**

- [elm-ui](#)

### Imba

http://imba.io/

...

### React

https://reactjs.org/

**Dependencies**

- [create-react-app](#)
- [react-router](#)

### Svelte

https://svelte.dev/

**Setup**

```
npx degit sveltjs/template svelte
```

**Getting Started**

```
cd svelte
npm install
npm run dev
```

### Vue

https://vuejs.org/

**Setup**

```
npm i -g @vue/cli
vue create vue
```

**Getting Started**

```
cd vue
npm install
npm run serve
```
