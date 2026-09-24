import { LoaderUtils } from 'three';

if (typeof LoaderUtils.decodeText !== 'function') {
    LoaderUtils.decodeText = (array) => new TextDecoder().decode(array);
}
